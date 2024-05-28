import 'dart:async';
import 'dart:convert';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:score_keeper/di/serializers/serializers.dart';
import 'package:score_keeper/di/services/match/matchService.dart';
import 'package:score_keeper/models/matchStatusEnum.dart';
import 'package:score_keeper/screens/enterEmail/view/enterEmailView.dart';
import 'package:score_keeper/screens/home/view/homeView.dart';
import 'package:score_keeper/screens/matchDetails/models/goalModel.dart';
import 'package:score_keeper/screens/matchesTabs/controllers/matchesTabController.dart';
import 'package:score_keeper/screens/matchesTabs/models/matchModel.dart';
import 'package:score_keeper/screens/playerList/models/playerModels/player.dart';
import 'package:score_keeper/screens/shareDetails/views/shareDetailsView.dart';
import 'package:score_keeper/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PublicMatchDetailsController extends GetxController {
  final lineUpPlayers = Rx<List<Player>>([]);
  final substitutePlayers = Rx<List<Player>>([]);
  RxInt timeElapsed = 0.obs;
  Timer? timer;
  final STATUS = API_STATUS.IDLE.obs;
  MatchService matchService = Get.find();
  final goals = Rx<List<GoalModel>>([]);
  final matchModel = Rxn<MatchModel>();
  int matchId = 0;
  final matchStatus = MatchStatusEnum.NOT_STARTED.obs;
  final allPlayers = Rx<List<Player>>([]);
  FROM_SCREEN fromScreen = FROM_SCREEN.MATCH_LIST;
  final isRefreshMatches = false.obs;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    Map<String, String?> data = Get.parameters;
    matchId = int.parse(data['matchId'] as String);
    if (data.containsKey('isOpenedLink') && data['isOpenedLink'] == 'true') {
      fromScreen = FROM_SCREEN.LINK;
    }
    if (data.containsKey('refreshMatches') &&
        data['refreshMatches'] == 'true') {
      isRefreshMatches.value = true;
    }
    getMatchPlayers();
    addMatchIdToPreferences();
    super.onReady();
  }

  void getMatchPlayers({bool isSilent = false}) async {
    if (!isSilent) {
      STATUS.value = API_STATUS.LOADING;
    }

    final matchSummaryResponse = await matchService.getMatchSummery(matchId);

    if (matchSummaryResponse.isSuccessful) {
      matchModel.value = matchSummaryResponse.body!;
      MatchModel resMatchModel = matchSummaryResponse.body!;
      goals.value = resMatchModel.goals.toList();

      // final response =
      // await matchService.getMatchPlayers(matchModel.value!.matchId);

      timeElapsed.value = getElapsedTime();
      matchStatus.value = resMatchModel.progress!;

      if (resMatchModel.progress! == MatchStatusEnum.STARTED ||
          resMatchModel.progress! == MatchStatusEnum.RESUME) {
        startTimer();
      } else if (resMatchModel.progress! == MatchStatusEnum.PAUSED ||
          resMatchModel.progress! == MatchStatusEnum.COMPLETED) {
        stopTimer();
      }

      substitutePlayers.value = [];
      lineUpPlayers.value = [];
      if (isSilent == false) {
        STATUS.value = API_STATUS.SUCCESS;
      }
    } else {
      if (!isSilent) {
        STATUS.value = API_STATUS.ERROR;
        var error = matchSummaryResponse.error as Map<String, dynamic>;
        Utils.showErrorBottomSheet(
            message: error['message'],
            onOkayPress: () {
              Get.back();
            });
      }
    }
  }

  void startTimer() {
    if (timeElapsed.value < Utils.MAX_ELAPSED_TIME && timer == null) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        timeElapsed.value = timeElapsed.value + 1;
        if (timeElapsed.value == Utils.MAX_ELAPSED_TIME) {
          timer.cancel();
        }
      });
    } else if (timer != null && !timer!.isActive) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        timeElapsed.value = timeElapsed.value + 1;
        if (timeElapsed.value == Utils.MAX_ELAPSED_TIME) {
          timer.cancel();
        }
      });
    }
  }

  void stopTimer() {
    if (timer != null) {
      timer!.cancel();
    }
  }

  int getElapsedTime() {
    if (matchModel.value!.progress == MatchStatusEnum.STARTED ||
        matchModel.value!.progress == MatchStatusEnum.RESUME) {
      int diff = DateTime.now()
          .difference(
              DateTime.fromMillisecondsSinceEpoch(matchModel.value!.timer!))
          .inSeconds;
      if (diff >= Utils.MAX_ELAPSED_TIME) {
        return Utils.MAX_ELAPSED_TIME;
      } else {
        return diff;
      }
    } else if (matchModel.value!.progress == MatchStatusEnum.PAUSED ||
        matchModel.value!.progress == MatchStatusEnum.COMPLETED) {
      int elapsed = (matchModel.value!.timer! / 1000).round();
      if (elapsed >= Utils.MAX_ELAPSED_TIME) {
        return Utils.MAX_ELAPSED_TIME;
      } else {
        return elapsed;
      }
    } else {
      return 0;
    }
  }

  void shareDetails() {
    Get.toNamed(
      ShareDetailsView.routeName,
      arguments: [
        json.encode(
          serializers.serializeWith(
            MatchModel.serializer,
            matchModel.value,
          ),
        ),
      ],
    );
  }

  void addMatchIdToPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accessToken = preferences.getString("accessToken");

    if (accessToken == null) {
      if (preferences.containsKey('matchIds')) {
        List<String> list = preferences.getStringList('matchIds')!;
        bool isContain = list.any((element) => element == matchId.toString());
        if (!isContain) {
          list.add(matchId.toString());
          preferences.setStringList('matchIds', list);
        }
      } else {
        List<String> list = [];
        list.add(matchId.toString());
        preferences.setStringList('matchIds', list);
      }
    }
  }

  Future<bool> onBackPress() async {
    if (isRefreshMatches.value && Get.isRegistered<MatchesTabController>()) {
      final matchesTabController = Get.find<MatchesTabController>();
      matchesTabController.getMatches();
    }
    if (fromScreen == FROM_SCREEN.LINK) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? accessToken = preferences.getString("accessToken");

      if (accessToken == null) {
        Get.offNamed(EnterEmailView.routeName);
      } else {
        Get.offNamed(HomeView.routeName);
      }
    } else {
      Get.back();
    }

    return true;
  }
}
