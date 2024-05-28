import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:score_keeper/components/buttons/baseButton.dart';
import 'package:score_keeper/components/buttons/outlineButton.dart';
import 'package:score_keeper/di/services/teams/teamService.dart';
import 'package:score_keeper/screens/matchesTabs/controllers/matchesTabController.dart';
import 'package:score_keeper/screens/playerList/controllers/playerListController.dart';
import 'package:score_keeper/screens/playerList/view/playerListView.dart';
import 'package:score_keeper/screens/teamList/models/teamListModel.dart';
import 'package:score_keeper/screens/teamList/models/teamModel.dart';
import 'package:score_keeper/screens/teamPlayerList/view/teamPlayerListView.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/firebaseMessagingUtils.dart';
import 'package:score_keeper/utils/utils.dart';
import 'package:score_keeper/utils/validations.dart';

class TeamListController extends GetxController {
  var STATUS = API_STATUS.IDLE.obs;
  TextEditingController teamNameController = TextEditingController();
  Rx<XFile> file = XFile('').obs;
  final teamListModel = Rxn<TeamListModel>();
  TeamService teamService = Get.find();
  var CREATE_TEAM_STATUS = API_STATUS.IDLE.obs;
  final currentEditTeam = Rxn<TeamModel>();
  final DELETE_TEAM_STATUS = API_STATUS.IDLE.obs;
  final currentTeamId = Rxn<int>();
  final teamNameError = Rxn<String>();
  final showFloatingActionButton = true.obs;

  setCurrentEditTeam(TeamModel team) => currentEditTeam.value = team;

  setShowFloatingActionButton(bool showButton) =>
      showFloatingActionButton.value = showButton;

  @override
  void onReady() {
    userTeams();
    super.onReady();
  }

  @override
  void onClose() {
    STATUS.value = API_STATUS.IDLE;
    teamListModel.value = null;
    currentTeamId.value = null;
    super.onClose();
  }

  void userTeams({closeDialog = false, bool showSuccessDialog = false}) async {
    if (closeDialog) {
      file.value = XFile('');
      teamNameController.clear();
      Get.back();
    }
    STATUS.value = API_STATUS.LOADING;
    final response = await teamService.getTeams();

    if (response.isSuccessful) {
      teamListModel.value = response.body;
      if (showSuccessDialog && teamListModel.value!.data.length == 1) {
        showSuccessAlertDialog();
      }
      STATUS.value = API_STATUS.SUCCESS;
    } else {
      STATUS.value = API_STATUS.ERROR;
    }
  }

  void setPickedImage(XFile pickedFile) {
    file.value = pickedFile;
  }

  void createEditTeamPress() async {
    final MatchesTabController matchesTabController = Get.find();
    final PlayerListController playerListController = Get.find();
    String? errMsg = Validations.validateNameFields(
        value: teamNameController.text, fieldName: 'team name');

    if (errMsg != null) {
      teamNameError.value = errMsg;
      return;
    }

    CREATE_TEAM_STATUS.value = API_STATUS.LOADING;

    if (currentEditTeam.value != null) {
      final response = await teamService.editTeam(
        currentEditTeam.value!.teamId!,
        teamNameController.text,
        file.value.path.isNotEmpty ? file.value.path : null,
      );

      if (response.isSuccessful) {
        CREATE_TEAM_STATUS.value = API_STATUS.SUCCESS;
        userTeams(closeDialog: true);
      } else {
        var errorMsg = response.error as Map<String, String>;
        teamNameError.value = errorMsg['message']!;
        CREATE_TEAM_STATUS.value = API_STATUS.ERROR;
      }
    } else {
      final response = await teamService.createTeam(
        teamNameController.text,
        file != null && file.value != null && file.value.path.isNotEmpty
            ? file.value.path
            : null,
      );

      if (response.isSuccessful) {
        if (playerListController.players.value != null &&
            playerListController.players.value!.isEmpty) {
          FirebaseMessagingUtils.schedulePlayerNotification();
        }
        if (matchesTabController.matches.value!.data.isEmpty) {
          checkAndScheduleNotification();
        }
        CREATE_TEAM_STATUS.value = API_STATUS.SUCCESS;
        userTeams(
          closeDialog: true,
          showSuccessDialog: true,
        );
      } else {
        var errorMsg = response.error as Map<String, String>;
        teamNameError.value = errorMsg['message']!;
        CREATE_TEAM_STATUS.value = API_STATUS.ERROR;
      }
    }
  }

  void deleteTeamPress() async {
    DELETE_TEAM_STATUS.value = API_STATUS.LOADING;

    final response = await teamService.deleteTeam(currentEditTeam.value!);

    if (response.isSuccessful) {
      DELETE_TEAM_STATUS.value = API_STATUS.SUCCESS;
      userTeams(closeDialog: true);
    } else {
      var errorMsg = response.error as Map<String, dynamic>;
      String msg = errorMsg['message']!;
      DELETE_TEAM_STATUS.value = API_STATUS.ERROR;
      Get.back();
      Utils.showErrorBottomSheet(
          message: msg,
          onOkayPress: () {
            DELETE_TEAM_STATUS.value = API_STATUS.IDLE;
          });
    }
  }

  void goToPlayers(int teamId) {
    currentTeamId.value = teamId;
    Get.toNamed(PlayerListView.routeName);
  }

  checkAndScheduleNotification() async {
    final PlayerListController playerListController = Get.find();
    if (playerListController.players.value!.isNotEmpty) {
      bool isScheduled = await Utils.getIsScheduledMatchNotification();
      if (!isScheduled) {
        FirebaseMessagingUtils.scheduleMatchNotification();
      }
    }
  }

  void showSuccessAlertDialog() {
    BuildContext context = Get.context!;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            content: Container(
              width: MediaQuery.of(context).size.width - 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: CustomColors.appBarColor,
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 8,
                    right: 16,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: const Image(
                        image: AssetImage('assets/images/close_icon.png'),
                        width: 18,
                        height: 18,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      Image.asset(
                        'assets/images/success.png',
                        height: 100,
                        width: 114,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      const Text(
                        'Congratulations!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'You have successfully created a team.\nNow start adding the players to your team.',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlineButton(
                              onPressed: () => Get.back(),
                              text: 'Skip',
                              width: MediaQuery.of(context).size.width / 2 - 64,
                            ),
                            BaseButton(
                              onPressed: () {
                                Get.back();
                                Get.toNamed(TeamPlayerListView.routeName,
                                    parameters: {
                                      'teamId': teamListModel.value!.data.toList().elementAt(0).teamId.toString(),
                                      'name': teamListModel.value!.data.toList().elementAt(0).name,
                                    },
                                    preventDuplicates: false);
                              },
                              text: 'Continue',
                              width: MediaQuery.of(context).size.width / 2 - 64,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
