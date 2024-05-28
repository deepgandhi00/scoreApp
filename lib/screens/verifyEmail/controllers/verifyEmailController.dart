import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:score_keeper/di/services/auth/authService.dart';
import 'package:score_keeper/di/services/match/matchService.dart';
import 'package:score_keeper/screens/enterEmail/models/generateOtpRequestModel.dart';
import 'package:score_keeper/screens/home/view/homeView.dart';
import 'package:score_keeper/screens/userDetails/view/userDetailsView.dart';
import 'package:score_keeper/screens/verifyEmail/models/addPublicMatchesRequestModel.dart';
import 'package:score_keeper/screens/verifyEmail/models/verifyOtpRequestModel.dart';
import 'package:score_keeper/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:built_collection/built_collection.dart';
import 'package:device_info_plus/device_info_plus.dart';

class VerifyEmailController extends GetxController {
  List<TextEditingController> controllers = [];
  RxInt secondsRemaining = 120.obs;
  RxBool isEnableResendButton = false.obs;
  RxString otp = ''.obs;
  RxBool isEnableContinueButton = false.obs;
  var STATUS = API_STATUS.IDLE.obs;
  final RESEND_STATUS = API_STATUS.IDLE.obs;
  Rx<String> errorMessage = ''.obs;
  AuthService authService = Get.find();
  MatchService matchService = Get.find();
  dynamic argumentsData = Get.arguments;
  DateTime dateTime = DateTime.now();
  Timer? timer;

  setOtpString(String enteredOtp) => otp.value = enteredOtp;

  setIsEnabledContinueButton(bool val) => isEnableContinueButton.value = val;

  @override
  void onInit() {
    super.onInit();
    for (int i = 0; i < 4; i++) {
      TextEditingController controller = TextEditingController();
      controllers.add(controller);
    }

    FocusManager.instance.primaryFocus?.nextFocus();
    startTimer();
  }

  void navigateToHomeRoute() {
    Future.delayed(const Duration(seconds: 1), () {
      Get.offAllNamed(HomeView.routeName);
    });
  }

  void onPressDone() async {
    final String? fcmToken = await Utils.getFireBaseToken();
    final String? deviceId = await getDeviceId();
    print('getFireBaseToken ${fcmToken}');
    print('getDeviceId $deviceId');
    STATUS.value = API_STATUS.LOADING;
    VerifyOtpRequestModel verifyOtpRequestModel = VerifyOtpRequestModel(
      (b) => b
        ..email = argumentsData[0].toString()
        ..otp = int.parse(
          otp.value,
        )
        ..fcmToken = fcmToken ?? ''
        ..deviceId = deviceId ?? '',
    );
    final response = await authService.verifyOtp(verifyOtpRequestModel);

    if (response.isSuccessful) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString("accessToken", response.body!.token);
      if (preferences.containsKey('matchIds')) {
        List<String> list = preferences.getStringList('matchIds')!;
        if (list.isNotEmpty) {
          List<int> matchIds = [];
          list.forEach((element) {
            matchIds.add(int.parse(element));
          });

          final addPublicMatchesRes = await matchService.addPublicMatches(
              AddPublicMatchesRequestModel(
                  (b) => b..matches = ListBuilder(matchIds)));

          if (addPublicMatchesRes.isSuccessful) {
            preferences.remove('matchIds');
            navigateToHomeRoute();
          } else {
            navigateToHomeRoute();
          }
        } else {
          navigateToHomeRoute();
        }
      } else {
        navigateToHomeRoute();
      }
    } else {
      Map<String, dynamic> errorResponse =
          response.error as Map<String, dynamic>;
      if (response.statusCode == 400) {
        Map<String, dynamic> args = {};
        args['otp'] = otp.value;
        args['email'] = argumentsData[0].toString();
        args['fcmToken'] = fcmToken!;
        args['deviceId'] = deviceId!;
        Get.toNamed(UserDetailsView.routeName, arguments: args);
      } else {
        errorMessage.value = errorResponse['message'];
        STATUS.value = API_STATUS.ERROR;
      }
    }
  }

  void startTimer({bool isResend = false}) async {
    if (isResend) {
      RESEND_STATUS.value = API_STATUS.LOADING;
      GenerateOtpRequestModel generateOtpRequestModel = GenerateOtpRequestModel(
        (b) => b..email = argumentsData[0].toString(),
      );
      final response = await authService
          .generateOtpForEmailVerification(generateOtpRequestModel);

      if (response.isSuccessful) {
        dateTime = DateTime.now();
        Get.snackbar(
          "Success",
          "Otp Sent!",
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
        );
        RESEND_STATUS.value = API_STATUS.SUCCESS;
        resetTimer();
      }
    } else {
      resetTimer();
    }
  }

  Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.device; // unique ID on Android
    }
  }

  void resetTimer() {
    if (timer != null) {
      timer!.cancel();
    }
    secondsRemaining.value = 120;
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining.value != 0) {
        secondsRemaining.value--;
      } else {
        isEnableResendButton.value = true;
      }
    });
  }

  int elapsedTime() {
    return DateTime.now().difference(dateTime).inSeconds;
  }

  void onPauseCallBack() {
    if (timer != null) {
      timer!.cancel();
    }
  }

  void onResumeCallBack() {
    secondsRemaining.value = elapsedTime();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining.value != 0) {
        secondsRemaining.value--;
      } else {
        isEnableResendButton.value = true;
      }
    });
  }
}
