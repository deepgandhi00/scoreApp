import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:score_keeper/components/commonComponents/matchesListItem.dart';
import 'package:score_keeper/components/noDataScreen/noDataScreen.dart';
import 'package:score_keeper/screens/matchesTabs/controllers/matchesTabController.dart';
import 'package:score_keeper/screens/matchesTabs/models/matchModel.dart';
import 'package:score_keeper/utils/utils.dart';

class MatchesListView extends StatelessWidget {
  final List<MatchModel>? matches;
  final List<MatchModel>? publicMatches;
  FROM_SCREEN fromScreen;
  MatchesTabController matchesTabController = Get.find();

  MatchesListView({
    Key? key,
    required this.matches,
    this.publicMatches,
    this.fromScreen = FROM_SCREEN.MATCH_LIST,
  }) : super(key: key);

  void onDeletePress(int matchId, BuildContext context) {
    Utils.showConfirmBottomSheet(
      onDeletePress: () => matchesTabController.deleteMatch(matchId),
      isLoading: matchesTabController.DELETE_STATUS,
      title: '',
      message: 'Are you sure you want to delete match?',
      deleteButtonText: 'Delete',
    );
  }

  @override
  Widget build(BuildContext context) {
    return matches!.isNotEmpty
        ? RefreshIndicator(
            onRefresh: () => matchesTabController.getMatches(isRefresh: true),
            child: ListView.builder(
              itemCount: matches!.length,
              itemBuilder: (BuildContext context, int index) {
                return MatchesListItem(
                  matchModel: matches!.elementAt(index),
                  fromScreen: fromScreen,
                  onEditPress: matchesTabController.onEditClick,
                  onDeletePress: (int matchId) =>
                      onDeletePress(matchId, context),
                );
              },
            ),
          )
        : NoDataScreen(
            title: 'Add Match',
            message: 'Please add matches by clicking on the button below',
            showPointer: true,
          );
  }
}
