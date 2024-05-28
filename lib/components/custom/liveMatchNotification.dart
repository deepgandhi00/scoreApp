import 'package:flutter/material.dart';
import 'package:score_keeper/models/notificationMatchModel.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/stringUtils.dart';

class LiveMatchNotification extends StatelessWidget {
  final NotificationMatchModel notificationMatchModel;

  const LiveMatchNotification({Key? key, required this.notificationMatchModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: CustomColors.appBarColor),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                getTeamView(
                  name: notificationMatchModel.primaryTeamName,
                  image: null,
                ),
                getScoreView(
                    '${notificationMatchModel.primaryGoalCount} - ${notificationMatchModel.secondaryGoalCount}'),
                getTeamView(
                  name: notificationMatchModel.secondaryTeamName,
                  image: null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getTeamView({String? image, String name = StringUtils.TEAM}) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundImage: image != null
                ? FadeInImage.assetNetwork(
                    placeholder: 'assets/images/app_icon.png',
                    image: image,
                  ).image
                : Image.asset(
                    'assets/images/app_icon.png',
                    width: 70,
                    height: 70,
                    fit: BoxFit.contain,
                  ).image,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            name,
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

  Widget getScoreView(String score) {
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
          )
        ],
      ),
    );
  }

  String getStatusValue() {
    if (notificationMatchModel.status == StringUtils.IN_PROGRESS_STATUS) {
      return StringUtils.PROGRESS;
    } else if (notificationMatchModel.status == StringUtils.COMPLETED_STATUS) {
      return StringUtils.FULL_TIME;
    } else {
      return StringUtils.NOT_STARTED;
    }
  }
}
