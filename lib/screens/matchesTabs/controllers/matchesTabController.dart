import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:intl/intl.dart';
import 'package:score_keeper/di/services/match/matchService.dart';
import 'package:score_keeper/di/services/teams/teamService.dart';
import 'package:score_keeper/models/matchStatusEnum.dart';
import 'package:score_keeper/screens/addMatch/view/addMatchView.dart';
import 'package:score_keeper/screens/home/controllers/homeController.dart';
import 'package:score_keeper/screens/matchDetails/models/scoreTypeModel.dart';
import 'package:score_keeper/screens/matchesTabs/models/matchListModel.dart';
import 'package:score_keeper/screens/matchesTabs/models/matchModel.dart';
import 'package:score_keeper/screens/teamList/controllers/teamListController.dart';
import 'package:score_keeper/utils/firebaseMessagingUtils.dart';
import 'package:score_keeper/utils/utils.dart';

class MatchesTabController extends GetxController {
  var STATUS = API_STATUS.IDLE.obs;
  MatchService matchService = Get.find();
  TeamService teamService = Get.find();
  final matches = Rxn<MatchListModel>();
  final notStartedMatches = Rxn<List<MatchModel>>();
  final inProgressMatches = Rxn<List<MatchModel>>();
  final completedMatches = Rxn<List<MatchModel>>();
  final scoreTypes = Rx<List<ScoreTypeModel>>([]);
  int teamId = -1;
  InAppReview inAppReview = InAppReview.instance;
  final DELETE_STATUS = API_STATUS.IDLE.obs;

  @override
  void onInit() {
    Map<String, String?> data = Get.parameters;
    if (data != null && data['teamId'] != null) {
      teamId = int.parse(Get.parameters['teamId'] as String);
    }
    super.onInit();
  }

  @override
  void onReady() {
    getMatches();
    getAllScoreTypes();
    super.onReady();
  }

  @override
  void onClose() {
    STATUS.value = API_STATUS.IDLE;
    matches.value = null;
    notStartedMatches.value = null;
    inProgressMatches.value = null;
    completedMatches.value = null;
    super.onClose();
  }

  Future<bool> getMatches({bool isRefresh = false}) async {
    if (teamId == -1) {
      return getAllMatches(isSilent: isRefresh);
    } else {
      return getTeamMatches(isRefresh: isRefresh);
    }
  }

  // void showReviewDialog() async {
  //   bool showPopUp = await Utils.showPopUp();
  //   bool isReviewAvailable = await inAppReview.isAvailable();
  //   if (matches.value!.data.toList().length >= 3 && showPopUp && isReviewAvailable) {
  //     inAppReview.requestReview();
  //   }
  //   if (isReviewAvailable) {
  //     inAppReview.requestReview();
  //   } else {
  //   }
  // }

  void getAllScoreTypes() async {
    final response = await matchService.getScoreType();

    if (response.isSuccessful) {
      List<ScoreTypeModel> list = [];
      list.addAll(response.body!.scoreTypes);
      scoreTypes.value = list;
    }
  }

  Future<bool> getTeamMatches({bool isRefresh = false}) async {
    if (!isRefresh) {
      STATUS.value = API_STATUS.LOADING;
    }

    final response = await teamService.getTeamMatches(teamId);

    if (response.isSuccessful) {
      matches.value = response.body;

      List<MatchModel> allMatches = matches.value!.data.toList();

      notStartedMatches.value = allMatches
          .where((element) => element.status == MatchStatusEnum.NOT_STARTED)
          .toList();
      inProgressMatches.value = allMatches
          .where((element) => element.status == MatchStatusEnum.IN_PROGRESS)
          .toList();
      completedMatches.value = allMatches
          .where((element) => element.status == MatchStatusEnum.COMPLETED)
          .toList();
      if (!isRefresh) {
        STATUS.value = API_STATUS.SUCCESS;
      }

      return true;
    } else {
      if (!isRefresh) {
        STATUS.value = API_STATUS.ERROR;
      }
      return true;
    }
  }

  Future<bool> getAllMatches({bool isSilent = false}) async {
    if (!isSilent) {
      STATUS.value = API_STATUS.LOADING;
    }

    final response = await matchService.getMatches();

    if (response.isSuccessful) {
      matches.value = response.body;

      if (matches.value!.data.isNotEmpty && matches.value!.data.length == 1) {
        FirebaseMessagingUtils.cancelMatchScheduleNotification();
      }

      List<MatchModel> allMatches = matches.value!.data.toList();

      List<MatchModel> notStared = allMatches
          .where((element) => element.status == MatchStatusEnum.NOT_STARTED)
          .toList();
      List<MatchModel> inProgress = allMatches
          .where((element) => element.status == MatchStatusEnum.IN_PROGRESS)
          .toList();
      List<MatchModel> completed = allMatches
          .where((element) => element.status == MatchStatusEnum.COMPLETED)
          .toList();

      notStared.sort((a, b) {
        return DateFormat('EEE, dd MMM, yyyy').parse(a.date).compareTo(DateFormat('EEE, dd MMM, yyyy').parse(b.date));
      });

      inProgress.sort((a, b) {
        return DateFormat('EEE, dd MMM, yyyy').parse(a.date).compareTo(DateFormat('EEE, dd MMM, yyyy').parse(b.date));
      });

      completed.sort((a, b) {
        return DateFormat('EEE, dd MMM, yyyy').parse(b.date).compareTo(DateFormat('EEE, dd MMM, yyyy').parse(a.date));
      });

      notStartedMatches.value = notStared;
      inProgressMatches.value = inProgress;
      completedMatches.value = completed;

      if (!isSilent) {
        STATUS.value = API_STATUS.SUCCESS;
      }
      return true;
      // showReviewDialog();
    } else {
      if (isSilent) {
        STATUS.value = API_STATUS.ERROR;
      }
      return true;
    }
  }

