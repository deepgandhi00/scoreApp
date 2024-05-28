import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:score_keeper/di/services/user/userService.dart';
import 'package:score_keeper/models/matchStatusEnum.dart';
import 'package:score_keeper/screens/home/models/userModel.dart';
import 'package:score_keeper/screens/matchesTabs/controllers/matchesTabController.dart';
import 'package:score_keeper/screens/matchesTabs/models/matchModel.dart';
import 'package:score_keeper/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  RxInt selectedCurrentTabIndex = 0.obs;
  final user = Rxn<UserModel>();
  UserService userService = Get.find();
  final STATUS = API_STATUS.IDLE.obs;
  final filePath = Rxn<XFile>();
  final UPDATE_STATUS = API_STATUS.IDLE.obs;
  final updateTeamMatches = false.obs;

  final matchModel = Rxn<MatchModel>();
  MatchesTabController matchesTabController = Get.find();

  void setUpdateTeamMatches(bool val) => updateTeamMatches.value = val;

  void setMatchModel(MatchModel? val) => matchModel.value = val;

  @override
  void onInit() {
    Map<String, String?> data = Get.parameters;

    if (data.containsKey('tab')) {
      selectedCurrentTabIndex.value = int.parse(data['tab']!);
    }

    subscribeToMatchComplete();
    super.onInit();
  }

  @override
  void onReady() async {
    FlutterNativeSplash.remove();
    // getRatingFromCache();r fdc swws
    STATUS.value = API_STATUS.LOADING;
    final response = await userService.getProfile();
    if (response.isSuccessful) {
      user.value = response.body;
      STATUS.value = API_STATUS.SUCCESS;
    } else {
      STATUS.value = API_STATUS.ERROR;
    }
    super.onReady();
  }

  @override
  void onClose() {
    selectedCurrentTabIndex.value = 0;
    super.onClose();
  }

  void onTabPress(int index) {
    selectedCurrentTabIndex.value = index;
  }

  void onEditProfile(UserModel userModel) async {
    user.value = userModel;
  }

  void subscribeToMatchComplete() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    matchesTabController.matches.listen((matches) {
      bool isSubmitted = false;
      bool showRatingDialog = false;
      if (preferences.containsKey('submitRating')) {
        isSubmitted = preferences.getBool('submitRating')!;
      }
      if (preferences.containsKey('showRatingDialog')) {
        showRatingDialog = preferences.getBool('showRatingDialog')!;
      }

      if (matches != null) {
        int numberOfCompletedMatches = matches.data
            .where((element) => element.status == MatchStatusEnum.COMPLETED)
            .toList()
            .length;
        if (numberOfCompletedMatches % 2 == 0 && !isSubmitted && showRatingDialog) {
          showRatingsDialog();
        }
      }
    });
  }

  void showRatingsDialog() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final _dialog = RatingDialog(
      initialRating: 1.0,
      // your app's name?
      title: const Text(
        'Score',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      // encourage your user to leave a high rating?
      message: const Text(
        'Tap a star to set your rating. Add more description here if you want.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
      image: Image.asset('assets/images/app_icon.png'),
      submitButtonText: 'Submit',
      commentHint: 'Give Your Comments',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        preferences.setBool('submitRating', true);
      },
    );
    showDialog(
      context: Get.context!,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => _dialog,
    );
  }
}
