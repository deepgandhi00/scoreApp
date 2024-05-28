import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:score_keeper/components/buttons/customFloatingActionButton.dart';
import 'package:score_keeper/components/loadingScreen/loadingScreen.dart';
import 'package:score_keeper/components/noDataScreen/noDataScreen.dart';
import 'package:score_keeper/components/textFields/baseTextField.dart';
import 'package:score_keeper/screens/playerList/components/playerListItem.dart';
import 'package:score_keeper/screens/playerList/controllers/playerListController.dart';
import 'package:score_keeper/screens/playerList/models/playerModels/player.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:get/get.dart';
import 'package:score_keeper/utils/utils.dart';

class PlayerListView extends StatefulWidget {
  static String routeName = '/playerList';

  PlayerListView({Key? key}) : super(key: key);

  @override
  State<PlayerListView> createState() => _PlayerListViewState();
}

class _PlayerListViewState extends State<PlayerListView> {
  PlayerListController playerListController = Get.find<PlayerListController>();

  void closeBottomSheet() {
    Get.back();
  }

  void onEditPlayerClick(Player player) {
    playerListController.currentEditingPlayer.value = player;
    playerListController.currentSelectedPosition.value = player.positionId;
    playerListController.playerNameController.text = player.name;
    if (player.tagName != null) {
      playerListController.playerTagsTextEditingController.text =
          player.tagName!;
    }

    playerListController.showAddPlayerBottomSheet();
  }

  void onDeletePress(BuildContext context, Player player) {
    Utils.showConfirmBottomSheet(
      onDeletePress: () => playerListController.onDeletePlayerPress(player),
      isLoading: playerListController.DELETE_PLAYER_STATUS,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => playerListController.STATUS.value == API_STATUS.SUCCESS
          ? Stack(
              children: [
                playerListController.players.value!.isNotEmpty
                    ? Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: BaseTextField(
                              labelText: null,
                              controller:
                                  playerListController.searchPlayerController,
                              onChange: playerListController.searchPlayers,
                              fillColor: CustomColors.appBarColor,
                              hintText: 'Search',
                              isRequired: false,
                              prefixIcon: const Icon(
                                Icons.search,
                                size: 18,
                                color: CustomColors.greyText,
                              ),
                              focusedLabelColor: Colors.white,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: CustomColors.appBarColor,
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: NotificationListener<
                                      UserScrollNotification>(
                                    onNotification: (notification) {
                                      if (notification.direction ==
                                          ScrollDirection.reverse) {
                                        playerListController
                                            .setShowFloatingActionButton(false);
                                      } else if (notification.direction ==
                                          ScrollDirection.forward) {
                                        playerListController
                                            .setShowFloatingActionButton(true);
                                      }
                                      return true;
                                    },
                                    child: ListView.separated(
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                                  child: Divider(),
                                                ),
                                        itemCount: playerListController
                                            .filteredPlayers.value!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return PlayerListItem(
                                            player: playerListController
                                                .filteredPlayers.value!
                                                .elementAt(index),
                                            onEditPress: onEditPlayerClick,
                                            onDeletePress: onDeletePress,
                                          );
                                        }),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : NoDataScreen(
                        title: 'Add Player',
                        message: "Let's add players to your team",
                        showPointer: true,
                      ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: AnimatedSlide(
                    duration: const Duration(milliseconds: 400),
                    offset: playerListController.showFloatingActionButton.value
                        ? Offset.zero
                        : const Offset(0, 16),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 400),
                      opacity:
                          playerListController.showFloatingActionButton.value
                              ? 1
                              : 0,
                      child: CustomFloatingActionButton(
                        onPress: playerListController.showAddPlayerBottomSheet,
                      ),
                    ),
                  ),
                )
              ],
            )
          : const LoadingScreen(),
    );
  }
}