  void updateMatchInList(MatchModel matchModel) {
    int position = -1;
    List<MatchModel> tempInProgress = [];

    List<MatchModel> filtered = inProgressMatches.value!
        .where((element) => element.matchId == matchModel.matchId)
        .toList();

    if (filtered.isNotEmpty) {
      tempInProgress.addAll(inProgressMatches.value!);
      for (int i = 0; i < tempInProgress.length; i++) {
        if (tempInProgress.elementAt(i).matchId == matchModel.matchId) {
          position = i;
        }
      }

      if (position != -1) {
        tempInProgress[position] = matchModel;
        inProgressMatches.value = tempInProgress;
      }
    } else {
      tempInProgress.addAll(completedMatches.value!);
      for (int i = 0; i < tempInProgress.length; i++) {
        if (tempInProgress.elementAt(i).matchId == matchModel.matchId) {
          position = i;
        }
      }

      if (position != -1) {
        tempInProgress[position] = matchModel;
        completedMatches.value = tempInProgress;
      }
    }
  }

  void navigateToTeamTab() {
    if (Get.isRegistered<HomeController>()) {
      HomeController homeController = Get.find();
      homeController.onTabPress(0);
    }
  }

  void onAddMatchPress(BuildContext context) {
    TeamListController teamListController = Get.find();
    if (teamListController.STATUS.value == API_STATUS.SUCCESS &&
        teamListController.teamListModel.value!.data.toList().isNotEmpty) {
      Get.toNamed(AddMatchView.routeName);
    } else {
      Utils.showErrorBottomSheet(
        title: '',
        message:
            'Please Add Your Team First! Go to Teams tab and click (+) icon.',
        onOkayPress: navigateToTeamTab,
      );
    }
  }

  void deleteMatch(int matchId) async {
    // Get.back();
    //
    // Get.dialog(
    //   Dialog(
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    //     child: Container(
    //       padding: const EdgeInsets.symmetric(horizontal: 24),
    //       height: 64,
    //       decoration: BoxDecoration(
    //         color: CustomColors.appBarColor,
    //         borderRadius: BorderRadius.circular(16),
    //       ),
    //       child: const Row(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           SizedBox(
    //             height: 18,
    //             width: 18,
    //             child: CircularProgressIndicator(
    //               color: CustomColors.primaryColor,
    //               strokeWidth: 1,
    //             ),
    //           ),
    //           SizedBox(
    //             width: 24,
    //           ),
    //           Text(
    //             'Deleting match...',
    //             style: TextStyle(
    //               fontSize: 14,
    //               fontWeight: FontWeight.w500,
    //               color: Colors.white,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    DELETE_STATUS.value = API_STATUS.LOADING;
    final response = await matchService.deleteMatch(matchId);

    if (response.isSuccessful) {
      DELETE_STATUS.value = API_STATUS.SUCCESS;
      Get.back();
      if (teamId == -1) {
        getAllMatches();
      } else {
        getTeamMatches();
      }
    } else {
      Get.back();
      var error = response.error as Map<String, dynamic>;
      DELETE_STATUS.value = API_STATUS.ERROR;
      Utils.showErrorBottomSheet(message: error['message']);
    }
  }

  void onEditClick(MatchModel matchModel) {
    Map<String, String> data = {
      'matchId': matchModel.matchId.toString(),
      'secondaryTeamName': matchModel.secondaryTeamName,
      'date': matchModel.date,
      'primaryTeamId': matchModel.primaryTeamId.toString(),
    };

    if (matchModel.secondaryTeamLogo != null) {
      data['secondaryTeamLogo'] = matchModel.secondaryTeamLogo!;
    }

    if (matchModel.location != null) {
      data['location'] = matchModel.location!;
    }

    if (matchModel.league != null) {
      data['league'] = matchModel.league!;
    }

    if (matchModel.isPublic == 1) {
      data['isPublic'] = '${matchModel.isPublic}';
    }

    if (matchModel.kickOffTime != null) {
      data['kickOffTime'] = matchModel.kickOffTime!;
    }
    Get.toNamed(AddMatchView.routeName, parameters: data);
  }
}
