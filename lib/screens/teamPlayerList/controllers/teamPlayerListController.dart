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
import 'package:score_keeper/screens/home/controllers/homeController.dart';
import 'package:score_keeper/screens/playerList/components/positionDropDown.dart';
import 'package:score_keeper/screens/playerList/controllers/playerListController.dart';
import 'package:score_keeper/screens/playerList/models/addTagsModel/addTagsModel.dart';
import 'package:score_keeper/screens/playerList/models/playerModels/player.dart';
import 'package:score_keeper/screens/playerList/models/positionModels/positionsModel.dart';
import 'package:score_keeper/screens/teamPlayerList/models/addPlayerToTeamRequestModel.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/utils.dart';
import 'package:built_collection/built_collection.dart';
import 'package:textfield_tags/textfield_tags.dart';

class TeamPlayerListController extends GetxController {
  final allPlayers = Rxn<List<Player>>([]);
  final allPlayerFromApi = Rxn<List<Player>>([]);
  final teamPlayers = Rxn<List<Player>>([]);
  final teamPlayerResponseList = Rxn<List<Player>>([]);
  PlayerListController playerListController = Get.find();
  TeamService teamService = Get.find();
  final STATUS = API_STATUS.IDLE.obs;
  final SAVE_STATUS = API_STATUS.IDLE.obs;
  int teamId = -1;
  final appBarTitle = Rx<String>('Add Player to Team');
  final showFloatingActionButton = true.obs;
  HomeController homeController = Get.find();
  final filteredAllPlayers = Rxn<List<Player>>([]);
  final filteredTeamPlayers = Rxn<List<Player>>([]);
  TextEditingController searchController = TextEditingController();
  TextEditingController playerNameController = TextEditingController();
  final playerNameError = Rxn<String>();
  final positions = Rxn<List<PositionsModel>>();
  final currentSelectedPosition = Rxn<int>();
  final ADD_PLAYER_STATUS = API_STATUS.IDLE.obs;
  PlayerService playerService = Get.find();
  final playerProfileImage = Rxn<XFile>();
  TextEditingController playerTagsTextEditingController =
  TextEditingController();
  TextfieldTagsController playerTagsController = TextfieldTagsController();
  // final tags = Rx<List<TagsModel>>([]);
  // final filteredTags = Rx<List<TagsModel>>([]);
  // final tagsFromApi = Rx<List<String>>([]);

  @override
  void onInit() async {
    if (playerListController.STATUS.value == API_STATUS.SUCCESS) {
      allPlayerFromApi.value = playerListController.players.value;
      positions.value = playerListController.positions.value;
    }
    Map<String, String?> params = Get.parameters;
    teamId = int.parse(params['teamId']!);
    appBarTitle.value = params['name']!;
    // tags.value = playerListController.tags.value;
    // filteredTags.value = playerListController.tags.value;
    //
    // playerTagsTextEditingController.addListener(() {
    //   filterTags();
    // });
    getAllPlayers();
    super.onInit();
  }

  void setShowFloatingActionButton(bool val) =>
      showFloatingActionButton.value = val;

  setCurrentSelectedPosition(dynamic newVal) =>
      currentSelectedPosition.value = newVal;

  void getAllPlayers({bool isSilent = false}) async {
    if (!isSilent) {
      STATUS.value = API_STATUS.LOADING;
    }

    final teamPlayerResponse = await teamService.getTeamPlayers(teamId);

    if (teamPlayerResponse.isSuccessful) {
      teamPlayers.value = teamPlayerResponse.body!.data.toList();
      filteredTeamPlayers.value = teamPlayerResponse.body!.data.toList();
      teamPlayerResponseList.value = teamPlayerResponse.body!.data.toList();
      var set1 = Set.from(teamPlayers.value!);
      var set2 = Set.from(allPlayerFromApi.value!);

      allPlayers.value = List.from(set2.difference(set1));
      filteredAllPlayers.value = List.from(set2.difference(set1));
      if (!isSilent) {
        STATUS.value = API_STATUS.SUCCESS;
      }
    } else {
      var error = teamPlayerResponse.error as Map<String, dynamic>;
      Utils.showErrorBottomSheet(message: error!['message']);
      if (!isSilent) {
        STATUS.value = API_STATUS.ERROR;
      }
    }
  }

  void searchPlayers() {
    if (searchController.text.isNotEmpty) {
      List<Player> searchedTeamPlayers = teamPlayers.value!.where((element) {
        if (element.name
            .toLowerCase()
            .contains(searchController.text.toLowerCase())) {
          return true;
        } else if (element.position != null &&
            element.position!
                .toLowerCase()
                .contains(searchController.text.toLowerCase())) {
          return true;
        } else if (element.tagName != null &&
            element.tagName!.toLowerCase()
                .contains(searchController.text.toLowerCase())) {
          return true;
        } else {
          return false;
        }
      }).toList();

      List<Player> searchedAllPlayers = allPlayers.value!.where((element) {
        if (element.name
            .toLowerCase()
            .contains(searchController.text.toLowerCase())) {
          return true;
        } else if (element.position != null &&
            element.position!
                .toLowerCase()
                .contains(searchController.text.toLowerCase())) {
          return true;
        } else if (element.tagName != null &&
            element.tagName!.toLowerCase()
                .contains(searchController.text.toLowerCase())) {
          return true;
        } else {
          return false;
        }
      }).toList();

      filteredTeamPlayers.value = searchedTeamPlayers;
      filteredAllPlayers.value = searchedAllPlayers;
    } else {
      filteredTeamPlayers.value = teamPlayers.value;
      filteredAllPlayers.value = allPlayers.value;
    }
  }

