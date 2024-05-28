import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:score_keeper/components/buttons/baseButton.dart';
import 'package:score_keeper/components/buttons/outlineButton.dart';
import 'package:score_keeper/components/commonComponents/matchesListItem.dart';
import 'package:score_keeper/components/custom/playerListWithTitle.dart';
import 'package:score_keeper/components/loadingScreen/loadingScreen.dart';
import 'package:score_keeper/components/noDataScreen/noDataScreen.dart';
import 'package:score_keeper/models/matchStatusEnum.dart';
import 'package:score_keeper/screens/matchDetails/compoonents/addGoalDialog.dart';
import 'package:score_keeper/screens/matchDetails/compoonents/summaryItemView.dart';
import 'package:score_keeper/screens/matchDetails/controllers/matchDetailsController.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/utils.dart';
import '../compoonents/addGoalBottomSheet.dart';
import 'package:screenshot/screenshot.dart';

class MatchDetailsView extends StatefulWidget {
  static String routeName = '/matchDetails';

  @override
  State<MatchDetailsView> createState() => _MatchDetailsViewState();
}

class _MatchDetailsViewState extends State<MatchDetailsView>
    with WidgetsBindingObserver {
  final double TAB_BAR_HEIGHT = 56;

  MatchDetailsController matchDetailsController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      matchDetailsController.onResumeCallBack();
    }

    if (state == AppLifecycleState.paused) {
      matchDetailsController.onPauseCallBack();
    }
  }

  void onStartMatchPress() {
    matchDetailsController.startMatch();
  }

  void closeBottomSheet() {
    Get.back();
  }

  void showAddGoalDialog(bool isAddGoal, bool isEdit) {
    if (matchDetailsController.isSecondaryTeam.value && !isEdit) {
      matchDetailsController.addGoal();
    } else {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (isAddGoal) {
          closeBottomSheet();
        }
        matchDetailsController.mintController.text =
            '${(matchDetailsController.timeElapsed.value / 60).floor()}';
        Get.bottomSheet(
          isDismissible: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(14),
            ),
          ),
          backgroundColor: CustomColors.appBarColor,
          isScrollControlled: true,
          Obx(
            () => AddGoalDialog(
              closeBottomSheet: closeBottomSheet,
              players: matchDetailsController.allPlayers.value,
              setPlayerId: matchDetailsController.setSelectedPlayer,
              currentPlayerId: matchDetailsController.playerId.value,
              mintController: matchDetailsController.mintController,
              matchModel: matchDetailsController.matchModel.value!,
              assistPlayerId: matchDetailsController.assistedPlayer.value,
              isEdit: matchDetailsController.currentEditGoalId.value != null
                  ? true
                  : false,
              isSecondaryTeam: matchDetailsController.isSecondaryTeam,
              onPressAddGoal: matchDetailsController.addGoal,
              onPressDeleteGoal: matchDetailsController.onDeleteGoal,
              onPressEditGoal: matchDetailsController.editGoal,
              setAssistPlayerId:
                  matchDetailsController.setSelectedAssistedPlayer,
              scoreTypes: matchDetailsController.scoreTypes.value,
              scoreTypeId: matchDetailsController.scoreTypeId.value,
              matchDetailsController: matchDetailsController,
              isLoading: matchDetailsController.GOAL_STATUS.value ==
                  API_STATUS.LOADING,
              isDelete: matchDetailsController.isDelete.value,
              mintError: matchDetailsController.mintError.value,
            ),
          ),
        ).whenComplete(() {
          matchDetailsController.onCloseAddEditBottomSheet();
        });
      });
    }
  }

  void addGoalPress() {
    Get.bottomSheet(
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(14),
        ),
      ),
      backgroundColor: CustomColors.appBarColor,
      isScrollControlled: true,
      Obx(
        () => AddGoalBottomSheet(
          closeBottomSheet: closeBottomSheet,
          radioValue: matchDetailsController.isSecondaryTeam.value,
          setRadioValue: (bool? val) =>
              matchDetailsController.setIsSecondaryTeam(val!),
          matchModel: matchDetailsController.matchModel.value!,
          onOkayPress: () => showAddGoalDialog(true, false),
          isLoading:
              matchDetailsController.GOAL_STATUS.value == API_STATUS.LOADING,
        ),
      ),
    );
  }

  void endMatchPress(BuildContext context) {
    Utils.showConfirmBottomSheet(
      onDeletePress: matchDetailsController.endMatch,
      deleteButtonText: 'Yes',
      cancelButtonText: 'No',
      title: 'Confirm End',
      message:
          'Are you sure you want to end the match? You won’t be able to add new goals.',
      isLoading: matchDetailsController.UPDATE_STATUS,
    );
  }

  TabBar get _tabBar => TabBar(
        dividerColor: CustomColors.inputBorderColor,
        labelPadding: const EdgeInsets.all(0),
        indicatorPadding: const EdgeInsets.all(0),
        tabs: [
          Container(
            height: TAB_BAR_HEIGHT,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
            decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(
                        color: CustomColors.inputBorderColor, width: 2))),
            child: const Tab(text: 'Summary'),
          ),
          Container(
            height: TAB_BAR_HEIGHT,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
            child: const Tab(text: 'Line-Up'),
          ),
        ],
      );

  Widget getBottomView(BuildContext context) {
    if (matchDetailsController.matchStatus.value ==
            MatchStatusEnum.IN_PROGRESS ||
        matchDetailsController.matchStatus.value == MatchStatusEnum.STARTED ||
        matchDetailsController.matchStatus.value == MatchStatusEnum.PAUSED ||
        matchDetailsController.matchStatus.value == MatchStatusEnum.RESUME) {
      return Row(
        children: [
          BaseButton(
            onPressed: addGoalPress,
            text: 'Add Goal',
            width: MediaQuery.of(context).size.width / 2 - 24,
          ),
          OutlineButton(
            onPressed: () => endMatchPress(context),
            text: 'End Match',
            width: MediaQuery.of(context).size.width / 2 - 24,
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          )
        ],
      );
    } else if (matchDetailsController.matchStatus.value ==
        MatchStatusEnum.NOT_STARTED) {
      return BaseButton(
        onPressed: onStartMatchPress,
        isLoading:
            matchDetailsController.UPDATE_STATUS.value == API_STATUS.LOADING,
        text: 'Start Match',
      );
    } else {
      return Container();
    }
  }

  Widget getSummaryTabView(BuildContext context) {
    if (matchDetailsController.goals.value.isNotEmpty) {
      return Obx(
        () => matchDetailsController.goals.value.isNotEmpty
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
                        editGoal: () => showAddGoalDialog(false, true),
                        goalModel:
                            matchDetailsController.goals.value.elementAt(index),
                        matchDetailsController: matchDetailsController,
                        primaryTeamName: matchDetailsController
                            .matchModel.value!.primaryTeamName,
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      itemCount: matchDetailsController.goals.value.length,
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
      () => matchDetailsController.lineUpPlayers.value.isNotEmpty ||
              matchDetailsController.substitutePlayers.value.isNotEmpty
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    PlayerListWithTitle(
                        players: matchDetailsController.lineUpPlayers.value,
                        title: 'Line Up',
                        isLineUp: true,
                        onAddPress: matchDetailsController.addToLineUpPlayers,
                        onRemovePress: matchDetailsController.removeFromLineUp,
                        showDone: true,
                        onDonePress: matchDetailsController.onSavePlayers,
                        showAdd: true,
                        onAddIconPress:
                            matchDetailsController.showAddPlayerBottomSheet),
                    const SizedBox(
                      height: 32,
                    ),
                    PlayerListWithTitle(
                        players: matchDetailsController.substitutePlayers.value,
                        title: 'Substitute',
                        isLineUp: false,
                        onAddPress: matchDetailsController.addToLineUpPlayers,
                        onRemovePress: matchDetailsController.removeFromLineUp,
                        showAdd:
                            matchDetailsController.lineUpPlayers.value.isEmpty
                                ? true
                                : false,
                        onAddIconPress:
                            matchDetailsController.showAddPlayerBottomSheet),
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

  void onBackPress() {
    Get.back();
  }

  Widget getWidget(BuildContext context) {
    return Obx(
      () => matchDetailsController.STATUS.value == API_STATUS.SUCCESS
          ? Screenshot(
              controller: matchDetailsController.screenshotController,
              child: DefaultTabController(
                length: 2,
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
                                    onPressed: onBackPress,
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
                                      onTap:
                                          matchDetailsController.shareDetails,
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
                                matchModel:
                                    matchDetailsController.matchModel.value!,
                                fromScreen: FROM_SCREEN.MATCH_DETAILS,
                                elapsedTime:
                                    matchDetailsController.timeElapsed.value,
                                onPause: matchDetailsController.onMatchPause,
                                onResume: matchDetailsController.onMatchResume,
                                isLoading: matchDetailsController
                                        .UPDATE_STATUS.value ==
                                    API_STATUS.LOADING,
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
                                    getPlayersTabView()
                                  ],
                                ),
                              ),
                              Container(
                                color: CustomColors.appBarColor,
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 16),
                                    child: getBottomView(context)),
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

  @override
  Widget build(BuildContext context) {
    return getWidget(context);
  }
}
