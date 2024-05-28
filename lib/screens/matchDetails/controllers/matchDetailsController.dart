import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:score_keeper/components/buttons/baseButton.dart';
import 'package:score_keeper/components/custom/conditionalImage.dart';
import 'package:score_keeper/components/custom/tagsSuggestionView.dart';
import 'package:score_keeper/components/textFields/baseTextField.dart';
import 'package:score_keeper/components/textFields/tagsTextField.dart';
import 'package:score_keeper/di/serializers/serializers.dart';
import 'package:score_keeper/di/services/match/matchService.dart';
import 'package:score_keeper/di/services/players/playerService.dart';
import 'package:score_keeper/models/matchStatusEnum.dart';
import 'package:score_keeper/models/tagsModel.dart';
import 'package:score_keeper/screens/home/controllers/homeController.dart';
import 'package:score_keeper/screens/matchDetails/models/addGoalModel.dart';
import 'package:score_keeper/screens/matchDetails/models/goalModel.dart';
import 'package:score_keeper/screens/matchDetails/models/scoreTypeModel.dart';
import 'package:score_keeper/screens/matchDetails/models/updatePlayersRequest.dart';
import 'package:score_keeper/screens/matchDetails/models/updateStatusModel.dart';
import 'package:score_keeper/screens/matchesTabs/controllers/matchesTabController.dart';
import 'package:score_keeper/screens/matchesTabs/models/matchModel.dart';
import 'package:score_keeper/screens/playerList/components/positionDropDown.dart';
import 'package:score_keeper/screens/playerList/controllers/playerListController.dart';
import 'package:score_keeper/screens/playerList/models/addTagsModel/addTagsModel.dart';
import 'package:score_keeper/screens/playerList/models/playerModels/addPlayerRequestModel.dart';
import 'package:score_keeper/screens/playerList/models/playerModels/player.dart';
import 'package:score_keeper/screens/playerList/models/positionModels/positionsModel.dart';
import 'package:score_keeper/screens/shareDetails/views/shareDetailsView.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/firebaseMessagingUtils.dart';
import 'package:score_keeper/utils/utils.dart';
import 'package:built_collection/built_collection.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:textfield_tags/textfield_tags.dart';

class MatchDetailsController extends GetxController {
  final lineUpPlayers = Rx<List<Player>>([]);
  final substitutePlayers = Rx<List<Player>>([]);
  TextEditingController mintController = TextEditingController();
  final mintError = Rxn<String>();
  RxBool isSecondaryTeam = false.obs;
  final playerId = Rxn<int>(0);
  final assistedPlayer = Rxn<int>(0);
  final matchModel = Rxn<MatchModel>();
  final matchStatus = MatchStatusEnum.NOT_STARTED.obs;
  RxInt timeElapsed = 0.obs;
  Timer? timer;
  final STATUS = API_STATUS.IDLE.obs;
  MatchService matchService = Get.find();
  final UPDATE_STATUS = API_STATUS.IDLE.obs;
  MatchesTabController matchesTabController = Get.find();
  int matchId = 0;
  final goals = Rx<List<GoalModel>>([]);
  final currentEditGoalId = Rxn<int>();
  final scoreTypeId = Rxn<int>();
  final scoreTypes = Rx<List<ScoreTypeModel>>([]);
  final GOAL_STATUS = API_STATUS.IDLE.obs;
  final isDelete = false.obs;
  final allPlayers = Rx<List<Player>>([]);
  ScreenshotController screenshotController = ScreenshotController();
  FROM_SCREEN fromScreen = FROM_SCREEN.MATCH_LIST;
  HomeController homeController = Get.find();
  TextEditingController playerNameController = TextEditingController();
  final playerNameError = Rxn<String>();
  final positions = Rxn<List<PositionsModel>>();
  final currentSelectedPosition = Rxn<int>();
  final ADD_PLAYER_STATUS = API_STATUS.IDLE.obs;
  PlayerService playerService = Get.find();
  final showFloatingActionButton = true.obs;
  PlayerListController playerListController = Get.find();
  final playerProfileImage = Rxn<XFile>();
  TextEditingController playerTagsTextEditingController =
  TextEditingController();
  TextfieldTagsController playerTagsController = TextfieldTagsController();
  // final tags = Rx<List<TagsModel>>([]);
  // final filteredTags = Rx<List<TagsModel>>([]);
  // final tagsFromApi = Rx<List<String>>([]);

