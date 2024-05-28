import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:score_keeper/components/buttons/baseButton.dart';
import 'package:score_keeper/components/buttons/customFloatingActionButton.dart';
import 'package:score_keeper/components/buttons/outlineButton.dart';
import 'package:score_keeper/components/loadingScreen/loadingScreen.dart';
import 'package:score_keeper/components/noDataScreen/noDataScreen.dart';
import 'package:score_keeper/screens/home/controllers/homeController.dart';
import 'package:score_keeper/screens/playerList/controllers/playerListController.dart';
import 'package:score_keeper/screens/teamList/components/createTeamDialog.dart';
import 'package:score_keeper/screens/teamList/components/teamListItem.dart';
import 'package:score_keeper/screens/teamList/controllers/teamListController.dart';
import 'package:score_keeper/screens/teamList/models/teamModel.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/firebaseMessagingUtils.dart';
import 'package:score_keeper/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeamListView extends StatefulWidget {
  static String routeName = '/teamListView';

  TeamListView({Key? key}) : super(key: key);

  @override
  State<TeamListView> createState() => _TeamListViewState();
}

class _TeamListViewState extends State<TeamListView> {
  TeamListController teamListController = Get.find<TeamListController>();
  PlayerListController playerListController = Get.find();
  HomeController homeController = Get.find();

  void closeDialog() {
    teamListController.file.value = XFile('');
    teamListController.teamNameController.clear();
    teamListController.CREATE_TEAM_STATUS.value = API_STATUS.IDLE;
    Get.back();
  }

  void deleteTeamPress(BuildContext context) {
    Get.back();
    Utils.showConfirmBottomSheet(
      onDeletePress: teamListController.deleteTeamPress,
      isLoading: teamListController.DELETE_TEAM_STATUS,
    );
  }

  void fileSelectCallBack(XFile xFile) {
    teamListController.file.value = xFile;
  }

  void onCreateTeamPress(
      {required BuildContext context,
      bool isEditTeam = false,
      TeamModel? currentEditTeam}) {
    if (isEditTeam) {
      teamListController.currentEditTeam.value = currentEditTeam;
      teamListController.teamNameController.text = (currentEditTeam?.name)!;
    } else {
      teamListController.currentEditTeam.value = null;
      teamListController.teamNameController.text = '';
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Obx(
            () => AlertDialog(
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              content: CreateTeamDialog(
                closeDialog: closeDialog,
                filePath: teamListController.file.value.path,
                fileSelectCallBack: fileSelectCallBack,
                isEditTeam: isEditTeam,
                teamNameController: teamListController.teamNameController,
                createTeamPress: teamListController.createEditTeamPress,
                deleteTeamPress: deleteTeamPress,
                teamNameError: teamListController.teamNameError.value,
                isLoading: teamListController.CREATE_TEAM_STATUS.value ==
                    API_STATUS.LOADING,
                currentEditTeam: teamListController.currentEditTeam.value,
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => teamListController.STATUS.value == API_STATUS.SUCCESS
          ? Stack(
              children: [
                (teamListController.teamListModel.value?.data.isNotEmpty)!
                    ? NotificationListener<UserScrollNotification>(
                        onNotification: (notification) {
                          if (notification.direction ==
                              ScrollDirection.reverse) {
                            teamListController
                                .setShowFloatingActionButton(false);
                          } else if (notification.direction ==
                              ScrollDirection.forward) {
                            teamListController
                                .setShowFloatingActionButton(true);
                          }
                          return true;
                        },
                        child: ListView.builder(
                            itemCount: teamListController
                                .teamListModel.value?.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return TeamListItem(
                                onEditPress: onCreateTeamPress,
                                buildContext: context,
                                playerListController: playerListController,
                                teamModel: (teamListController
                                    .teamListModel.value?.data
                                    .elementAt(index))!,
                                homeController: homeController,
                              );
                            }),
                      )
                    : NoDataScreen(
                        title: 'Create Team',
                        message:
                            'Please create a team by clicking on the button below',
                        showPointer: true,
                      ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: AnimatedSlide(
                    duration: const Duration(milliseconds: 400),
                    offset: teamListController.showFloatingActionButton.value
                        ? Offset.zero
                        : const Offset(0, 16),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 400),
                      opacity: teamListController.showFloatingActionButton.value
                          ? 1
                          : 0,
                      child: CustomFloatingActionButton(
                        onPress: () => onCreateTeamPress(context: context),
                        onLongPress: () async {
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          if (preferences.containsKey('fcmToken')) {
                            String? token = preferences.getString('fcmToken');
                            Clipboard.setData(ClipboardData(text: token!));
                            Get.snackbar('', 'Copied Fcm Token');
                          } else {
                            Get.snackbar('', 'Token not available');
                          }
                        },
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
