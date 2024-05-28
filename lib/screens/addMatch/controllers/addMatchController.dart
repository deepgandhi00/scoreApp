import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:score_keeper/di/services/match/matchService.dart';
import 'package:score_keeper/screens/addPlayer/view/addPlayerView.dart';
import 'package:score_keeper/screens/matchesTabs/controllers/matchesTabController.dart';
import 'package:score_keeper/screens/teamList/controllers/teamListController.dart';
import 'package:score_keeper/screens/teamList/models/teamModel.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/utils.dart';
import 'package:score_keeper/utils/validations.dart';

class AddMatchController extends GetxController {
  TeamListController teamListController = Get.find();

  TextEditingController teamNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController leagueController = TextEditingController();
  TextEditingController kickOffController = TextEditingController();

  MatchService matchService = Get.find();
  final STATUS = API_STATUS.IDLE.obs;
  MatchesTabController matchesTabController = Get.find();
  final teamNameError = Rxn<String>();
  final dateError = Rxn<String>();
  final locationError = Rxn<String>();
  final leagueError = Rxn<String>();
  final secondaryTeamLogo = Rxn<String>();

  Rx<XFile> file = XFile('').obs;
  final selectedTeamId = Rxn<int>();
  final UPDATE_STATUS = API_STATUS.IDLE.obs;
  final selectedDate = DateTime.now().obs;
  bool isFromTeamList = false;
  bool isEditMatch = false;
  int matchId = -1;
  Rx<bool> isPublicMatch = false.obs;
  final selectedTime = Rxn<TimeOfDay>();

  setSelectedTeam(int id) => selectedTeamId.value = id;

  setTeamNameError(String? val) => teamNameError.value = val;

  setIsPublicMatch(bool val) => isPublicMatch.value = val;

  setSelectedDate(DateTime selected) {
    selectedDate.value = selected;
    dateController.text =
        '${selected.day} ${Utils.months[selected.month - 1]}, ${selected.year}';
  }

  setSelectedTime(TimeOfDay? timeOfDay) {
    selectedTime.value = timeOfDay;
    if (timeOfDay != null) {
      kickOffController.text =
          '${timeOfDay.hour.toString().padLeft(2, '0')}:${timeOfDay.minute.toString().padLeft(2, '0')}';
    }
  }

  List<TeamModel> teams = [];

  @override
  void onInit() {
    super.onInit();
    final data = Get.parameters;
    print('data ${data}');
    if (teamListController.STATUS.value == API_STATUS.SUCCESS) {
      teams.addAll(teamListController.teamListModel.value!.data.toList());
      if (teams.isNotEmpty) {
        selectedTeamId.value = teams.first.teamId;
      }
    }

    if (data != null && data['teamId'] != null) {
      setSelectedTeam(int.parse(data['teamId']!));
      isFromTeamList = true;
      // selectedTeamId.value = int.parse(data['teamId']!);
    }

    if (data != null && data['matchId'] != null) {
      matchId = int.parse(data['matchId']!);
      isEditMatch = true;
    }

    if (data != null && data['secondaryTeamName'] != null) {
      teamNameController.text = data['secondaryTeamName']!;
    }

    if (data != null && data['date'] != null) {
      String dateString = data['date']!;
      DateTime dateTime = DateFormat('EEE, dd MMM, yyyy').parse(dateString);
      selectedDate.value = dateTime;
      dateController.text =
          '${dateTime.day} ${Utils.months[dateTime.month - 1]}, ${dateTime.year}';
    }

    if (data != null && data['secondaryTeamLogo'] != null) {
      secondaryTeamLogo.value = data['secondaryTeamLogo'];
      print('secondaryTeamLogo ${secondaryTeamLogo.value}');
    }

    if (data != null && data['primaryTeamId'] != null) {
      selectedTeamId.value = int.parse(data['primaryTeamId']!);
    }

    if (data != null && data['location'] != null) {
      locationController.text = data['location']!;
    }

    if (data != null && data['league'] != null) {
      leagueController.text = data['league']!;
    }

    if (data != null && data['kickOffTime'] != null) {
      kickOffController.text = data['kickOffTime']!;
    }

    if (data != null && data['isPublic'] != null) {
      int isPublic = int.parse(data['isPublic']!);

      if (isPublic == 1) {
        isPublicMatch.value = true;
      }
    }

    STATUS.value = API_STATUS.SUCCESS;
  }

  void onNextPress() async {
    if (isEditMatch) {
      UPDATE_STATUS.value = API_STATUS.LOADING;
      final response = await matchService.editMatch(
        matchId,
        selectedTeamId.value!,
        teamNameController.text,
        locationController.text,
        leagueController.text,
        '${selectedDate.value.year}-${selectedDate.value.month}-${selectedDate.value.day}',
        isPublicMatch.value == true ? 1 : 0,
        selectedTime.value != null ? '${kickOffController.text}' : null,
        file.value.path.isNotEmpty ? file.value.path : null,
      );

      if (response.isSuccessful) {
        matchesTabController.getMatches();
        UPDATE_STATUS.value = API_STATUS.SUCCESS;
        Get.back();
      } else {
        var error = response.error as Map<String, dynamic>;
        Utils.showErrorBottomSheet(message: error['message']);
        UPDATE_STATUS.value = API_STATUS.ERROR;
      }
    } else {
      String? validateTeamName = Validations.validateNonEmptyField(
          teamNameController.text, 'Please enter Team Name');

      if (validateTeamName != null) {
        teamNameError.value = validateTeamName;
        return;
      }

      if (isPublicMatch.value) {
        showInfoDialog();
      } else {
        // var parameters = <String, String>{
        //   'primaryTeamId': selectedTeamId.toString(),
        //   'teamName': teamNameController.text,
        //   'date': dateController.text,
        //   'location': locationController.text,
        //   'league': leagueController.text,
        //   'file': file.value.path
        // };
        Get.toNamed(AddPlayerView.routeName);
      }
    }
  }

  void showInfoDialog() {
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
              width: MediaQuery.of(context).size.width,
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
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Public View Match',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Anyone with the shareable link will be able to view the match progress in real-time, including goals, assists, and overall score. They can’t edit your match score but can share it further. Do you wish to proceed and make this match public?',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: CustomColors.textGrey,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                            Get.toNamed(AddPlayerView.routeName);
                          },
                          child: const Text(
                            'I Understand',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: CustomColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
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
