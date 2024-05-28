import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:score_keeper/screens/matchDetails/view/matchDetailsView.dart';
import 'package:score_keeper/screens/publicMatchDetails/views/publicMatchDetailsView.dart';

class FirebaseDynamicLinkUtils {
  static final FirebaseDynamicLinks dynamicLinks =
      FirebaseDynamicLinks.instance;
  static const uriPrefix = 'https://example.page.link';
  static const androidPackage = 'com.example.score';
  static const iosBundleId = 'com.example.score';

  static Future<void> initDynamicLinks() async {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      final Uri uri = dynamicLinkData.link;
      if (uri.queryParameters.isNotEmpty) {
        if (uri.queryParameters.containsKey('matchId')) {
          Map<String, String> data = {
            'matchId': uri.queryParameters['matchId']!,
            'isOpenedLink': 'true',
            'refreshMatches': 'true',
          };
          Get.toNamed(
            PublicMatchDetailsView.routeName,
            parameters: data,
            preventDuplicates: false,
          );
        }
      }
    });
  }

  static Future<ShortDynamicLink> createShortMatchLink(int matchId) async {
    DynamicLinkParameters dynamicLinkParameters = DynamicLinkParameters(
      link: Uri.parse(
          'https://example.page.link/matchDetails?matchId=$matchId'),
      uriPrefix: uriPrefix,
      androidParameters: const AndroidParameters(
        packageName: androidPackage,
      ),
      iosParameters: const IOSParameters(
        bundleId: iosBundleId,
        appStoreId: '6450709996',
        minimumVersion: '11',
      ),
    );

    return dynamicLinks.buildShortLink(dynamicLinkParameters);
  }
}
