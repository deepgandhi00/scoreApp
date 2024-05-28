import 'dart:io';

import 'package:flutter/material.dart';
import 'package:score_keeper/components/buttons/baseButton.dart';
import 'package:score_keeper/components/buttons/outlineButton.dart';
import 'package:score_keeper/components/custom/conditionalImage.dart';
import 'package:score_keeper/components/textFields/baseTextField.dart';
import 'package:score_keeper/screens/teamList/models/teamModel.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/utils.dart';

class CreateTeamDialog extends StatelessWidget {
  final Function closeDialog;
  final String filePath;
  final Function fileSelectCallBack;
  final bool isEditTeam;
  final TextEditingController teamNameController;
  final Function createTeamPress;
  final Function(BuildContext) deleteTeamPress;
  final String? teamNameError;
  final bool isLoading;
  final TeamModel? currentEditTeam;
  final bool isSuccess;

  const CreateTeamDialog({
    Key? key,
    required this.closeDialog,
    required this.filePath,
    required this.fileSelectCallBack,
    required this.isEditTeam,
    required this.teamNameController,
    required this.createTeamPress,
    required this.deleteTeamPress,
    this.teamNameError,
    required this.isLoading,
    this.currentEditTeam,
    this.isSuccess = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
                onTap: () => closeDialog(),
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
                Text(
                  isEditTeam ? 'Edit' : 'Create',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                ConditionalImage(
                  fileSelectCallBack: fileSelectCallBack,
                  width: 70,
                  imageUrl:
                      currentEditTeam != null ? currentEditTeam!.logo : null,
                  filePath: filePath,
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: BaseTextField(
                    labelText: 'Team Name',
                    isRequired: true,
                    controller: teamNameController,
                    hasBorder: false,
                    showUnderLineBorder: true,
                    textAlign: TextAlign.center,
                    alignLabelWithHint: true,
                    errorText: teamNameError,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: BaseButton(
                    onPressed: () => createTeamPress(),
                    text: isEditTeam ? 'Update' : 'Create',
                    isLoading: isLoading,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                isEditTeam
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: OutlineButton(
                          onPressed: () => deleteTeamPress(context),
                          text: 'Delete',
                          borderColor: CustomColors.lightRed,
                          textColor: CustomColors.lightRed,
                        ),
                      )
                    : Container(),
                const SizedBox(
                  height: 24,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
