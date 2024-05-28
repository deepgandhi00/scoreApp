import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:score_keeper/components/buttons/baseButton.dart';
import 'package:score_keeper/components/buttons/outlineButton.dart';
import 'package:score_keeper/components/custom/networkImageWithPlaceholder.dart';
import 'package:score_keeper/screens/home/controllers/homeController.dart';
import 'package:score_keeper/screens/playerList/controllers/playerListController.dart';
import 'package:score_keeper/screens/teamList/models/teamModel.dart';
import 'package:score_keeper/screens/teamMatches/view/teamMatchesView.dart';
import 'package:score_keeper/screens/teamPlayerList/view/teamPlayerListView.dart';
import 'package:score_keeper/utils/colors.dart';

class TeamListItem extends StatelessWidget {
  final void Function(
      {required BuildContext context,
      bool isEditTeam,
      TeamModel? currentEditTeam}) onEditPress;
  final BuildContext buildContext;
  final TeamModel teamModel;
  final PlayerListController playerListController;
  final HomeController homeController;

  const TeamListItem({
    Key? key,
    required this.onEditPress,
    required this.buildContext,
    required this.teamModel,
    required this.playerListController,
    required this.homeController,
  }) : super(key: key);

  void onMatchesPress() {
    Get.toNamed(TeamMatchesView.routeName, parameters: {
      'teamId': '${teamModel.teamId!}',
      'name': teamModel.name,
    });
  }

  void onPlayersPress() {
    Get.toNamed(TeamPlayerListView.routeName,
        parameters: {
          'teamId': teamModel.teamId.toString(),
          'name': teamModel.name
        },
        preventDuplicates: false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: CustomColors.appBarColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => onEditPress(
                      context: context,
                      currentEditTeam: teamModel,
                      isEditTeam: true,
                    ),
                    child: NetworkImageWithPlaceHolder(
                      imageUrl: teamModel.logo,
                      width: 70,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 172,
                        child: Text(
                          teamModel.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          BaseButton(
                            onPressed: onMatchesPress,
                            text: 'Matches',
                            width: 90,
                            fontSize: 12,
                            height: 30,
                          ),
                          OutlineButton(
                            onPressed: onPlayersPress,
                            text: 'Players',
                            width: 90,
                            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                            fontSize: 12,
                            height: 30,
                            textColor: Colors.white,
                            borderColor: Colors.white,
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                GestureDetector(
                  onTap: () => onEditPress(
                    context: context,
                    currentEditTeam: teamModel,
                    isEditTeam: true,
                  ),
                  child: const Image(
                    image: AssetImage('assets/images/edit_icon.png'),
                    width: 18,
                    height: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