  setCurrentSelectedPosition(dynamic newVal) =>
      currentSelectedPosition.value = newVal;

  @override
  void onReady() {
    Map<String, String?> data = Get.parameters;
    matchId = int.parse(data['matchId'] as String);
    if (data['fromScreen'] != null) {
      fromScreen = FROM_SCREEN.values
          .where((element) => element.toString() == data['fromScreen'])
          .first;
    }
    positions.value = playerListController.positions.value;
    scoreTypes.value = matchesTabController.scoreTypes.value;
    // tags.value = playerListController.tags.value;
    // filteredTags.value = playerListController.tags.value;
    //
    // playerTagsTextEditingController.addListener(() {
    //   filterTags();
    // });
    getMatchPlayers();
    super.onReady();
  }

  void onCloseAddEditBottomSheet() {
    mintController.text = '';
    mintError.value = null;
    isSecondaryTeam.value = false;
    currentEditGoalId.value = null;
    scoreTypeId.value = null;
    playerId.value = null;
    assistedPlayer.value = null;
  }

  void setScoreType(int id) => scoreTypeId.value = id;

  void setMintError(String? err) => mintError.value = err;

  void getMatchSummary(bool isUpdateMatches) async {
    final matchSummaryResponse = await matchService.getMatchSummery(matchId);

    if (matchSummaryResponse.isSuccessful) {
      matchModel.value = matchSummaryResponse.body!;
      goals.value = matchModel.value!.goals.toList();
    } else {
      var error = matchSummaryResponse.error as Map<String, dynamic>;
      Utils.showErrorBottomSheet(
          message: error['message'],
          onOkayPress: () {
            Get.back();
          });
    }

    if (isUpdateMatches) {
      if (fromScreen == FROM_SCREEN.TEAM_LIST) {
        homeController.setMatchModel(matchModel.value!);
      }
      matchesTabController.getAllMatches();
    }
  }

  void onResumeCallBack() {
    timeElapsed.value = getElapsedTime();
    if (matchStatus.value == MatchStatusEnum.STARTED ||
        matchStatus.value == MatchStatusEnum.RESUME) {
      startTimer();
    }

    if (matchModel.value!.status == MatchStatusEnum.IN_PROGRESS) {
      int minutes = (timeElapsed.value / 60).floor();

      if (minutes <= 20) {
        FirebaseMessagingUtils.cancelScheduleMatchInProgressNotification();
      }

      if (minutes <= 40) {
        FirebaseMessagingUtils.cancelScheduleMatchInProgressNotification2();
      }
    }
  }

  void onPauseCallBack() {
    if (matchStatus.value == MatchStatusEnum.STARTED ||
        matchStatus.value == MatchStatusEnum.RESUME) {
      stopTimer();
    }
  }

  void getMatchPlayers() async {
    STATUS.value = API_STATUS.LOADING;

    final matchSummaryResponse = await matchService.getMatchSummery(matchId);

    if (matchSummaryResponse.isSuccessful) {
      matchModel.value = matchSummaryResponse.body!;
      goals.value = matchModel.value!.goals.toList();

      final response =
          await matchService.getMatchPlayers(matchModel.value!.matchId);

      timeElapsed.value = getElapsedTime();
      matchStatus.value = matchModel.value!.progress!;

      if (matchStatus.value == MatchStatusEnum.STARTED ||
          matchStatus.value == MatchStatusEnum.RESUME) {
        startTimer();
      }

      if (response.isSuccessful) {
        List<Player> list = response.body!.data.toList();

        substitutePlayers.value =
            list.where((element) => element.type == 'substitute').toList();
        lineUpPlayers.value =
            list.where((element) => element.type == 'lineup').toList();

        allPlayers.value.addAll(lineUpPlayers.value);
        allPlayers.value.addAll(substitutePlayers.value);
        allPlayers.value.sort((a, b) => a.name.compareTo(b.name));
        allPlayers.value.insert(
            0,
            Player((b) => b
              ..playerId = 0
              ..name = 'Select Player'));

        STATUS.value = API_STATUS.SUCCESS;
      } else {
        substitutePlayers.value = [];
        lineUpPlayers.value = [];
        STATUS.value = API_STATUS.SUCCESS;
      }
    } else {
      var error = matchSummaryResponse.error as Map<String, dynamic>;
      Utils.showErrorBottomSheet(message: error['message']);
    }
  }

