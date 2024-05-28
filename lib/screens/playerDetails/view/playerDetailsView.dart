import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:score_keeper/components/custom/networkImageWithPlaceholder.dart';
import 'package:score_keeper/components/loadingScreen/loadingScreen.dart';
import 'package:score_keeper/screens/playerDetails/components/teamsListItem.dart';
import 'package:score_keeper/screens/playerDetails/controllers/playerDetailsController.dart';
import 'package:score_keeper/screens/teamList/models/teamModel.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/utils.dart';

class PlayerDetailsView extends StatelessWidget {
  static String routeName = '/playerDetails';
  PlayerDetailsController playerDetailsController = Get.find();

  PlayerDetailsView({Key? key}) : super(key: key);

  void onEditPress() {
    playerDetailsController.showAddPlayerBottomSheet();
  }

  void onBackPress() {
    Get.back();
  }

  Widget getDetailItems(
      {required String title, required String value, bool isLast = false}) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        color: CustomColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: CustomColors.primaryColor),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  void onDeletePress(BuildContext context, int teamId, int playerId) {
    Utils.showConfirmBottomSheet(
        title: 'Exit',
        message: 'Are you sure you want to exit from this team?',
        deleteButtonText: 'Yes',
        cancelButtonText: 'No',
        onDeletePress: () {
          playerDetailsController.deleteTeam(teamId, playerId);
        },
        isLoading: playerDetailsController.EDIT_STATUS);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: CustomColors.background,
      body: SafeArea(
        top: false,
        child: Obx(
          () => playerDetailsController.STATUS.value == API_STATUS.SUCCESS
              ? Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/images/match_details_background.png',
                            ),
                            fit: BoxFit.fitWidth,
                            alignment: AlignmentDirectional.topStart),
                      ),
                    ),
                    AnnotatedRegion<SystemUiOverlayStyle>(
                      value: const SystemUiOverlayStyle(
                        statusBarColor: Colors.transparent,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 36,
                          ),
                          Stack(
                            children: [
                              IconButton(
                                onPressed: Get.back,
                                icon: const Icon(
                                  Icons.arrow_back,
                                  size: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: CustomColors.appBarColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: onEditPress,
                                            child: NetworkImageWithPlaceHolder(
                                              imageUrl: playerDetailsController
                                                          .playerDetails
                                                          .value !=
                                                      null
                                                  ? playerDetailsController
                                                      .playerDetails
                                                      .value!
                                                      .photo
                                                  : null,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 150,
                                                child: Text(
                                                  playerDetailsController
                                                      .playerDetails
                                                      .value!
                                                      .name!,
                                                  style: const TextStyle(
                                                    fontSize: 26,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                  ),
                                                  maxLines: 5,
                                                ),
                                              ),
                                              Text(
                                                playerDetailsController
                                                        .playerDetails
                                                        .value!
                                                        .position ??
                                                    '',
                                                style: TextStyle(),
                                              )
                                            ],
                                          )
                                        ],
                                      )),
                                      IconButton(
                                        onPressed: onEditPress,
                                        icon: const Icon(
                                          Icons.edit,
                                          size: 22,
                                          color:
                                              CustomColors.outlineButtonBorder,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      getDetailItems(
                                          value:
                                              '${playerDetailsController.playerDetails.value!.matchesCount}',
                                          title: 'Matches'),
                                      getDetailItems(
                                          value:
                                              '${playerDetailsController.playerDetails.value!.goalsCount}',
                                          title: 'Goals'),
                                      getDetailItems(
                                          value:
                                              '${playerDetailsController.playerDetails.value!.assistsCount}',
                                          title: 'Assists',
                                          isLast: true),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 0),
                            child: Text(
                              'Teams',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: ListView.builder(
                                  itemCount: playerDetailsController
                                      .playerDetails.value!.teams.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return TeamListItem(
                                      teamModel: playerDetailsController
                                          .playerDetails.value!.teams
                                          .elementAt(index),
                                      onDeletePress: onDeletePress,
                                      playerId: playerDetailsController
                                          .playerDetails.value!.playerId,
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : const LoadingScreen(),
        ),
      ),
    );
  }
}
