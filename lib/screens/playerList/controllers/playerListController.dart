import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:score_keeper/components/buttons/baseButton.dart';
import 'package:score_keeper/components/custom/conditionalImage.dart';
import 'package:score_keeper/components/custom/tagsSuggestionView.dart';
import 'package:score_keeper/components/textFields/baseTextField.dart';
import 'package:score_keeper/components/textFields/tagsTextField.dart';
import 'package:score_keeper/di/services/players/playerService.dart';
import 'package:score_keeper/models/tagsModel.dart';
import 'package:score_keeper/screens/matchesTabs/controllers/matchesTabController.dart';
import 'package:score_keeper/screens/playerList/components/positionDropDown.dart';
import 'package:score_keeper/screens/playerList/models/addTagsModel/addTagsModel.dart';
import 'package:score_keeper/screens/playerList/models/playerModels/addPlayerRequestModel.dart';
import 'package:score_keeper/screens/playerList/models/playerModels/player.dart';
import 'package:score_keeper/screens/playerList/models/positionModels/positionsModel.dart';
import 'package:score_keeper/screens/teamList/controllers/teamListController.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/firebaseMessagingUtils.dart';
import 'package:score_keeper/utils/utils.dart';
import 'package:score_keeper/utils/validations.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:built_collection/built_collection.dart';

class PlayerListController extends GetxController {
  final players = Rxn<List<Player>>();
  final positions = Rxn<List<PositionsModel>>();
  var STATUS = API_STATUS.IDLE.obs;
  TextEditingController playerNameController = TextEditingController();
  final playerNameError = Rxn<String>();
  final currentSelectedPosition = Rxn<int>();
  final ADD_PLAYER_STATUS = API_STATUS.IDLE.obs;
  PlayerService playerService = Get.find();
  final currentEditingPlayer = Rxn<Player>();
  final DELETE_PLAYER_STATUS = API_STATUS.IDLE.obs;
  final showFloatingActionButton = true.obs;
  TextEditingController searchPlayerController = TextEditingController();
  final filteredPlayers = Rxn<List<Player>>();
  final playerProfileImage = Rxn<XFile>();
  TextEditingController playerTagsTextEditingController =
      TextEditingController();
  TextfieldTagsController playerTagsController = TextfieldTagsController();

  setCurrentSelectedPosition(dynamic newVal) =>
      currentSelectedPosition.value = newVal;

  setShowFloatingActionButton(bool showButton) =>
      showFloatingActionButton.value = showButton;

  @override
  void onReady() {
    getAllPositions();
    // playerTagsTextEditingController.addListener(() {
    //   filterTags();
    // });
    super.onReady();
  }

  @override
  void onClose() {
    STATUS.value = API_STATUS.IDLE;
    positions.value = null;
    players.value = null;
    filteredPlayers.value = null;
    super.onClose();
  }

