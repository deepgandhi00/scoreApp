import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:score_keeper/components/custom/networkImageWithPlaceholder.dart';
import 'package:score_keeper/models/matchStatusEnum.dart';
import 'package:score_keeper/screens/matchDetails/view/matchDetailsView.dart';
import 'package:score_keeper/screens/matchesTabs/models/matchModel.dart';
import 'package:score_keeper/screens/publicMatchDetails/views/publicMatchDetailsView.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/stringUtils.dart';
import 'package:score_keeper/utils/utils.dart';

class MatchesListItem extends StatelessWidget {
  final MatchModel matchModel;
  final FROM_SCREEN fromScreen;
  final int elapsedTime;
  final Function? onPause;
  final Function? onResume;
  final bool isLoading;
  final Function(MatchModel matchModel)? onEditPress;
  final Function(int matchId)? onDeletePress;

  const MatchesListItem({
    Key? key,
    required this.matchModel,
    this.fromScreen = FROM_SCREEN.MATCH_LIST,
    this.elapsedTime = 0,
    this.onPause,
    this.onResume,
    this.isLoading = false,
    this.onEditPress,
    this.onDeletePress,
  }) : super(key: key);

  void onItemPress() {
    Map<String, String> data = {
      'matchId': '${matchModel.matchId}',
      'fromScreen': fromScreen.toString(),
    };
    if (matchModel.primaryTeamLogo != null) {
      data['primaryTeamLogo'] = matchModel.primaryTeamLogo!;
    }

    if (matchModel.owner == false) {
      Get.toNamed(PublicMatchDetailsView.routeName, parameters: data);
    } else {
      Get.toNamed(MatchDetailsView.routeName, parameters: data);
    }
  }

