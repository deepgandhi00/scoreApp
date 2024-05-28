import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:score_keeper/components/buttons/customFloatingActionButton.dart';
import 'package:score_keeper/components/loadingScreen/loadingScreen.dart';
import 'package:score_keeper/components/noDataScreen/noDataScreen.dart';
import 'package:score_keeper/screens/addMatch/view/addMatchView.dart';
import 'package:score_keeper/screens/matchesTabs/components/matchesListView.dart';
import 'package:score_keeper/screens/matchesTabs/controllers/matchesTabController.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/utils.dart';

class MatchesTabView extends StatefulWidget {
  static String routeName = '/matchesTab';

  const MatchesTabView({Key? key}) : super(key: key);

  @override
  State<MatchesTabView> createState() => _MatchesTabViewState();
}

class _MatchesTabViewState extends State<MatchesTabView>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  MatchesTabController matchesTabController = Get.find<MatchesTabController>();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => matchesTabController.STATUS.value == API_STATUS.SUCCESS
          ? Stack(
              children: [
                matchesTabController.matches.value!.data.isNotEmpty
                    ? DefaultTabController(
                        length: 3,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Material(
                              color: CustomColors.appBarColor,
                              child: const TabBar(
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
                            Expanded(
                              child: TabBarView(
                                children: [
                                  Obx(
                                    () => MatchesListView(
                                      matches: matchesTabController
                                          .notStartedMatches.value,
                                    ),
                                  ),
                                  Obx(
                                    () => MatchesListView(
                                      matches: matchesTabController
                                          .inProgressMatches.value,
                                    ),
                                  ),
                                  Obx(
                                    () => MatchesListView(
                                      matches: matchesTabController
                                          .completedMatches.value,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    : NoDataScreen(
                        title: 'Add Matches',
                        message:
                            'Please add matches by clicking on the button below'),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: CustomFloatingActionButton(
                      onPress: () =>
                          matchesTabController.onAddMatchPress(context)),
                )
              ],
            )
          : const LoadingScreen(),
    );
  }
}