  void getAllPositions() async {
    final positionsResponse = await playerService.getPositions();

    if (positionsResponse.isSuccessful) {
      List<PositionsModel> positionsFromApi = [
        PositionsModel((b) => b
          ..name = 'Select Player Position'
          ..position_id = null)
      ];
      List<PositionsModel> sorted = positionsResponse.body!.data.toList();
      sorted.sort((a, b) => a.name.compareTo(b.name));
      positionsFromApi.addAll(sorted);
      positions.value = positionsFromApi;
      currentSelectedPosition.value = positions.value!.first.position_id;
    } else {
      positions.value = [];
    }

    getAllPlayers();
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

  void getAllPlayers() async {
    STATUS.value = API_STATUS.LOADING;

    final playersResponse = await playerService.getPlayers();

    if (playersResponse.isSuccessful) {
      List<Player> list = playersResponse.body!.data.toList();
      list.sort((a, b) => a.name.compareTo(b.name));
      players.value = list;
      filteredPlayers.value = list;
      STATUS.value = API_STATUS.SUCCESS;
    } else {
      STATUS.value = API_STATUS.ERROR;
    }
  }

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

  void onAddEditPlayerPress() async {
    final MatchesTabController matchesTabController = Get.find();
    String? nameError = Validations.validateNameFields(
        value: playerNameController.text, fieldName: 'player name');

    if (nameError != null) {
      playerNameError.value = nameError;
      return;
    }

    if (currentEditingPlayer.value != null) {
      ADD_PLAYER_STATUS.value = API_STATUS.LOADING;
      print('playerTagsTextEditingController ${playerTagsTextEditingController.text}');

      final editPlayerResponse = await playerService.editPlayer(
        playerNameController.text.trim(),
        currentSelectedPosition.value!,
        currentEditingPlayer.value!.playerId,
        playerTagsTextEditingController.text.trim() != ''
            ? playerTagsTextEditingController.text.trim()
            : null,
        playerProfileImage.value != null
            ? playerProfileImage.value!.path
            : null,
      );

      if (editPlayerResponse.isSuccessful) {
        ADD_PLAYER_STATUS.value = API_STATUS.SUCCESS;
        Get.back();
        getAllPlayers();
      } else {
        var error = editPlayerResponse.error as Map<String, dynamic>;
        ADD_PLAYER_STATUS.value = API_STATUS.ERROR;
        playerNameError.value = error!['message'];
      }
    } else {
      ADD_PLAYER_STATUS.value = API_STATUS.LOADING;
      final addPlayerResponse = await playerService.addPlayer(
        playerNameController.text.trim(),
        currentSelectedPosition.value,
        null,
        playerTagsTextEditingController.text.trim() != ''
            ? playerTagsTextEditingController.text.trim()
            : null,
        playerProfileImage.value != null
            ? playerProfileImage.value!.path
            : null,
      );

      if (addPlayerResponse.isSuccessful) {
        if (players.value!.isEmpty) {
          FirebaseMessagingUtils.cancelPlayerScheduleNotification();
        }
        if (matchesTabController.matches.value!.data.isEmpty) {
          checkAndScheduleNotification();
        }
        ADD_PLAYER_STATUS.value = API_STATUS.SUCCESS;
        Get.back();
        getAllPlayers();
      } else {
        var error = addPlayerResponse.error as Map<String, dynamic>;
        ADD_PLAYER_STATUS.value = API_STATUS.ERROR;
        playerNameError.value = error!['message'];
      }
    }
    currentEditingPlayer.value = null;
    playerNameController.text = '';
    currentSelectedPosition.value = positions.value!.first.position_id;
  }

  void searchPlayers() {
    if (searchPlayerController.text.isNotEmpty) {
      List<Player> searched = players.value!.where((element) {
        if (element.name
            .toLowerCase()
            .contains(searchPlayerController.text.toLowerCase())) {
          return true;
        } else if (element.position != null &&
            element.position!
                .toLowerCase()
                .contains(searchPlayerController.text.toLowerCase())) {
          return true;
        } else if (element.tagName != null &&
            element.tagName!.toLowerCase()
                .contains(searchPlayerController.text.toLowerCase())) {
          return true;
        } else {
          return false;
        }
      }).toList();
      filteredPlayers.value = searched;
    } else {
      filteredPlayers.value = players.value;
    }
  }

  checkAndScheduleNotification() async {
    final TeamListController teamListController = Get.find();
    if (teamListController.teamListModel.value!.data.isNotEmpty) {
      bool isScheduled = await Utils.getIsScheduledMatchNotification();
      if (!isScheduled) {
        FirebaseMessagingUtils.scheduleMatchNotification();
      }
    }
  }

  void onDeletePlayerPress(Player player) async {
    DELETE_PLAYER_STATUS.value = API_STATUS.LOADING;
    final deleteResponse = await playerService.deletePlayer(player);

    if (deleteResponse.isSuccessful) {
      DELETE_PLAYER_STATUS.value = API_STATUS.SUCCESS;
      Get.back();
      getAllPlayers();
    } else {
      var error = deleteResponse.error as Map<String, dynamic>;
      DELETE_PLAYER_STATUS.value = API_STATUS.ERROR;
      Get.back();
      Utils.showErrorBottomSheet(
          message: error!['message'],
          onOkayPress: () {
            DELETE_PLAYER_STATUS.value = API_STATUS.IDLE;
          });
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
                      imageUrl: currentEditingPlayer.value != null &&
                              currentEditingPlayer.value!.photo != null
                          ? currentEditingPlayer.value!.photo
                          : null,
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
                      onPressed: onAddEditPlayerPress,
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
      currentSelectedPosition.value = null;
      playerProfileImage.value = null;
      playerTagsTextEditingController.text = '';
    });
  }

  void fileSelectCallBack(XFile xFile) {
    playerProfileImage.value = xFile;
  }
}
