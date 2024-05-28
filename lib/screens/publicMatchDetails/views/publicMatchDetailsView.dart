import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:score_keeper/components/commonComponents/matchesListItem.dart';
import 'package:score_keeper/components/custom/playerListWithTitle.dart';
import 'package:score_keeper/components/loadingScreen/loadingScreen.dart';
import 'package:score_keeper/components/noDataScreen/noDataScreen.dart';
import 'package:score_keeper/screens/matchDetails/compoonents/summaryItemView.dart';
import 'package:score_keeper/screens/publicMatchDetails/controllers/publicMatchDetailsController.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/utils.dart';
import 'package:screenshot/screenshot.dart';

class PublicMatchDetailsView extends StatelessWidget {
  static String routeName = '/publicMatchDetails';

  PublicMatchDetailsView({Key? key}) : super(key: key);

  final double TAB_BAR_HEIGHT = 56;

  PublicMatchDetailsController publicMatchDetailsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => publicMatchDetailsController.STATUS.value == API_STATUS.SUCCESS
          ? WillPopScope(
              onWillPop: publicMatchDetailsController.onBackPress,
              child: DefaultTabController(
                length: 1,
                child: AnnotatedRegion<SystemUiOverlayStyle>(
                  value: const SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                  ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: publicMatchDetailsController
                                        .onBackPress,
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 16, 0),
                                    child: GestureDetector(
                                      onTap: publicMatchDetailsController
                                          .shareDetails,
                                      child: Image.asset(
                                        'assets/images/share.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              MatchesListItem(
                                matchModel: publicMatchDetailsController
                                    .matchModel.value!,
                                fromScreen: FROM_SCREEN.PUBLIC_VIEW,
                                elapsedTime: publicMatchDetailsController
                                    .timeElapsed.value,
                                onPause: () {},
                                onResume: () {},
                                isLoading: false,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: PreferredSize(
                                    preferredSize: _tabBar.preferredSize,
                                    child: Material(
                                      color: CustomColors.appBarColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        side: const BorderSide(
                                            color:
                                                CustomColors.inputBorderColor,
                                            width: 1),
                                      ),
                                      child: _tabBar,
                                    )),
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    getSummaryTabView(context),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          : const LoadingScreen(),
    );
  }

  TabBar get _tabBar => TabBar(
        dividerColor: CustomColors.inputBorderColor,
        labelPadding: const EdgeInsets.all(0),
        indicatorPadding: const EdgeInsets.all(0),
        tabs: publicMatchDetailsController.matchModel.value!.owner == true
            ? [
                Container(
                  height: TAB_BAR_HEIGHT,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                  decoration: const BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              color: CustomColors.inputBorderColor, width: 2))),
                  child: const Tab(text: 'Summary'),
                ),
                Container(
                  height: TAB_BAR_HEIGHT,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                  child: const Tab(text: 'Line-Up'),
                ),
              ]
            : [
                Container(
                  height: TAB_BAR_HEIGHT,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                  decoration: const BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              color: CustomColors.inputBorderColor, width: 2))),
                  child: const Tab(text: 'Summary'),
                ),
              ],
      );

  Widget getSummaryTabView(BuildContext context) {
    if (publicMatchDetailsController.goals.value.isNotEmpty) {
      return Obx(
        () => publicMatchDetailsController.goals.value.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  color: CustomColors.appBarColor,
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) =>
                          SummaryItem(
                        editGoal: () {},
                        goalModel: publicMatchDetailsController.goals.value
                            .elementAt(index),
                        primaryTeamName: publicMatchDetailsController
                            .matchModel.value!.primaryTeamName,
                        fromScreen: FROM_SCREEN.PUBLIC_VIEW,
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      itemCount:
                          publicMatchDetailsController.goals.value.length,
                    ),
                  ),
                ),
              )
            : Container(),
      );
    } else {
      return Container();
    }
  }

  Widget getPlayersTabView() {
    return Obx(
      () => publicMatchDetailsController.lineUpPlayers.value.isNotEmpty ||
              publicMatchDetailsController.substitutePlayers.value.isNotEmpty
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    PlayerListWithTitle(
                      players: publicMatchDetailsController.lineUpPlayers.value,
                      title: 'Line Up',
                      isLineUp: true,
                      onAddPress: (Player) {},
                      onRemovePress: (Player) {},
                      showDone: true,
                      onDonePress: () {},
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    PlayerListWithTitle(
                      players:
                          publicMatchDetailsController.substitutePlayers.value,
                      title: 'Substitute',
                      isLineUp: false,
                      onAddPress: (Player) {},
                      onRemovePress: (Player) {},
                    ),
                  ],
                ),
              ),
            )
          : NoDataScreen(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              title: '',
              message:
                  'You have not added any players to the team, Go to Your Team > Players to add players!'),
    );
  }
}
