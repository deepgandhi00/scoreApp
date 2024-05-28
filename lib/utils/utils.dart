import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:score_keeper/components/buttons/baseButton.dart';
import 'package:score_keeper/components/buttons/outlineButton.dart';
import 'package:score_keeper/screens/matchesTabs/view/matchesTabView.dart';
import 'package:score_keeper/screens/playerList/view/playerListView.dart';
import 'package:score_keeper/screens/splash/view/splashView.dart';
import 'package:score_keeper/screens/teamList/view/teamListView.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/bottomSheet/selectionBottomSheet.dart';

enum API_STATUS { IDLE, LOADING, SUCCESS, ERROR }

enum FROM_SCREEN {
  MATCH_LIST,
  MATCH_DETAILS,
  TEAM_LIST,
  PLAYER_LIST,
  SHARE_DETAILS,
  PUBLIC_VIEW,
  LINK
}

class Utils {
  static List<String> positions = ['Striker', 'Goal Keeper'];

  static int MAX_ELAPSED_TIME = 60 * 120;

  static List<Widget> homeTabs = [
    TeamListView(),
    const MatchesTabView(),
    PlayerListView(),
  ];

  static List<String> homeTabsTitle = ['Teams', 'Matches', 'Players'];

  static navigateToSplash() {
    Get.offAllNamed(SplashView.routeName);
  }

  static logoutUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // await preferences.clear();
    await preferences.remove('accessToken');
    await preferences.remove('match_scheduled');
    await preferences.remove('matchIds');
    navigateToSplash();
  }

  static onPickImagePress({required Function fileSelectCallBack}) async {
    Get.bottomSheet(
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(14),
        ),
      ),
      backgroundColor: CustomColors.appBarColor,
      isScrollControlled: true,
      SelectBottomSheet(
        fileSelectCallBack: fileSelectCallBack,
      ),
    );
  }

  static showErrorBottomSheet({
    String title = 'Error',
    String message = 'Something went wrong',
    Function? onOkayPress,
  }) {
    Get.bottomSheet(
        isDismissible: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(14),
          ),
        ),
        backgroundColor: CustomColors.appBarColor,
        isScrollControlled: true,
        Container(
          height: 250,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              BaseButton(
                  onPressed: () => {
                        Get.back(),
                        if (onOkayPress != null) {onOkayPress()}
                      }),
            ],
          ),
        ));
  }

  static addCurrentTime() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('reviewPopUp')) {
      preferences.remove('reviewPopUp');
    }
    preferences.setInt('reviewPopUp', DateTime.now().millisecondsSinceEpoch);
  }

  static Future<bool> showPopUp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.containsKey('reviewPopUp')) {
      int dateShowned = preferences.getInt('reviewPopUp')!;

      if (DateTime.now()
              .difference(DateTime.fromMillisecondsSinceEpoch(dateShowned))
              .inDays >=
          3) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  static showConfirmBottomSheet({
    String title = 'Delete',
    String message = 'Are you sure you want to delete?',
    required Function onDeletePress,
    Function? onCancelPress,
    required Rx<API_STATUS> isLoading,
    String deleteButtonText = 'Delete',
    String cancelButtonText = 'Cancel',
    bool cancelButtonIsLoading = false,
  }) {
    BuildContext context = Get.context!;
    Get.bottomSheet(
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(14),
        ),
      ),
      backgroundColor: CustomColors.appBarColor,
      isScrollControlled: true,
      Obx(
        () => Container(
          height: 250,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              Row(
                children: [
                  BaseButton(
                    onPressed: () {
                      onDeletePress();
                    },
                    text: deleteButtonText,
                    isLoading: isLoading.value == API_STATUS.LOADING,
                    width: MediaQuery.of(context).size.width / 2 - 24,
                  ),
                  OutlineButton(
                    onPressed: () {
                      Get.back();
                      if (onCancelPress != null) {
                        onCancelPress!();
                      }
                    },
                    isLoading: cancelButtonIsLoading,
                    text: cancelButtonText,
                    width: MediaQuery.of(context).size.width / 2 - 24,
                    padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static List months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  static setIsScheduledMatchNotification() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('match_scheduled', true);
  }

  static Future<bool> getIsScheduledMatchNotification() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('match_scheduled')) {
      return preferences.getBool('match_scheduled')!;
    } else {
      return false;
    }
  }

  static void addFireBaseToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (!preferences.containsKey('fcmToken')) {
      await preferences.setString('fcmToken', token);
    }
  }

  static Future<String?> getFireBaseToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('fcmToken');
  }
}
