import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:score_keeper/components/buttons/baseButton.dart';
import 'package:score_keeper/components/commonComponents/matchesListItem.dart';
import 'package:score_keeper/components/custom/liveMatchNotification.dart';
import 'package:score_keeper/components/loadingScreen/loadingScreen.dart';
import 'package:score_keeper/models/notificationMatchModel.dart';
import 'package:score_keeper/screens/matchDetails/controllers/matchDetailsController.dart';
import 'package:score_keeper/screens/shareDetails/controllers/shareDetailsController.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/utils.dart';
import 'package:screenshot/screenshot.dart';

class ShareDetailsView extends StatelessWidget {
  static String routeName = '/shareDetails';
  ShareDetailsController shareDetailsController = Get.find();

  ShareDetailsView({Key? key}) : super(key: key);

  void onBackPress() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => shareDetailsController.STATUS.value == API_STATUS.SUCCESS
          ? Screenshot(
              controller: shareDetailsController.screenshotController,
              child: Scaffold(
                backgroundColor: CustomColors.background,
                body: SafeArea(
                  top: false,
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/match_details_background.png'),
                              fit: BoxFit.fitWidth,
                              alignment: AlignmentDirectional.topStart),
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 32,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: onBackPress,
                                icon: const Icon(
                                  Icons.arrow_back,
                                  size: 24,
                                  color: Colors.white,
                                ),
                              ),
                              Container(),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                                child: Container(
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          MatchesListItem(
                            matchModel:
                                shareDetailsController.matchModel.value!,
                            fromScreen: FROM_SCREEN.SHARE_DETAILS,
                            elapsedTime:
                                shareDetailsController.timeElapsed.value,
                            onPause: () {},
                            onResume: () {},
                            isLoading: false,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                          ),
                          shareDetailsController.userTeamGoals.isNotEmpty ||
                                  shareDetailsController
                                      .opponentTeamGoal.isNotEmpty
                              ? getSummaryView()
                              : Container(),
                          Expanded(
                            child: Center(
                              child: Image.asset(
                                'assets/images/app_icon.png',
                                height: 172,
                                width: 250,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          getBottomView(context),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          : const LoadingScreen(),
    );
  }

  Widget getBottomView(BuildContext context) {
    if (shareDetailsController.showShareButton.value) {
      // if (Platform.isIOS) {
      return Container(
        color: CustomColors.appBarColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: shareDetailsController.matchModel.value!.isPublic == 1
                ? [
                    BaseButton(
                      width: MediaQuery.of(context).size.width / 2 - 32,
                      onPressed: () => shareDetailsController.shareDetails(
                          onlyPicture: true),
                      text: 'Share Score',
                    ),
                    BaseButton(
                      width: MediaQuery.of(context).size.width / 2 - 32,
                      onPressed: () =>
                          shareDetailsController.shareDetails(onlyLink: true),
                      text: 'Share Link',
                    ),
                  ]
                : [
                    BaseButton(
                      width: MediaQuery.of(context).size.width - 32,
                      onPressed: () => shareDetailsController.shareDetails(
                          onlyPicture: true),
                      text: 'Share Score',
                    ),
                  ],
          ),
        ),
      );
      // } else {
      //   return Container(
      //     color: CustomColors.appBarColor,
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(
      //           vertical: 12, horizontal: 16),
      //       child: BaseButton(
      //         onPressed: shareDetailsController
      //             .shareDetails,
      //         text: 'Share',
      //       ),
      //     ),
      //   );
      // }
    } else {
      return Container();
    }
  }

  Widget getSummaryView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: CustomColors.appBarColor),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getUserGoalsView(),
            getOpponentView(),
          ],
        ),
      ),
    );
  }

  Widget getUserGoalsView() {
    List<Widget> list = [];

    shareDetailsController.userTeamGoals.entries.forEach((element) {
      String mins = '';
      element.value.forEach((element) {
        mins = mins + "${element}\' ";
      });

      mins = mins.substring(0, mins.length - 1);

      list.add(
        Container(
          padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '${element.key} ${mins}',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                width: 32,
              ),
            ],
          ),
        ),
      );
    });

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: list,
      ),
    );
  }

  Widget getOpponentView() {
    List<Widget> list = [];

    int count = 0;
    shareDetailsController.opponentTeamGoal.entries.forEach((element) {
      String mins = '';
      element.value.forEach((element) {
        mins = mins + "${element}\' ";
      });

      mins = mins.substring(0, mins.length - 1);

      list.add(
        Container(
          padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 1,
                height: 16,
                color: CustomColors.inputBorderColor,
              ),
              const SizedBox(
                width: 32,
              ),
              Expanded(
                child: Text(
                  '${element.key} ${mins}',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      );

      count++;
    });

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: list,
      ),
    );
  }

// Widget getSummaryView() {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 16),
//     child: Container(
//       padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8.0),
//           color: CustomColors.appBarColor),
//       child: Column(
//         children: getSummaryRows(),
//       ),
//     ),
//   );
// }
//
// List<Widget> getSummaryRows() {
//   List<Widget> list = [];
//
//   int count = 0;
//   shareDetailsController.userTeamGoals.entries.forEach((element) {
//     String mins = '';
//     String oppMins = '';
//     element.value.forEach((element) {
//       mins = mins + "${element}\' ";
//     });
//     MapEntry<String, List<int>>? entry = shareDetailsController
//         .opponentTeamGoal.entries
//         .elementAtOrNull(count);
//
//     if (entry != null) {
//       entry.value.forEach((element) {
//         oppMins = oppMins + "${element}\' ";
//       });
//     }
//     mins = mins.substring(0, mins.length - 1);
//     if (oppMins.isNotEmpty) {
//       oppMins = oppMins.substring(0, oppMins.length - 1);
//     }
//     list.add(
//       Container(
//         padding: EdgeInsets.fromLTRB(0, 18, 0, 0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Text(
//                 '${element.key} ${mins}',
//                 style: const TextStyle(
//                     fontSize: 12, fontWeight: FontWeight.w600),
//               ),
//             ),
//             entry != null
//                 ? Container(
//                     width: 1,
//                     height: 16,
//                     color: CustomColors.inputBorderColor,
//                   )
//                 : Container(),
//             entry != null
//                 ? Expanded(
//                     child: Padding(
//                     padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
//                     child: Text(
//                       '${entry.key} ${oppMins}',
//                       style: const TextStyle(
//                           fontSize: 12, fontWeight: FontWeight.w600),
//                     ),
//                   ))
//                 : Container(),
//           ],
//         ),
//       ),
//     );
//     count += 1;
//   });
//
//   return list;
// }
}