  void getSilentMatchPlayers() async {
    final response =
        await matchService.getMatchPlayers(matchModel.value!.matchId);

    if (response.isSuccessful) {
      List<Player> list = response.body!.data.toList();

      substitutePlayers.value =
          list.where((element) => element.type == 'substitute').toList();
      lineUpPlayers.value =
          list.where((element) => element.type == 'lineup').toList();

      allPlayers.value.clear();
      allPlayers.value.addAll(lineUpPlayers.value);
      allPlayers.value.addAll(substitutePlayers.value);
      allPlayers.value.sort((a, b) => a.name.compareTo(b.name));
      allPlayers.value.insert(
          0,
          Player((b) => b
            ..playerId = 0
            ..name = 'Select Player'));

      STATUS.value = API_STATUS.SUCCESS;
    } else {
      substitutePlayers.value = [];
      lineUpPlayers.value = [];
      STATUS.value = API_STATUS.SUCCESS;
    }
  }

  int getElapsedTime() {
    if (matchModel.value!.progress == MatchStatusEnum.STARTED ||
        matchModel.value!.progress == MatchStatusEnum.RESUME) {
      int diff = DateTime.now()
          .difference(
              DateTime.fromMillisecondsSinceEpoch(matchModel.value!.timer!))
          .inSeconds;
      if (diff >= Utils.MAX_ELAPSED_TIME) {
        return Utils.MAX_ELAPSED_TIME;
      } else {
        return diff;
      }
    } else if (matchModel.value!.progress == MatchStatusEnum.PAUSED ||
        matchModel.value!.progress == MatchStatusEnum.COMPLETED) {
      int elapsed = (matchModel.value!.timer! / 1000).round();
      if (elapsed >= Utils.MAX_ELAPSED_TIME) {
        return Utils.MAX_ELAPSED_TIME;
      } else {
        return elapsed;
      }
    } else {
      return 0;
    }
  }

  void setIsSecondaryTeam(bool team) => isSecondaryTeam.value = team;

  void setSelectedPlayer(dynamic player) => playerId.value = player;

  void setSelectedAssistedPlayer(dynamic assistedPlayerId) =>
      assistedPlayer.value = assistedPlayerId;

  void setMatchStatus(MatchStatusEnum val) => matchStatus.value = val;

  void setCurrentEditGoalId(int goalId) => currentEditGoalId.value = goalId;

  void addToLineUpPlayers(Player player) {
    List<Player> filtered = substitutePlayers.value
        .where((element) => element.playerId != player.playerId)
        .toList();
    List<Player> tempLineUp = lineUpPlayers.value;
    tempLineUp.add(player);
    lineUpPlayers.value = tempLineUp;
    substitutePlayers.value = filtered;
  }

  void removeFromLineUp(Player player) {
    List<Player> filtered = lineUpPlayers.value
        .where((element) => element.playerId != player.playerId)
        .toList();
    List<Player> tempSub = substitutePlayers.value;
    tempSub.add(player);
    substitutePlayers.value = tempSub;
    lineUpPlayers.value = filtered;
  }

