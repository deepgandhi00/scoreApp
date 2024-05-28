import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:score_keeper/components/buttons/baseButton.dart';
import 'package:score_keeper/components/buttons/customFloatingActionButton.dart';
import 'package:score_keeper/components/custom/playerListWithTitle.dart';
import 'package:score_keeper/components/loadingScreen/loadingScreen.dart';
import 'package:score_keeper/components/noDataScreen/noDataScreen.dart';
import 'package:score_keeper/components/textFields/baseTextField.dart';
import 'package:score_keeper/screens/playerList/controllers/playerListController.dart';
import 'package:score_keeper/screens/teamPlayerList/controllers/teamPlayerListController.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/utils.dart';

class TeamPlayerListView extends StatelessWidget {
  static String routeName = '/teamPlayerList';
  TeamPlayerListController teamPlayerListController =
      Get.find<TeamPlayerListController>();
  PlayerListController playerListController = Get.find();

  TeamPlayerListView({Key? key}) : super(key: key);

  void closeBottomSheet() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Obx(() => Text(teamPlayerListController.appBarTitle.value)),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: CustomColors.appBarColor,
        ),
      ),
      body: Obx(
        () => teamPlayerListController.STATUS.value == API_STATUS.SUCCESS
            ? Stack(
                children: [
                  teamPlayerListController.teamPlayers.value!.isNotEmpty ||
                          teamPlayerListController
                              .allPlayerFromApi.value!.isNotEmpty
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: BaseTextField(
                                isRequired: false,
                                labelText: null,
                                controller:
                                    teamPlayerListController.searchController,
                                onChange:
                                    teamPlayerListController.searchPlayers,
                                fillColor: CustomColors.appBarColor,
                                hintText: 'Search',
                                prefixIcon: const Icon(
                                  Icons.search,
                                  size: 18,
                                  color: CustomColors.greyText,
                                ),
                                focusedLabelColor: Colors.white,
                              ),
                            ),
                            Expanded(
                              child:
                                  NotificationListener<UserScrollNotification>(
                                onNotification: (notification) {
                                  if (notification.direction ==
                                      ScrollDirection.reverse) {
                                    teamPlayerListController
                                        .setShowFloatingActionButton(false);
                                  } else if (notification.direction ==
                                      ScrollDirection.forward) {
                                    teamPlayerListController
                                        .setShowFloatingActionButton(true);
                                  }
                                  return true;
                                },
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        teamPlayerListController
                                                .allPlayers.value!.isNotEmpty
                                            ? const Text(
                                                'Choose players for your team',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              )
                                            : Container(),
                                        teamPlayerListController
                                                .allPlayers.value!.isNotEmpty
                                            ? const SizedBox(
                                                height: 8,
                                              )
                                            : Container(),
                                        PlayerListWithTitle(
                                          players: teamPlayerListController
                                              .filteredTeamPlayers.value!,
                                          title: 'Team Players',
                                          isLineUp: true,
                                          onAddPress: teamPlayerListController
                                              .addToLineUpPlayers,
                                          onRemovePress:
                                              teamPlayerListController
                                                  .removeFromLineUp,
                                        ),
                                        const SizedBox(
                                          height: 32,
                                        ),
                                        PlayerListWithTitle(
                                          players: teamPlayerListController
                                              .filteredAllPlayers.value!,
                                          title: 'Available players to add',
                                          isLineUp: false,
                                          onAddPress: teamPlayerListController
                                              .addToLineUpPlayers,
                                          onRemovePress:
                                              teamPlayerListController
                                                  .removeFromLineUp,
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              color: CustomColors.appBarColor,
                              child: BaseButton(
                                onPressed: teamPlayerListController.onSavePress,
                                text: 'Done',
                                isLoading: teamPlayerListController
                                        .SAVE_STATUS.value ==
                                    API_STATUS.LOADING,
                              ),
                            ),
                          ],
                        )
                      : NoDataScreen(
                          title: 'Add Player',
                          message: "Let's add players to your team",
                          showButton: false,
                          btnText: 'Add Player',
                          onPress: () =>
                              playerListController.showAddPlayerBottomSheet(),
                        ),
                  Positioned(
                    bottom: 84,
                    right: 16,
                    child: AnimatedSlide(
                      duration: const Duration(milliseconds: 400),
                      offset: teamPlayerListController
                              .showFloatingActionButton.value
                          ? Offset.zero
                          : const Offset(0, 16),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 400),
                        opacity: teamPlayerListController
                                .showFloatingActionButton.value
                            ? 1
                            : 0,
                        child: CustomFloatingActionButton(
                          onPress:
                              teamPlayerListController.showAddPlayerBottomSheet,
                        ),
                      ),
                    ),
                  )
                ],
              )
            : const LoadingScreen(),
      ),
    );
  }
}
