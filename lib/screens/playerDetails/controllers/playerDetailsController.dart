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
import 'package:score_keeper/di/services/players/playerService.dart';
import 'package:score_keeper/di/services/teams/teamService.dart';
import 'package:score_keeper/models/tagsModel.dart';
import 'package:score_keeper/screens/playerDetails/models/playerDetailModel.dart';
import 'package:score_keeper/screens/playerList/components/positionDropDown.dart';
import 'package:score_keeper/screens/playerList/controllers/playerListController.dart';
import 'package:score_keeper/screens/playerList/models/addTagsModel/addTagsModel.dart';
import 'package:score_keeper/screens/playerList/models/playerModels/player.dart';
import 'package:score_keeper/screens/playerList/models/positionModels/positionsModel.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/utils.dart';
import 'package:score_keeper/utils/validations.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:built_collection/built_collection.dart';

class PlayerDetailsController extends GetxController {
  var STATUS = API_STATUS.IDLE.obs;
  final playerDetails = Rxn<PlayerDetailModel>();
  PlayerService playerService = Get.find();
  final EDIT_STATUS = API_STATUS.IDLE.obs;
  TeamService teamService = Get.find();
  final playerNameError = Rxn<String>();
  final currentSelectedPosition = Rxn<int>();
  final ADD_PLAYER_STATUS = API_STATUS.IDLE.obs;
  TextEditingController playerNameController = TextEditingController();
  final positions = Rxn<List<PositionsModel>>();
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
  void onInit() {
    super.onInit();
    if (playerListController.STATUS.value == API_STATUS.SUCCESS) {
      positions.value = playerListController.positions.value;
      // tags.value = playerListController.tags.value;
      // filteredTags.value = playerListController.tags.value;
    }

    // playerTagsTextEditingController.addListener(() {
    //   filterTags();
    // });
    getPlayerDetails();
  }

  void getPlayerDetails() async {
    STATUS.value = API_STATUS.LOADING;
    final response = await playerService
        .getPlayerDetails(int.parse(Get.parameters['playerId'] as String));
    if (response.isSuccessful) {
      playerDetails.value = response.body!;
      STATUS.value = API_STATUS.SUCCESS;
    } else {
      Utils.showErrorBottomSheet(onOkayPress: () {
        Get.back();
      });
      STATUS.value = API_STATUS.ERROR;
    }
  }

  void deleteTeam(int teamId, int playerId) async {
    EDIT_STATUS.value = API_STATUS.LOADING;
    final response = await teamService.deletePlayerTeam(teamId, playerId);

    if (response.isSuccessful) {
      EDIT_STATUS.value = API_STATUS.SUCCESS;
      Get.back();
      getPlayerDetails();
    } else {
      var error = response.error as Map<String, dynamic>;
      EDIT_STATUS.value = API_STATUS.ERROR;
      Get.back();
      Utils.showErrorBottomSheet(
          message:
              error!['message'] ?? 'Something went wrong. Please try again',
          onOkayPress: () {
            EDIT_STATUS.value = API_STATUS.IDLE;
          });
    }
  }

  void onAddEditPlayerPress() async {
    String? nameError = Validations.validateNameFields(
        value: playerNameController.text, fieldName: 'player name');

    if (nameError != null) {
      playerNameError.value = nameError;
      return;
    }
    ADD_PLAYER_STATUS.value = API_STATUS.LOADING;
    final editPlayerResponse = await playerService.editPlayer(
      playerNameController.text,
      currentSelectedPosition.value,
      playerDetails.value!.playerId,
      playerTagsTextEditingController.text.trim() != ''
          ? playerTagsTextEditingController.text.trim()
          : null,
      playerProfileImage.value != null ? playerProfileImage.value!.path : null,
    );

    if (editPlayerResponse.isSuccessful) {
      ADD_PLAYER_STATUS.value = API_STATUS.SUCCESS;
      Get.back();
      getPlayerDetails();
    } else {
      var error = editPlayerResponse.error as Map<String, dynamic>;
      ADD_PLAYER_STATUS.value = API_STATUS.ERROR;
      playerNameError.value = error!['message'];
    }

    playerNameController.text = '';
    currentSelectedPosition.value = positions.value!.first.position_id;
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
  //
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
    playerNameController.text = playerDetails.value!.name;
    setCurrentSelectedPosition(playerDetails.value!.positionId);
    if (playerDetails.value!.tagName != null) {
      playerTagsTextEditingController.text = playerDetails.value!.tagName!;
    }
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
                      imageUrl: playerDetails.value != null &&
                              playerDetails.value!.photo != null
                          ? playerDetails.value!.photo
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
                    Get.back();
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
      playerTagsTextEditingController.text = '';
    });
  }

  void fileSelectCallBack(XFile xFile) {
    playerProfileImage.value = xFile;
  }
}
