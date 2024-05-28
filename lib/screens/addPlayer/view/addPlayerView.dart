import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:score_keeper/components/buttons/baseButton.dart';
import 'package:score_keeper/components/buttons/customFloatingActionButton.dart';
import 'package:score_keeper/components/custom/playerListWithTitle.dart';
import 'package:score_keeper/components/loadingScreen/loadingScreen.dart';
import 'package:score_keeper/components/noDataScreen/noDataScreen.dart';
import 'package:score_keeper/screens/addPlayer/controllers/addPlayerController.dart';
import 'package:score_keeper/screens/playerList/components/playerListItem.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/utils.dart';

import '../../playerList/models/playerModels/player.dart';

class AddPlayerView extends StatelessWidget {
  static String routeName = '/addPLayer';
  AddPlayerController addPlayerController = Get.find<AddPlayerController>();

  AddPlayerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Choose Your Starting Lineup'),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: CustomColors.appBarColor,
        ),
      ),
      body: Obx(
        () => addPlayerController.STATUS.value == API_STATUS.SUCCESS
            ? Stack(
                children: [
                  addPlayerController.lineUpPlayers.value.isNotEmpty ||
                          addPlayerController.substitutePlayers.value.isNotEmpty
                      ? Column(
                          children: [
                            Expanded(
                              child:
                                  NotificationListener<UserScrollNotification>(
                                onNotification: (notification) {
                                  if (notification.direction ==
                                      ScrollDirection.reverse) {
                                    addPlayerController
                                        .setShowFloatingActionButton(false);
                                  } else if (notification.direction ==
                                      ScrollDirection.forward) {
                                    addPlayerController
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
                                        const Text(
                                          'Select your players from the squad or add new players right here by clicking (+) button below.',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        PlayerListWithTitle(
                                          players: addPlayerController
                                              .lineUpPlayers.value,
                                          title: 'Line Up',
                                          isLineUp: true,
                                          onAddPress: addPlayerController
                                              .addToLineUpPlayers,
                                          onRemovePress: addPlayerController
                                              .removeFromLineUp,
                                        ),
                                        const SizedBox(
                                          height: 32,
                                        ),
                                        PlayerListWithTitle(
                                          players: addPlayerController
                                              .substitutePlayers.value,
                                          title: 'Substitute',
                                          isLineUp: false,
                                          onAddPress: addPlayerController
                                              .addToLineUpPlayers,
                                          onRemovePress: addPlayerController
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
                                onPressed: addPlayerController.onCreatePress,
                                text: 'Create',
                                isLoading:
                                    addPlayerController.CREATE_STATUS.value ==
                                        API_STATUS.LOADING,
                              ),
                            )
                          ],
                        )
                      : NoDataScreen(
                          title: '',
                          message:
                              'You have not added any players to the team, Go to Your Team > Players to add players!',
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          showButton: true,
                          btnText: 'Continue',
                          onPress: addPlayerController.onCreatePress,
                          isLoading: addPlayerController.CREATE_STATUS.value ==
                              API_STATUS.LOADING,
                        ),
                  Positioned(
                    bottom: 84,
                    right: 16,
                    child: AnimatedSlide(
                      duration: const Duration(milliseconds: 400),
                      offset: addPlayerController.showFloatingActionButton.value
                          ? Offset.zero
                          : const Offset(0, 16),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 400),
                        opacity:
                            addPlayerController.showFloatingActionButton.value
                                ? 1
                                : 0,
                        child: CustomFloatingActionButton(
                          onPress: addPlayerController.showAddPlayerBottomSheet,
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
