import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:score_keeper/components/buttons/customFloatingActionButton.dart';
import 'package:score_keeper/components/loadingScreen/loadingScreen.dart';
import 'package:score_keeper/components/noDataScreen/noDataScreen.dart';
import 'package:score_keeper/screens/addMatch/view/addMatchView.dart';
import 'package:score_keeper/screens/matchesTabs/components/matchesListView.dart';
import 'package:score_keeper/screens/teamMatches/controllers/teamMatchesController.dart';
import 'package:score_keeper/utils/utils.dart';

class TeamMatchesView extends StatefulWidget {
  static String routeName = '/teamMatches';

  const TeamMatchesView({Key? key}) : super(key: key);

  @override
  State<TeamMatchesView> createState() => _TeamMatchesViewState();
}

class _TeamMatchesViewState extends State<TeamMatchesView>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  TeamMatchesController teamMatchesController = Get.find();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  void onAddMatchPress() {
    Get.toNamed(AddMatchView.routeName,
        parameters: {'teamId': teamMatchesController.teamId.toString()});
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => teamMatchesController.STATUS.value == API_STATUS.SUCCESS
          ? Stack(
              children: [
                DefaultTabController(
                  length: 3,
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text(teamMatchesController.headerTitle.value),
                      bottom: const TabBar(
                        tabs: [
                          Tab(
                            child: Text('Upcoming'),
                          ),
                          Tab(
                            child: Text('Live'),
                          ),
                          Tab(
                            child: Text('Completed'),
                          ),
                        ],
                      ),
                    ),
                    body: TabBarView(
                      children: [
                        MatchesListView(
                          matches:
                              teamMatchesController.notStartedMatches.value,
                          fromScreen: FROM_SCREEN.TEAM_LIST,
                        ),
                        MatchesListView(
                          matches:
                              teamMatchesController.inProgressMatches.value,
                          fromScreen: FROM_SCREEN.TEAM_LIST,
                        ),
                        MatchesListView(
                          matches: teamMatchesController.completedMatches.value,
                          fromScreen: FROM_SCREEN.TEAM_LIST,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: CustomFloatingActionButton(onPress: onAddMatchPress),
                )
              ],
            )
          : const LoadingScreen(),
    );
    // return Obx(
    //   () => matchesTabController.STATUS.value == API_STATUS.SUCCESS
    //       ? Stack(
    //           children: [
    //             matchesTabController.matches.value!.data.isNotEmpty
    //                 ? DefaultTabController(
    //                     length: 3,
    //                     child: Column(
    //                       mainAxisSize: MainAxisSize.max,
    //                       children: [
    //                         Material(
    //                           color: CustomColors.appBarColor,
    //                           child: const TabBar(
    //                             tabs: [
    //                               Tab(
    //                                 child: Text('In Progress'),
    //                               ),
    //                               Tab(
    //                                 child: Text('Not Started'),
    //                               ),
    //                               Tab(
    //                                 child: Text('Completed'),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                         Expanded(
    //                           child: TabBarView(
    //                             children: [
    //                               MatchesListView(
    //                                 matches: matchesTabController
    //                                     .inProgressMatches.value,
    //                               ),
    //                               MatchesListView(
    //                                 matches: matchesTabController
    //                                     .notStartedMatches.value,
    //                               ),
    //                               MatchesListView(
    //                                 matches: matchesTabController
    //                                     .completedMatches.value,
    //                               ),
    //                             ],
    //                           ),
    //                         )
    //                       ],
    //                     ),
    //                   )
    //                 : NoDataScreen(
    //                     title: 'Add Matches',
    //                     message:
    //                         'Please add matches. click on below the add match button'),
    //             Positioned(
    //               bottom: 16,
    //               right: 16,
    //               child: CustomFloatingActionButton(onPress: onAddMatchPress),
    //             )
    //           ],
    //         )
    //       : const LoadingScreen(),
    // );
  }
}
