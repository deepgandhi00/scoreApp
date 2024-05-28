import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:score_keeper/di/serializers/serializers.dart';
import 'package:score_keeper/models/matchStatusEnum.dart';
import 'package:score_keeper/screens/matchDetails/models/goalModel.dart';
import 'package:score_keeper/screens/matchesTabs/models/matchModel.dart';
import 'package:score_keeper/utils/firebaseDynamicLinkUtils.dart';
import 'package:score_keeper/utils/utils.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ShareDetailsController extends GetxController {
  final STATUS = API_STATUS.IDLE.obs;
  ScreenshotController screenshotController = ScreenshotController();
  Map<String, List<int>> userTeamGoals = {};
  Map<String, List<int>> opponentTeamGoal = {};
  final showShareButton = true.obs;
  final matchModel = Rxn<MatchModel>();
  RxInt timeElapsed = 0.obs;
  Timer? timer;

  @override
  void onReady() {
    String data = Get.arguments[0];
    matchModel.value = serializers.deserializeWith(
      MatchModel.serializer,
      json.decode(
        data,
      ),
    );
    List<GoalModel> goals = matchModel.value!.goals.toList();
    timeElapsed.value = getElapsedTime();

    if (matchModel.value!.progress! == MatchStatusEnum.STARTED ||
        matchModel.value!.progress! == MatchStatusEnum.RESUME) {
      startTimer();
    }

    if (goals.isNotEmpty) {
      goals.forEach((goal) {
        if (goal.isSecondaryTeam == 0) {
          if (goal.playerId != null && goal.playerName != null) {
            if (userTeamGoals.containsKey(goal.playerName!)) {
              userTeamGoals.update(goal.playerName!, (value) {
                List<int> temp = [];
                temp.addAll(value);
                temp.add(goal.mins);
                return temp;
              });
            } else {
              userTeamGoals[goal.playerName!] = [goal.mins];
            }
          } else {
            if (userTeamGoals.containsKey(matchModel.value!.primaryTeamName)) {
              userTeamGoals.update(matchModel.value!.primaryTeamName, (value) {
                List<int> temp = [];
                temp.addAll(value);
                temp.add(goal.mins);
                return temp;
              });
            } else {
              userTeamGoals[matchModel.value!.primaryTeamName] = [goal.mins];
            }
          }
        } else {
          if (opponentTeamGoal.containsKey(goal.secondaryTeamName)) {
            opponentTeamGoal.update(goal.secondaryTeamName, (value) {
              List<int> temp = [];
              temp.addAll(value);
              temp.add(goal.mins);
              return temp;
            });
          } else {
            opponentTeamGoal[goal.secondaryTeamName] = [goal.mins];
          }
        }
      });
    }
    STATUS.value = API_STATUS.SUCCESS;
    super.onReady();
  }

  void startTimer() {
    if (timeElapsed.value < Utils.MAX_ELAPSED_TIME) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        timeElapsed.value = timeElapsed.value + 1;
        if (timeElapsed.value == Utils.MAX_ELAPSED_TIME) {
          timer.cancel();
        }
      });
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

  Future<String?> getText() async {
    if (matchModel.value!.isPublic! == 1) {
      final ShortDynamicLink shortDynamicLink =
          await FirebaseDynamicLinkUtils.createShortMatchLink(
        matchModel.value!.matchId,
      );
      if (matchModel.value!.status == MatchStatusEnum.NOT_STARTED) {
        return 'Upcoming match\n${matchModel.value!.primaryTeamName} Vs ${matchModel.value!.secondaryTeamName}\nTime: ${matchModel.value!.date}, ${matchModel.value!.kickOffTime ?? ''}\n\nOpen: ${shortDynamicLink.shortUrl.toString()}';
      } else if (matchModel.value!.status == MatchStatusEnum.IN_PROGRESS) {
        return 'Match in progress\n${matchModel.value!.primaryTeamName} Vs ${matchModel.value!.secondaryTeamName}\nScore: ${matchModel.value!.primaryTeamName} ${matchModel.value!.primaryTeamGoals} - ${matchModel.value!.secondaryTeamGoals} ${matchModel.value!.secondaryTeamName}\n\nOpen: ${shortDynamicLink.shortUrl.toString()}\n\n';
      } else {
        return 'Match Over\n\n${matchModel.value!.primaryTeamName} Vs ${matchModel.value!.secondaryTeamName}\nFinal Score: ${matchModel.value!.primaryTeamName} ${matchModel.value!.primaryTeamGoals} - ${matchModel.value!.secondaryTeamGoals} ${matchModel.value!.secondaryTeamName}\n\nOpen: ${shortDynamicLink.shortUrl.toString()}';
      }
    } else {
      return null;
    }
  }

  void shareDetails({bool onlyLink = false, bool onlyPicture = false}) {
    showShareButton.value = false;
    Future.delayed(const Duration(milliseconds: 200), () {
      screenshotController
          .capture(delay: const Duration(milliseconds: 10))
          .then((image) async {
        if (image != null) {
          final directory = await getApplicationDocumentsDirectory();
          final imagePath = await File('${directory.path}/image.png').create();
          await imagePath.writeAsBytes(image);

          String? text = await getText();
          List<XFile> list = [];

          if (Platform.isIOS && matchModel.value!.isPublic! == 0) {
            list.add(XFile(imagePath.path));
          } else {
            list.add(XFile(imagePath.path));
          }

          /// Share Plugin
          if (onlyLink) {
            await Share.share(text!);
          } else if (onlyPicture) {
            await Share.shareXFiles(list);
          } else {
            await Share.shareXFiles(
              list,
              text: text,
            );
          }
          showShareButton.value = true;
          await imagePath.delete();
        } else {
          showShareButton.value = true;
        }
      });
    });
  }
}
