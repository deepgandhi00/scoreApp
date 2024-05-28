import 'package:flutter/material.dart';
import 'package:score_keeper/screens/matchDetails/controllers/matchDetailsController.dart';
import 'package:score_keeper/screens/matchDetails/models/goalModel.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/utils.dart';

class SummaryItem extends StatelessWidget {
  final Function editGoal;
  final GoalModel goalModel;
  final MatchDetailsController? matchDetailsController;
  final String primaryTeamName;
  final FROM_SCREEN? fromScreen;

  const SummaryItem({
    Key? key,
    required this.editGoal,
    required this.goalModel,
    this.matchDetailsController,
    required this.primaryTeamName,
    this.fromScreen,
  }) : super(key: key);

  void onEditGoalClick() {
    matchDetailsController!.setCurrentEditGoalId(goalModel.goalId);
    if (goalModel.isSecondaryTeam == 1) {
      matchDetailsController!.mintController.text = goalModel.mins.toString();
      matchDetailsController!.isSecondaryTeam.value = true;
    } else {
      if (goalModel.playerId != null) {
        matchDetailsController!.playerId.value = goalModel.playerId!;
      }

      if (goalModel.assistPlayerId != null) {
        matchDetailsController!.assistedPlayer.value =
            goalModel.assistPlayerId!;
      }

      if (goalModel.scoreTypeId != null) {
        matchDetailsController!.scoreTypeId.value = goalModel.scoreTypeId!;
      }
      matchDetailsController!.mintController.text = goalModel.mins.toString();
    }
    editGoal();
  }

  Widget getLeftHalfPart() {
    if (goalModel.isSecondaryTeam == 0) {
      return Expanded(
        child: Row(
          children: [
            // user team goal details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    goalModel.playerName ?? primaryTeamName,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  goalModel.assistPlayerName != null
                      ? Text(
                          'Assist: ${goalModel.assistPlayerName ?? ''}',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Expanded(
        child: Text(
          '${goalModel.primaryGoalCount} - ${goalModel.secondaryGoalCount}',
          textAlign: TextAlign.end,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: CustomColors.primaryColor,
          ),
        ),
      );
    }
  }

  Widget getRightHalfPart() {
    if (goalModel.isSecondaryTeam == 0) {
      return Expanded(
        child: Text(
          '${goalModel.primaryGoalCount} - ${goalModel.secondaryGoalCount}',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      );
    } else {
      return Expanded(
        child: Row(
          children: [
            Text(
              goalModel.secondaryTeamName,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      color: CustomColors.appBarColor,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            children: [
              Text(
                "${goalModel.mins}'",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              fromScreen == FROM_SCREEN.PUBLIC_VIEW
                  ? Container()
                  : GestureDetector(
                      onTap: onEditGoalClick,
                      child: const Icon(
                        Icons.edit,
                        size: 14,
                        color: CustomColors.outlineButtonBorder,
                      ),
                    ),
            ],
          ),

          //let half item part
          getLeftHalfPart(),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Image(
              image: AssetImage('assets/images/Football.png'),
              width: 24,
              height: 24,
            ),
          ),

          //  right half item part
          getRightHalfPart(),
        ],
      ),
    );
  }
}
