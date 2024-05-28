import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:score_keeper/components/buttons/baseButton.dart';
import 'package:score_keeper/components/loadingScreen/loadingScreen.dart';
import 'package:score_keeper/components/textFields/baseTextField.dart';
import 'package:score_keeper/screens/addMatch/components/userTeamDropDown.dart';
import 'package:score_keeper/screens/addMatch/controllers/addMatchController.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/utils.dart';

class AddMatchView extends StatelessWidget {
  static String routeName = '/addMatch';

  AddMatchController addMatchController = Get.find<AddMatchController>();

  AddMatchView({Key? key}) : super(key: key);

  void setVal(dynamic id) {
    addMatchController.setSelectedTeam(id);
  }

  void fileSelectCallBack(XFile xFile) {
    addMatchController.file.value = xFile;
  }

  Widget getTeamImage() {
    if (addMatchController.file.value.path != '') {
      return GestureDetector(
        onTap: () =>
            Utils.onPickImagePress(fileSelectCallBack: fileSelectCallBack),
        child: CircleAvatar(
          backgroundImage: FileImage(File(addMatchController.file.value.path)),
          radius: 60,
        ),
      );
    } else if (addMatchController.secondaryTeamLogo.value != null) {
      return GestureDetector(
        onTap: () =>
            Utils.onPickImagePress(fileSelectCallBack: fileSelectCallBack),
        child: CircleAvatar(
          backgroundImage:
              NetworkImage(addMatchController.secondaryTeamLogo.value!),
          radius: 60,
        ),
      );
    } else {
      return GestureDetector(
        onTap: () =>
            Utils.onPickImagePress(fileSelectCallBack: fileSelectCallBack),
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(120),
            color: CustomColors.imagePickBackground,
          ),
          child: const Center(
            child: Image(
              image: AssetImage('assets/images/camera_icon.png'),
              width: 32,
              height: 32,
            ),
          ),
        ),
      );
    }
  }

  void _showDatePicker(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: addMatchController.selectedDate.value,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(2100),
    );

    addMatchController.setSelectedDate(date!);
  }

  void _showTimePicker(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: addMatchController.selectedTime.value ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? Container(),
        );
      },
    );

    addMatchController.setSelectedTime(time);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Match'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Obx(
          () => addMatchController.STATUS.value == API_STATUS.SUCCESS
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Text(
                          'Select Your Team',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 22),
                          decoration: BoxDecoration(
                            color: CustomColors.appBarColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              UserTeamDropDown(
                                setVal: setVal,
                                teams: addMatchController.teams,
                                currentValue:
                                    addMatchController.selectedTeamId.value,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'Create Opponent Team',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 22),
                          decoration: BoxDecoration(
                            color: CustomColors.appBarColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getTeamImage(),
                              const SizedBox(
                                height: 16,
                              ),
                              BaseTextField(
                                labelText: 'Team Name',
                                controller:
                                    addMatchController.teamNameController,
                                focusedLabelColor: Colors.white,
                                showUnderLineBorder: true,
                                errorText:
                                    addMatchController.teamNameError.value,
                                onChange: () =>
                                    addMatchController.setTeamNameError(null),
                                isRequired: true,
                              ),
                              BaseTextField(
                                labelText: 'Date',
                                controller: addMatchController.dateController,
                                focusedLabelColor: Colors.white,
                                showUnderLineBorder: true,
                                onTap: () => _showDatePicker(context),
                                isRequired: false,
                              ),
                              BaseTextField(
                                labelText: 'Kick Off',
                                controller:
                                    addMatchController.kickOffController,
                                focusedLabelColor: Colors.white,
                                showUnderLineBorder: true,
                                onTap: () => _showTimePicker(context),
                                isRequired: false,
                              ),
                              BaseTextField(
                                labelText: 'Location',
                                controller:
                                    addMatchController.locationController,
                                focusedLabelColor: Colors.white,
                                showUnderLineBorder: true,
                                isRequired: false,
                              ),
                              BaseTextField(
                                labelText: 'League',
                                controller: addMatchController.leagueController,
                                focusedLabelColor: Colors.white,
                                showUnderLineBorder: true,
                                isRequired: false,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      'Do you want to make this match public?',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Switch(
                                    value:
                                        addMatchController.isPublicMatch.value,
                                    onChanged:
                                        addMatchController.setIsPublicMatch,
                                  ),
                                ],
                              ),
                              const Text(
                                'This means you can share the match with others through a shareable link. Other users can view and follow the live score as you update it.',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: CustomColors.greyText,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          color: CustomColors.appBarColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: BaseButton(
                            onPressed: addMatchController.onNextPress,
                            text: addMatchController.isEditMatch
                                ? 'Done'
                                : 'Next',
                            isLoading: addMatchController.UPDATE_STATUS.value ==
                                API_STATUS.LOADING,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : const LoadingScreen(),
        ),
      ),
    );
  }
}
