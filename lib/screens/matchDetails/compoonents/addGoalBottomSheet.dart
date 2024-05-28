import 'package:flutter/material.dart';
import 'package:score_keeper/components/buttons/baseButton.dart';
import 'package:score_keeper/components/custom/networkImageWithPlaceholder.dart';
import 'package:score_keeper/screens/matchesTabs/models/matchModel.dart';
import 'package:score_keeper/screens/teamList/models/teamModel.dart';

class AddGoalBottomSheet extends StatelessWidget {
  final Function closeBottomSheet;
  final bool radioValue;
  final Function(bool?) setRadioValue;
  final MatchModel matchModel;
  final Function onOkayPress;
  final bool isLoading;

  const AddGoalBottomSheet({
    Key? key,
    required this.closeBottomSheet,
    required this.radioValue,
    required this.setRadioValue,
    required this.matchModel,
    required this.onOkayPress,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
            children: [
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Select Team',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  getRadioSwitch(matchModel, false),
                  getRadioSwitch(matchModel, true),
                ],
              ),
              Expanded(child: Container()),
              BaseButton(
                onPressed: onOkayPress,
                text: 'Okay',
                isLoading: isLoading,
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getRadioSwitch(MatchModel matchModel, bool isSecondary) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setRadioValue(isSecondary),
        child: Column(
          children: [
            NetworkImageWithPlaceHolder(
              imageUrl: isSecondary
                  ? matchModel.secondaryTeamLogo
                  : matchModel.primaryTeamLogo,
              width: 70,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              isSecondary
                  ? matchModel.secondaryTeamName
                  : matchModel.primaryTeamName,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Radio<bool>(
              value: isSecondary,
              groupValue: radioValue,
              onChanged: setRadioValue,
            )
          ],
        ),
      ),
    );
  }
}
