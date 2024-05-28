import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:score_keeper/components/buttons/baseButton.dart';
import 'package:score_keeper/components/buttons/outlineButton.dart';
import 'package:score_keeper/components/custom/networkImageWithPlaceholder.dart';
import 'package:score_keeper/components/textFields/baseTextField.dart';
import 'package:score_keeper/components/textFields/dropDown.dart';
import 'package:score_keeper/screens/matchDetails/compoonents/addGoalPlayerDropDown.dart';
import 'package:score_keeper/screens/matchDetails/controllers/matchDetailsController.dart';
import 'package:score_keeper/screens/matchDetails/models/scoreTypeModel.dart';
import 'package:score_keeper/screens/matchesTabs/models/matchModel.dart';
import 'package:score_keeper/screens/playerList/models/playerModels/player.dart';

class AddGoalDialog extends StatelessWidget {
  final Function closeBottomSheet;
  final List<Player> players;
  final Function(dynamic) setPlayerId;
  final int? currentPlayerId;
  final Function(dynamic) setAssistPlayerId;
  final int? assistPlayerId;
  final TextEditingController mintController;
  final Rx<bool> isSecondaryTeam;
  final MatchModel matchModel;
  final Function onPressAddGoal;
  final Function onPressEditGoal;
  final Function onPressDeleteGoal;
  final bool isEdit;
  final List<ScoreTypeModel> scoreTypes;
  final int? scoreTypeId;
  final MatchDetailsController matchDetailsController;
  final bool isLoading;
  final bool isDelete;
  final String? mintError;

  const AddGoalDialog({
    Key? key,
    required this.closeBottomSheet,
    required this.players,
    required this.setPlayerId,
    required this.currentPlayerId,
    required this.mintController,
    required this.isSecondaryTeam,
    required this.matchModel,
    required this.assistPlayerId,
    required this.setAssistPlayerId,
    required this.onPressAddGoal,
    required this.onPressDeleteGoal,
    required this.onPressEditGoal,
    required this.isEdit,
    required this.scoreTypes,
    required this.scoreTypeId,
    required this.matchDetailsController,
    required this.isLoading,
    required this.isDelete,
    this.mintError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              right: 0,
              child: IconButton(
                onPressed: () => closeBottomSheet(),
                icon: const Icon(Icons.close),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 16,
                ),
                Text(
                  isEdit ? 'Edit Goal' : 'Add Goal',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                getTeamLogo(),
                const SizedBox(
                  height: 12,
                ),
                isSecondaryTeam.value
                    ? Container()
                    : AddGoalPlayerDropDown(
                        setValue: setPlayerId,
                        players: players,
                        currentValue: currentPlayerId,
                        label: 'Scoring Player',
                        hintText: 'Select Scoring Player',
                      ),
                const SizedBox(
                  height: 12,
                ),
                isSecondaryTeam.value
                    ? Container()
                    : AddGoalPlayerDropDown(
                        setValue: setAssistPlayerId,
                        players: players,
                        currentValue: assistPlayerId,
                        label: 'Assisting Player',
                        hintText: 'Select Assisting Player',
                      ),
                const SizedBox(
                  height: 12,
                ),
                BaseTextField(
                  labelText: 'Time of Goal',
                  isRequired: false,
                  controller: mintController,
                  errorText: mintError,
                  onChange: () => matchDetailsController.setMintError(null),
                  showUnderLineBorder: true,
                  focusedLabelColor: Colors.white,
                  hasBorder: false,
                  focusedUnderLineBorderColor: Colors.white,
                ),
                const SizedBox(
                  height: 12,
                ),
                isSecondaryTeam.value
                    ? Container()
                    : DropDown(
                        label: 'Goal Type',
                        hintText: 'Select Goal Type',
                        setValue: (dynamic id) =>
                            matchDetailsController.setScoreType(id),
                        options: scoreTypes,
                        currentValue: matchDetailsController.scoreTypeId.value,
                        children: getDropDownItems(),
                      ),
                const SizedBox(
                  height: 12,
                ),
                isEdit
                    ? Row(
                        children: [
                          BaseButton(
                            onPressed:
                                isEdit ? onPressEditGoal : onPressAddGoal,
                            text: isEdit ? 'Save' : 'Add Goal',
                            width: MediaQuery.of(context).size.width / 2 - 24,
                            isLoading: !isDelete && isLoading,
                          ),
                          OutlineButton(
                            onPressed: onPressDeleteGoal,
                            text: 'Delete',
                            width: MediaQuery.of(context).size.width / 2 - 24,
                            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                            isLoading: isDelete && isLoading,
                          )
                        ],
                      )
                    : BaseButton(
                        onPressed: isEdit ? onPressEditGoal : onPressAddGoal,
                        text: isEdit ? 'Edit Goal' : 'Add Goal',
                        width: MediaQuery.of(context).size.width - 64,
                        isLoading: !isDelete && isLoading,
                      ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getTeamLogo() {
    if (isSecondaryTeam.value) {
      return NetworkImageWithPlaceHolder(
        imageUrl: matchModel.secondaryTeamLogo,
        width: 70,
      );
    } else {
      return NetworkImageWithPlaceHolder(
        imageUrl: matchModel.primaryTeamLogo,
        width: 70,
      );
    }
  }

  List<DropdownMenuItem<dynamic>> getDropDownItems() {
    List<DropdownMenuItem<dynamic>> widgetList = [];
    for (int i = 0; i < scoreTypes.length; i++) {
      widgetList.add(
        DropdownMenuItem(
          value: scoreTypes.elementAt(i).score_type_id,
          child: Text(
            scoreTypes.elementAt(i).name,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
    return widgetList;
  }
}