  void startTimer() {
    if (timeElapsed.value < Utils.MAX_ELAPSED_TIME && timer == null) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        timeElapsed.value = timeElapsed.value + 1;
        if (timeElapsed.value == Utils.MAX_ELAPSED_TIME) {
          timer.cancel();
        }
      });
    }
  }

  void stopTimer() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
  }

  void startMatch() async {
    UPDATE_STATUS.value = API_STATUS.LOADING;
    UpdateStatusModel updateStatusModel =
        UpdateStatusModel((b) => b..elapsedInSeconds = getEpochToSend());
    final response = await matchService.updateMatchStatus(
        matchModel.value!.matchId, MatchStatusEnum.STARTED, updateStatusModel);
    if (response.isSuccessful) {
      UPDATE_STATUS.value = API_STATUS.SUCCESS;
      matchStatus.value = MatchStatusEnum.IN_PROGRESS;
      matchModel.value = response.body!;
      timeElapsed.value = getElapsedTime();
      FirebaseMessagingUtils.scheduleMatchInProgressNotification(
          "Your Match in Progress - ${matchModel.value!.primaryTeamName} Vs ${matchModel.value!.secondaryTeamName}. Don't Miss Out!");
      FirebaseMessagingUtils.scheduleMatchInProgressNotification2(
          "Your Match in Progress - ${matchModel.value!.primaryTeamName} Vs ${matchModel.value!.secondaryTeamName}. Don't Miss Out!");
      startTimer();
      matchesTabController.getAllMatches();
      if (fromScreen == FROM_SCREEN.TEAM_LIST) {
        homeController.setUpdateTeamMatches(true);
      }
    } else {
      UPDATE_STATUS.value = API_STATUS.ERROR;
      var error = response.error as Map<String, dynamic>;
      Utils.showErrorBottomSheet(message: error['message']);
    }
  }

  void endMatch() async {
    UPDATE_STATUS.value = API_STATUS.LOADING;
    UpdateStatusModel updateStatusModel = UpdateStatusModel(
        (b) => b..elapsedInSeconds = timeElapsed.value * 1000);
    final response = await matchService.updateMatchStatus(
        matchModel.value!.matchId,
        MatchStatusEnum.COMPLETED,
        updateStatusModel);
    if (response.isSuccessful) {
      stopTimer();
      FirebaseMessagingUtils.cancelScheduleMatchInProgressNotification();
      FirebaseMessagingUtils.cancelScheduleMatchInProgressNotification2();
      Get.back();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setBool('showRatingDialog', true);
      UPDATE_STATUS.value = API_STATUS.SUCCESS;
      matchStatus.value = MatchStatusEnum.COMPLETED;
      matchModel.value = response.body!;
      timeElapsed.value = getElapsedTime();
      matchesTabController.getAllMatches();
      if (fromScreen == FROM_SCREEN.TEAM_LIST) {
        homeController.setUpdateTeamMatches(true);
      }
    } else {
      UPDATE_STATUS.value = API_STATUS.ERROR;
      var error = response.error as Map<String, dynamic>;
      Get.back();
      Utils.showErrorBottomSheet(message: error['message']);
    }
  }

  void onMatchPause() async {
    UPDATE_STATUS.value = API_STATUS.LOADING;
    UpdateStatusModel updateStatusModel =
        UpdateStatusModel((b) => b..elapsedInSeconds = getEpochToSend());
    final response = await matchService.updateMatchStatus(
        matchModel.value!.matchId, MatchStatusEnum.PAUSED, updateStatusModel);
    if (response.isSuccessful) {
      FirebaseMessagingUtils.cancelScheduleMatchInProgressNotification();
      FirebaseMessagingUtils.cancelScheduleMatchInProgressNotification2();
      matchStatus.value = MatchStatusEnum.PAUSED;
      UPDATE_STATUS.value = API_STATUS.SUCCESS;
      matchModel.value = response.body!;
      timeElapsed.value = getElapsedTime();
      stopTimer();
      matchesTabController.getAllMatches();
    } else {
      UPDATE_STATUS.value = API_STATUS.ERROR;
      var error = response.error as Map<String, dynamic>;
      Utils.showErrorBottomSheet(message: error['message']);
    }
  }

  void onMatchResume() async {
    UPDATE_STATUS.value = API_STATUS.LOADING;
    UpdateStatusModel updateStatusModel =
        UpdateStatusModel((b) => b..elapsedInSeconds = getEpochToSend());
    final response = await matchService.updateMatchStatus(
        matchModel.value!.matchId, MatchStatusEnum.RESUME, updateStatusModel);
    if (response.isSuccessful) {
      FirebaseMessagingUtils.scheduleMatchInProgressNotification(
          "Your Match in Progress - ${matchModel.value!.primaryTeamName} Vs ${matchModel.value!.secondaryTeamName}. Don't Miss Out!");
      FirebaseMessagingUtils.scheduleMatchInProgressNotification2(
          "Your Match in Progress - ${matchModel.value!.primaryTeamName} Vs ${matchModel.value!.secondaryTeamName}. Don't Miss Out!");
      matchStatus.value = MatchStatusEnum.RESUME;
      UPDATE_STATUS.value = API_STATUS.SUCCESS;
      matchModel.value = response.body!;
      timeElapsed.value = getElapsedTime();
      startTimer();
      matchesTabController.getAllMatches();
    } else {
      UPDATE_STATUS.value = API_STATUS.ERROR;
      var error = response.error as Map<String, dynamic>;
      Utils.showErrorBottomSheet(message: error['message']);
    }
  }

  @override
  void onClose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.onClose();
  }

  int getEpochToSend() {
    if (matchModel.value!.progress == MatchStatusEnum.NOT_STARTED) {
      return DateTime.now().millisecondsSinceEpoch;
    } else if (matchModel.value!.progress == MatchStatusEnum.STARTED) {
      DateTime timerDate =
          DateTime.fromMillisecondsSinceEpoch(matchModel.value!.timer!);
      DateTime currentDate = DateTime.now();

      return currentDate.difference(timerDate).inMilliseconds;
    } else if (matchModel.value!.progress == MatchStatusEnum.PAUSED) {
      DateTime subtracted = DateTime.now()
          .subtract(Duration(milliseconds: matchModel.value!.timer!));
      int millis = subtracted.millisecondsSinceEpoch;
      return millis;
    } else {
      DateTime timerDate =
          DateTime.fromMillisecondsSinceEpoch(matchModel.value!.timer!);
      DateTime currentDate = DateTime.now();

      return currentDate.difference(timerDate).inMilliseconds;
    }
  }

  void onSavePlayers() async {
    List<int> lineups = [];
    List<int> substitutes = [];
    lineUpPlayers.value.forEach((element) {
      lineups.add(element.playerId!);
    });

    substitutePlayers.value.forEach((element) {
      substitutes.add(element.playerId!);
    });

    UpdatePlayersRequest updatePlayersRequest = UpdatePlayersRequest(
      (b) => b
        ..lineups = ListBuilder(lineups)
        ..substitutes = ListBuilder(substitutes),
    );
    final response = await matchService.editPlayersOfMatch(
        matchModel.value!.matchId, updatePlayersRequest);

    if (response.isSuccessful) {
      Get.snackbar('Success', 'Players saved successfully',
          snackPosition: SnackPosition.TOP);
    } else {
      var error = response.error as Map<String, dynamic>;
      Utils.showErrorBottomSheet(message: error['message']);
    }
  }

  void sortGoalsByTime(List<GoalModel> goals) {
    goals.sort((a, b) => a.mins - b.mins);
  }

  void addGoal() async {
    GOAL_STATUS.value = API_STATUS.LOADING;

    int minsToSend = mintController.text.isEmpty
        ? (timeElapsed.value / 60).floor()
        : int.parse(mintController.text);

    AddGoalModel goalModel = AddGoalModel(
      (b) => b
        ..playerId = playerId.value
        ..assistPlayerId = assistedPlayer.value
        ..scoreTypeId = scoreTypeId.value
        ..isSecondaryTeam = isSecondaryTeam.value
        ..mins = minsToSend,
    );

    final response =
        await matchService.addGoal(matchModel.value!.matchId, goalModel);

    if (response.isSuccessful) {
      getMatchSummary(true);
      Get.back();
      GOAL_STATUS.value = API_STATUS.SUCCESS;
    } else {
      var error = response.error as Map<String, dynamic>;
      Get.back(closeOverlays: true);
      Future.delayed(const Duration(milliseconds: 500), () {
        Utils.showErrorBottomSheet(message: error['message']);
        GOAL_STATUS.value = API_STATUS.ERROR;
      });
    }
  }

  void editGoal() async {
    GOAL_STATUS.value = API_STATUS.LOADING;
    AddGoalModel goalModel = AddGoalModel(
      (b) => b
        ..playerId = playerId.value == 0 ? null : playerId.value
        ..assistPlayerId =
            assistedPlayer.value == 0 ? null : assistedPlayer.value
        ..scoreTypeId = scoreTypeId.value == 0 ? null : scoreTypeId.value
        ..isSecondaryTeam = isSecondaryTeam.value
        ..mins = int.parse(mintController.text),
    );

    final response = await matchService.editGoal(
        matchId, currentEditGoalId.value!, goalModel);

    if (response.isSuccessful) {
      getMatchSummary(true);
      Get.back();
      GOAL_STATUS.value = API_STATUS.SUCCESS;
    } else {
      var error = response.error as Map<String, dynamic>;
      Get.back(closeOverlays: true);
      Future.delayed(const Duration(milliseconds: 500), () {
        Utils.showErrorBottomSheet(message: error['message']);
        GOAL_STATUS.value = API_STATUS.ERROR;
      });
    }
  }

  void onDeleteGoal() async {
    isDelete.value = true;
    GOAL_STATUS.value = API_STATUS.LOADING;
    final response =
        await matchService.deleteGoal(matchId, currentEditGoalId.value!);
    if (response.isSuccessful) {
      getMatchSummary(true);
      isDelete.value = false;
      Get.back();
      GOAL_STATUS.value = API_STATUS.SUCCESS;
    } else {
      var error = response.error as Map<String, dynamic>;
      isDelete.value = false;
      Get.back(closeOverlays: true);
      Future.delayed(const Duration(milliseconds: 500), () {
        Utils.showErrorBottomSheet(message: error['message']);
        GOAL_STATUS.value = API_STATUS.ERROR;
      });
    }
  }

  void shareDetails() {
    Get.toNamed(
      ShareDetailsView.routeName,
      arguments: [
        json.encode(
          serializers.serializeWith(
            MatchModel.serializer,
            matchModel.value,
          ),
        ),
      ],
    );
  }

  void onClickAddPlayer() async {
    ADD_PLAYER_STATUS.value = API_STATUS.LOADING;
    final response = await playerService.addPlayer(
      playerNameController.text.trim(),
      currentSelectedPosition.value,
      matchModel.value!.primaryTeamId,
      playerTagsTextEditingController.text.trim() != '' ? playerTagsTextEditingController.text.trim() : null,
      playerProfileImage.value != null ? playerProfileImage.value!.path : null,
    );

    if (response.isSuccessful) {
      Get.back();
      Get.snackbar('Success', 'Player Added successfully!');
      getSilentMatchPlayers();
      playerListController.getAllPlayers();
      ADD_PLAYER_STATUS.value = API_STATUS.SUCCESS;
    } else {
      Get.back();
      Map<String, dynamic> error = response.error as Map<String, dynamic>;
      ADD_PLAYER_STATUS.value = API_STATUS.ERROR;
      Utils.showErrorBottomSheet(message: error!['message']);
    }
  }

  // void filterTags() {
  //   if (playerTagsTextEditingController.text.trim() == '') {
  //     filteredTags.value = tags.value;
  //   } else {
  //     List<TagsModel> filtered = tags.value.where((element) {
  //       if (element.name
  //           .toLowerCase()
  //           .contains(playerTagsTextEditingController.text)) {
  //         return true;
  //       } else {
  //         return false;
  //       }
  //     }).toList();
  //
  //     filteredTags.value = filtered;
  //   }
  // }
  //
  // Future<List<int>> createTagsIfNotExists() async {
  //   List<String> addedTags = playerTagsController.getTags!;
  //   List<String> tagsToBeAdded = [];
  //   List<int> tagsAddedForPlayer = [];
  //   addedTags.forEach((element) {
  //     if (!tagsFromApi.value.contains(element)) {
  //       tagsToBeAdded.add(element);
  //     }
  //   });
  //
  //   if (tagsToBeAdded.isNotEmpty) {
  //     ADD_PLAYER_STATUS.value = API_STATUS.LOADING;
  //     ListBuilder<String> tagsToBeAddedList = ListBuilder(tagsToBeAdded);
  //     final response = await playerService
  //         .createTags(AddTagsModel((b) => b..tags = tagsToBeAddedList));
  //
  //     if (response.isSuccessful) {
  //       final tagsResponse = await playerService.getTags();
  //
  //       if (tagsResponse.isSuccessful) {
  //         tags.value = tagsResponse.body!.data.toList();
  //         filteredTags.value = tagsResponse.body!.data.toList();
  //
  //         List<String> list = [];
  //         tagsResponse.body!.data.toList().forEach((element) {
  //           list.add(element.name);
  //         });
  //         tagsFromApi.value = list;
  //
  //         for (String addedTag in addedTags) {
  //           for (TagsModel tag in tags.value) {
  //             if (tag.name == addedTag) {
  //               tagsAddedForPlayer.add(tag.tagId!);
  //               break;
  //             }
  //           }
  //         }
  //       }
  //     }
  //     return tagsAddedForPlayer;
  //   } else {
  //     for (String addedTag in addedTags) {
  //       for (TagsModel tag in tags.value) {
  //         if (tag.name == addedTag) {
  //           tagsAddedForPlayer.add(tag.tagId!);
  //           break;
  //         }
  //       }
  //     }
  //     return tagsAddedForPlayer;
  //   }
  // }

  void addTag(String tag) {
    playerTagsController.onSubmitted(tag);
  }

  void showAddPlayerBottomSheet() {
    Get.bottomSheet(
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(14),
        ),
      ),
      backgroundColor: CustomColors.appBarColor,
      enableDrag: false,
      Obx(
            () => Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Players',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ConditionalImage(
                      fileSelectCallBack: fileSelectCallBack,
                      width: 50,
                      imageUrl: null,
                      filePath: playerProfileImage.value != null
                          ? playerProfileImage.value!.path
                          : null,
                    ),
                    BaseTextField(
                      labelText: 'Player Name',
                      controller: playerNameController,
                      isRequired: true,
                      showUnderLineBorder: true,
                      focusedLabelColor: Colors.white,
                      errorText: playerNameError.value,
                      onChange: () => playerNameError.value = null,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    PositionDropDown(
                      setVal: setCurrentSelectedPosition,
                      positions: positions.value!,
                      currentSelectedPosition: currentSelectedPosition.value,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BaseTextField(
                      labelText: 'Tag',
                      controller: playerTagsTextEditingController,
                      isRequired: false,
                      showUnderLineBorder: true,
                      focusedLabelColor: Colors.white,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BaseButton(
                      onPressed: onClickAddPlayer,
                      isLoading: ADD_PLAYER_STATUS.value == API_STATUS.LOADING,
                      text: 'Done',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 8,
                right: 0,
                child: InkWell(
                  onTap: () {
                    Get.back(closeOverlays: true);
                  },
                  child: const Image(
                    image: AssetImage('assets/images/close_icon.png'),
                    width: 18,
                    height: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).whenComplete(() {
      playerNameError.value = null;
      playerNameController.text = '';
      ADD_PLAYER_STATUS.value = API_STATUS.IDLE;
      currentSelectedPosition.value = null;
      playerTagsTextEditingController.text = '';
    });
  }

  void fileSelectCallBack(XFile xFile) {
    playerProfileImage.value = xFile;
  }
}
