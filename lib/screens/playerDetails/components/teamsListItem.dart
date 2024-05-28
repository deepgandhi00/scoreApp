import 'package:flutter/material.dart';
import 'package:score_keeper/components/custom/networkImageWithPlaceholder.dart';
import 'package:score_keeper/screens/teamList/models/teamModel.dart';
import 'package:score_keeper/utils/colors.dart';

class TeamListItem extends StatelessWidget {
  final TeamModel teamModel;
  final int playerId;
  final Function(BuildContext context, int teamId, int playerId) onDeletePress;

  const TeamListItem(
      {Key? key,
      required this.teamModel,
      required this.onDeletePress,
      required this.playerId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: CustomColors.appBarColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            NetworkImageWithPlaceHolder(
              imageUrl: teamModel.logo,
              width: 60,
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Text(
                teamModel.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            GestureDetector(
              onTap: () => onDeletePress(context, teamModel.teamId!, playerId),
              child: Image.asset(
                'assets/images/exit_team.png',
                width: 20,
                height: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