  void addToLineUpPlayers(Player player) {
    List<Player> filtered = allPlayers.value!
        .where((element) => element.playerId != player.playerId)
        .toList();
    List<Player> tempLineUp = teamPlayers.value!;
    tempLineUp.add(player);
    teamPlayers.value = tempLineUp;
    allPlayers.value = filtered;
    searchPlayers();
  }

  void removeFromLineUp(Player player) {
    List<Player> filtered = teamPlayers.value!
        .where((element) => element.playerId != player.playerId)
        .toList();
    List<Player> tempSub = allPlayers.value!;
    tempSub.add(player);
    allPlayers.value = tempSub;
    teamPlayers.value = filtered;
    searchPlayers();
  }

  void onSavePress() async {
    SAVE_STATUS.value = API_STATUS.LOADING;
    List<int> addPlayerIds = [];
    List<int> deletePlayerIds = [];

    Set<Player> teamPlayerFromApi = Set.from(teamPlayerResponseList.value!);
    Set<Player> currentTeamPlayers = Set.from(teamPlayers.value!);

    teamPlayerFromApi.difference(currentTeamPlayers).forEach((element) {
      deletePlayerIds.add(element.playerId!);
    });

    currentTeamPlayers.difference(teamPlayerFromApi).forEach((element) {
      addPlayerIds.add(element.playerId!);
    });

    ListBuilder<int> playerId = ListBuilder(addPlayerIds);
    ListBuilder<int> deletePlayers = ListBuilder(deletePlayerIds);

    AddPlayerToTeamRequestModel addPlayerToTeamRequestModel =
        AddPlayerToTeamRequestModel((b) => b..players = playerId);
    AddPlayerToTeamRequestModel deletePlayerFromTeam =
        AddPlayerToTeamRequestModel((b) => b..players = deletePlayers);
    final response =
        await teamService.addPlayersToTeam(addPlayerToTeamRequestModel, teamId);

    if (response.isSuccessful) {
      if (deletePlayers.length != 0) {
        final deletePlayerResponse = await teamService.deletePlayersFromTeam(
            teamId, deletePlayerFromTeam);

        if (deletePlayerResponse.isSuccessful) {
          SAVE_STATUS.value = API_STATUS.SUCCESS;
          showSuccessToast();
        } else {
          // SAVE_STATUS.value = API_STATUS.ERROR;
          // var error = deletePlayerResponse.error as Map<String, dynamic>;
          // Utils.showErrorBottomSheet(message: error!['message']);

          SAVE_STATUS.value = API_STATUS.SUCCESS;
          showSuccessToast();
        }
      } else {
        SAVE_STATUS.value = API_STATUS.SUCCESS;
        showSuccessToast();
      }
    } else {
      // SAVE_STATUS.value = API_STATUS.ERROR;
      // var error = response.error as Map<String, dynamic>;
      // Utils.showErrorBottomSheet(message: error!['message']);

      SAVE_STATUS.value = API_STATUS.SUCCESS;
      showSuccessToast();
    }
  }

  void showSuccessToast() {
    Get.snackbar("Success", "Players added successfully",
        snackPosition: SnackPosition.TOP, duration: const Duration(seconds: 2));
    Future.delayed(const Duration(seconds: 3), () {
      Get.closeAllSnackbars();
      Get.back(closeOverlays: true);
    });
  }

  void onClickAddPlayer() async {
    ADD_PLAYER_STATUS.value = API_STATUS.LOADING;
    final response = await playerService.addPlayer(
      playerNameController.text.trim(),
      currentSelectedPosition.value,
      teamId,
      playerTagsTextEditingController.text.trim() != '' ? playerTagsTextEditingController.text.trim() : null,
      playerProfileImage.value != null ? playerProfileImage.value!.path : null,
    );

    if (response.isSuccessful) {
      Get.back();
      Get.snackbar('Success', 'Player Added successfully!');
      getAllPlayers();
      playerListController.getAllPlayers();
      ADD_PLAYER_STATUS.value = API_STATUS.SUCCESS;
    } else {
      ADD_PLAYER_STATUS.value = API_STATUS.ERROR;
      var error = response.error as Map<String, dynamic>;
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

  ImageProvider<Object>? getImage() {
    if (playerProfileImage.value != null) {
      return FileImage(File(playerProfileImage.value!.path));
    } else {
      return const AssetImage('assets/images/camera_icon.png');
    }
  }

  void fileSelectCallBack(XFile xFile) {
    playerProfileImage.value = xFile;
  }
}
