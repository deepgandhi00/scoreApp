import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:score_keeper/components/buttons/baseButton.dart';
import 'package:score_keeper/components/custom/conditionalImage.dart';
import 'package:score_keeper/components/custom/tagsSuggestionView.dart';
import 'package:score_keeper/components/textFields/baseTextField.dart';
import 'package:score_keeper/components/textFields/tagsTextField.dart';
import 'package:score_keeper/di/services/match/matchService.dart';
import 'package:score_keeper/di/services/players/playerService.dart';
import 'package:score_keeper/di/services/teams/teamService.dart';
import 'package:score_keeper/models/tagsModel.dart';
import 'package:score_keeper/screens/addMatch/controllers/addMatchController.dart';
import 'package:score_keeper/screens/home/controllers/homeController.dart';
import 'package:score_keeper/screens/matchesTabs/controllers/matchesTabController.dart';
import 'package:score_keeper/screens/playerList/components/positionDropDown.dart';
import 'package:score_keeper/screens/playerList/controllers/playerListController.dart';
import 'package:score_keeper/screens/playerList/models/addTagsModel/addTagsModel.dart';
import 'package:score_keeper/screens/playerList/models/playerModels/player.dart';
import 'package:score_keeper/screens/playerList/models/positionModels/positionsModel.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/utils.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:built_collection/built_collection.dart';

class AddPlayerController extends GetxController {
  final lineUpPlayers = Rx<List<Player>>([]);
  final substitutePlayers = Rx<List<Player>>([]);
  MatchService matchService = Get.find();
  MatchesTabController matchesTabController = Get.find();
  AddMatchController addMatchController = Get.find();
  final CREATE_STATUS = API_STATUS.IDLE.obs;
  final STATUS = API_STATUS.IDLE.obs;
  TeamService teamService = Get.find();
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

  void setShowFloatingActionButton(bool val) =>
      showFloatingActionButton.value = val;

  @override
  void onInit() async {
    positions.value = playerListController.positions.value;
    getTeamPlayers();
    super.onInit();
    // tags.value = playerListController.tags.value;
    // filteredTags.value = playerListController.tags.value;
    //
    // playerTagsTextEditingController.addListener(() {
    //   filterTags();
    // });
  }

  void getTeamPlayers({bool isSilent = false}) async {
    if (!isSilent) {
      STATUS.value = API_STATUS.LOADING;
    }

    final response = await teamService
        .getTeamPlayers(addMatchController.selectedTeamId.value!);

    if (response.isSuccessful) {
      substitutePlayers.value = response.body!.data.toList();
      if (!isSilent) {
        STATUS.value = API_STATUS.SUCCESS;
      }
    } else {
      substitutePlayers.value = [];
      if (!isSilent) {
        STATUS.value = API_STATUS.SUCCESS;
      }
    }
  }

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

  void onCreatePress() async {
    CREATE_STATUS.value = API_STATUS.LOADING;
    String lineups = '[';
    String substitutes = '[';

    lineUpPlayers.value.forEach((element) {
      lineups = lineups + '${element.playerId},';
    });
    substitutePlayers.value.forEach((element) {
      substitutes = substitutes + '${element.playerId},';
    });

    lineups = lineUpPlayers.value.isNotEmpty
        ? lineups.substring(0, lineups.length - 1) + ']'
        : lineups + ']';
    substitutes = substitutePlayers.value.isNotEmpty
        ? substitutes.substring(0, substitutes.length - 1) + ']'
        : substitutes + ']';

    final response = await matchService.createMatch(
      addMatchController.selectedTeamId.value!,
      addMatchController.teamNameController.text,
      addMatchController.locationController.text,
      addMatchController.leagueController.text,
      '${addMatchController.selectedDate.value.year}-${addMatchController.selectedDate.value.month}-${addMatchController.selectedDate.value.day}',
      lineups,
      substitutes,
      addMatchController.isPublicMatch.value == true ? 1 : 0,
      addMatchController.selectedTime.value != null
          ? '${addMatchController.kickOffController.text}'
          : null,
      addMatchController.file != null &&
              addMatchController.file.value != null &&
              addMatchController.file.value.path.isNotEmpty
          ? addMatchController.file.value.path
          : null,
    );

    if (response.isSuccessful) {
      matchesTabController.getAllMatches();

      CREATE_STATUS.value = API_STATUS.SUCCESS;
      homeController.setUpdateTeamMatches(true);
      Get.back();
      Get.back();
    } else {
      CREATE_STATUS.value = API_STATUS.ERROR;
      var error = response.error as Map<String, dynamic>;
      Utils.showErrorBottomSheet(message: error['message']);
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

  void onClickAddPlayer() async {
    ADD_PLAYER_STATUS.value = API_STATUS.LOADING;
    final response = await playerService.addPlayer(
      playerNameController.text.trim(),
      currentSelectedPosition.value,
      addMatchController.selectedTeamId.value!,
      playerTagsTextEditingController.text.trim() != '' ? playerTagsTextEditingController.text.trim() : null,
      playerProfileImage.value != null ? playerProfileImage.value!.path : null,
    );

    if (response.isSuccessful) {
      Get.back();
      Get.snackbar('Success', 'Player Added successfully!');
      playerListController.getAllPlayers();
      getTeamPlayers(isSilent: true);
      ADD_PLAYER_STATUS.value = API_STATUS.SUCCESS;
    } else {
      ADD_PLAYER_STATUS.value = API_STATUS.ERROR;
      var error = response.error as Map<String, dynamic>;
      Utils.showErrorBottomSheet(message: error!['message']);
    }
  }

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