  String getStatusValue() {
    if (fromScreen == FROM_SCREEN.MATCH_LIST) {
      if (matchModel.status == MatchStatusEnum.IN_PROGRESS ||
          matchModel.status == MatchStatusEnum.PAUSED) {
        return StringUtils.PROGRESS;
      } else if (matchModel.status == MatchStatusEnum.COMPLETED) {
        return StringUtils.FULL_TIME;
      } else {
        return StringUtils.NOT_STARTED;
      }
    } else {
      if (matchModel.status == MatchStatusEnum.IN_PROGRESS) {
        return StringUtils.LIVE;
      } else if (matchModel.status == MatchStatusEnum.PAUSED) {
        return StringUtils.PAUSED;
      } else if (matchModel.status == MatchStatusEnum.COMPLETED) {
        return StringUtils.FULL_TIME;
      } else {
        return StringUtils.NOT_STARTED;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (fromScreen != FROM_SCREEN.MATCH_DETAILS &&
            fromScreen != FROM_SCREEN.PUBLIC_VIEW &&
            fromScreen != FROM_SCREEN.SHARE_DETAILS) {
          onItemPress();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: CustomColors.appBarColor),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Date View
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        matchModel.date,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    (fromScreen == FROM_SCREEN.MATCH_LIST) &&
                            matchModel.isPublic == 1
                        ? Expanded(
                            flex: 1,
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 2),
                                decoration: BoxDecoration(
                                  color: CustomColors.redText,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                            ),
                          )
                        : matchModel.status == MatchStatusEnum.IN_PROGRESS &&
                                (fromScreen == FROM_SCREEN.PUBLIC_VIEW ||
                                    (fromScreen == FROM_SCREEN.MATCH_DETAILS &&
                                        matchModel.isPublic == 1))
                            ? Expanded(
                                flex: 1,
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 3),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.sensors,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          StringUtils.LIVE,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Expanded(flex: 1, child: Container()),
                    (fromScreen == FROM_SCREEN.MATCH_LIST &&
                                matchModel.owner == true) ||
                            fromScreen == FROM_SCREEN.TEAM_LIST
                        ? Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    onEditPress!(matchModel);
                                  },
                                  child: Image.asset(
                                    'assets/images/edit_icon.png',
                                    width: 16,
                                    height: 19,
                                  ),
                                ),
                                const SizedBox(
                                  width: 24,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    onDeletePress!(matchModel.matchId);
                                  },
                                  child: Image.asset(
                                    'assets/images/delete_icon.png',
                                    width: 16,
                                    height: 19,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Expanded(flex: 2, child: Container())
                  ],
                ),
              ),

              // Divider
              fromScreen == FROM_SCREEN.SHARE_DETAILS
                  ? Container(
                      height: 8,
                    )
                  : const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      child: Divider(),
                    ),

              // Score View
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    getTeamView(
                      name: matchModel.primaryTeamName,
                      image: matchModel.primaryTeamLogo,
                    ),
                    getScoreView(
                        '${matchModel.primaryTeamGoals} - ${matchModel.secondaryTeamGoals}',
                        isLoading),
                    getTeamView(
                      name: matchModel.secondaryTeamName,
                      image: matchModel.secondaryTeamLogo,
                    ),
                  ],
                ),
              ),

              // Divider
              fromScreen == FROM_SCREEN.SHARE_DETAILS
                  ? Container(
                      height: 8,
                    )
                  : const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(),
                    ),

              // Address View
              matchModel.location != null && matchModel.location!.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                      child: Row(
                        children: [
                          const Icon(Icons.pin_drop),
                          const SizedBox(
                            width: 6.0,
                          ),
                          Text(
                            matchModel.location ?? '',
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: CustomColors.lightGray),
                          )
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTeamView({String? image, String name = StringUtils.TEAM}) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          NetworkImageWithPlaceHolder(
            imageUrl: image,
            width: 64,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget getScoreView(String score, bool isLoading) {
    if (matchModel.status == MatchStatusEnum.NOT_STARTED &&
        matchModel.kickOffTime != null) {
      return Expanded(
          child: Column(
        children: [
          const Text(
            StringUtils.KICK_OFF,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: CustomColors.primaryColor),
          ),
          const SizedBox(
            height: 18,
          ),
          Text(
            matchModel.kickOffTime!,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: CustomColors.primaryColor,
            ),
          ),
        ],
      ));
    } else {
      if (fromScreen == FROM_SCREEN.MATCH_LIST ||
          fromScreen == FROM_SCREEN.TEAM_LIST ||
          fromScreen == FROM_SCREEN.PUBLIC_VIEW) {
        return Expanded(
          flex: 1,
          child: Column(
            children: [
              Text(
                score,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: CustomColors.primaryColor,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                getStatusValue(),
                style: TextStyle(
                    color: CustomColors.redText,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 8,
              ),
              fromScreen == FROM_SCREEN.PUBLIC_VIEW
                  ? getMatchStatusActionButtons(isLoading)
                  : Container(),
            ],
          ),
        );
      } else {
        return Expanded(
          flex: 1,
          child: Column(
            children: [
              Text(
                getStatusValue(),
                style: TextStyle(
                  color: CustomColors.redText,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                score,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: CustomColors.primaryColor,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              matchModel.status == MatchStatusEnum.COMPLETED ||
                      fromScreen == FROM_SCREEN.SHARE_DETAILS ||
                      fromScreen == FROM_SCREEN.PUBLIC_VIEW
                  ? Container()
                  : Text(
                      getElapsedTimeInMinutes(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
              const SizedBox(
                height: 8,
              ),
              getMatchStatusActionButtons(isLoading),
            ],
          ),
        );
      }
    }
  }

  Widget getMatchStatusActionButtons(bool isLoading) {
    if ((fromScreen == FROM_SCREEN.SHARE_DETAILS ||
            fromScreen == FROM_SCREEN.PUBLIC_VIEW) &&
        matchModel.status != MatchStatusEnum.COMPLETED) {
      return Container(
        width: 100,
        height: 28,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: CustomColors.primaryColor,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            getElapsedTimeInMinutes(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: CustomColors.primaryColor,
            ),
          ),
        ),
      );
    } else if (matchModel.status == MatchStatusEnum.IN_PROGRESS ||
        matchModel.progress == MatchStatusEnum.PAUSED ||
        matchModel.progress == MatchStatusEnum.STARTED) {
      return GestureDetector(
        onTap: onActionButtonTap,
        child: Container(
          width: 100,
          height: 28,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(
              color: matchModel.progress == MatchStatusEnum.PAUSED
                  ? CustomColors.primaryColor
                  : CustomColors.lightGray,
              width: 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: isLoading
              ? const Center(
                  child: SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 1,
                    ),
                  ),
                )
              : Center(
                  child: Text(
                    getMatchActionButtonText(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: matchModel.progress == MatchStatusEnum.PAUSED
                          ? CustomColors.primaryColor
                          : CustomColors.lightGray,
                    ),
                  ),
                ),
        ),
      );
    } else {
      return Container();
    }
  }

  String getMatchActionButtonText() {
    if (matchModel.progress == MatchStatusEnum.PAUSED) {
      return StringUtils.RESUME;
    } else {
      return StringUtils.PAUSE;
    }
  }

  String getElapsedTimeInMinutes() {
    int minutes = (elapsedTime / 60).floor();

    int secs = elapsedTime - (minutes * 60).floor();

    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void onActionButtonTap() {
    if (matchModel.progress == MatchStatusEnum.PAUSED && onResume != null) {
      onResume!();
    } else if (onPause != null) {
      onPause!();
    }
  }
}
