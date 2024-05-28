import 'dart:convert';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:score_keeper/screens/home/view/homeView.dart';
import 'package:score_keeper/screens/introScreens/view/introScreenView.dart';
import 'package:score_keeper/screens/matchDetails/view/matchDetailsView.dart';
import 'package:score_keeper/screens/noConnection/views/noConnectionView.dart';
import 'package:score_keeper/screens/publicMatchDetails/views/publicMatchDetailsView.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    String? payload;

    if (args != null) {
      payload = args[0];
    }
    Future.delayed(const Duration(seconds: 1), () async {
      final bool isConnected = await InternetConnectionChecker().hasConnection;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final PendingDynamicLinkData? initialLink =
          await FirebaseDynamicLinks.instance.getInitialLink();
      if (initialLink != null) {
        final Uri uri = initialLink.link;

        if (uri.queryParameters.isNotEmpty) {
          if (uri.queryParameters.containsKey('matchId')) {
            Map<String, String> data = {
              'matchId': uri.queryParameters['matchId']!,
              'isOpenedLink': 'true',
            };
            Get.offAllNamed(PublicMatchDetailsView.routeName, parameters: data);
          }
        }
      } else if (!isConnected) {
        FlutterNativeSplash.remove();
        Get.offAllNamed(NoConnectionView.routeName);
      } else {
        if (preferences.containsKey("accessToken")) {
          Get.offAllNamed(HomeView.routeName,
              parameters: getParameters(payload));
        } else {
          Get.offAllNamed(IntroScreenView.routeName);
        }
      }
    });
  }

  Map<String, String> getParameters(String? payload) {
    Map<String, String> data = {};
    if (payload != null) {
      Map<String, dynamic> payloadDecoded = jsonDecode(payload);
      if (payloadDecoded.containsKey('screen')) {
        if (payloadDecoded['screen'] == 'Players') {
          data['tab'] = '2';
        }

        if (payloadDecoded['screen'] == 'Matches') {
          data['tab'] = '1';
        }
      }
    }
    return data;
  }
}
