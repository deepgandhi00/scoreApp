import 'package:get/get.dart';
import 'package:score_keeper/di/services/match/matchService.dart';
import 'package:score_keeper/di/services/teams/teamService.dart';
import 'package:score_keeper/models/matchStatusEnum.dart';
import 'package:score_keeper/screens/addMatch/view/addMatchView.dart';
import 'package:score_keeper/screens/home/controllers/homeController.dart';
import 'package:score_keeper/screens/matchDetails/models/scoreTypeModel.dart';
import 'package:score_keeper/screens/matchesTabs/models/matchListModel.dart';
import 'package:score_keeper/screens/matchesTabs/models/matchModel.dart';
import 'package:score_keeper/utils/utils.dart';
import 'package:built_collection/built_collection.dart';

class TeamMatchesController extends GetxController {
  var STATUS = API_STATUS.IDLE.obs;
  TeamService teamService = Get.find();
  final matches = Rxn<MatchListModel>();
  final notStartedMatches = Rxn<List<MatchModel>>([]);
  final inProgressMatches = Rxn<List<MatchModel>>([]);
  final completedMatches = Rxn<List<MatchModel>>([]);
  final scoreTypes = Rx<List<ScoreTypeModel>>([]);
  final headerTitle = 'Team Matches'.obs;
  int teamId = -1;
  HomeController homeController = Get.find();

  @override
  void onReady() {
    Map<String, String?> data = Get.parameters;
    if (data != null && data['teamId'] != null) {
      teamId = int.parse(Get.parameters['teamId'] as String);
    }

    if (data != null && data['name'] != null) {
      headerTitle.value = data['name'] as String;
    }

    homeController.updateTeamMatches.stream.listen((event) {
      if (event) {
        getTeamMatches();
      }
    });

    homeController.matchModel.stream.listen((event) {
      if (event != null) {
        updateMatchInList(event!);
      }
    });
    getTeamMatches();
    super.onReady();
  }

  @override
  void onClose() {
    STATUS.value = API_STATUS.IDLE;
    matches.value = null;
    notStartedMatches.value = [];
    inProgressMatches.value = [];
    completedMatches.value = [];
    super.onClose();
  }

  void getTeamMatches() async {
    STATUS.value = API_STATUS.LOADING;

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

      if (allMatches.isEmpty) {
        Get.toNamed(AddMatchView.routeName,
            parameters: {'teamId': teamId.toString()});
      }

      STATUS.value = API_STATUS.SUCCESS;
      homeController.setUpdateTeamMatches(false);
    } else {
      STATUS.value = API_STATUS.ERROR;
      homeController.setUpdateTeamMatches(false);
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

    homeController.setMatchModel(null);
  }
}
