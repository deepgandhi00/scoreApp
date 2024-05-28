import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:score_keeper/di/services/auth/authService.dart';
import 'package:score_keeper/di/services/match/matchService.dart';
import 'package:score_keeper/screens/home/view/homeView.dart';
import 'package:score_keeper/screens/verifyEmail/models/addPublicMatchesRequestModel.dart';
import 'package:score_keeper/screens/verifyEmail/models/verifyOtpRequestModel.dart';
import 'package:score_keeper/utils/utils.dart';
import 'package:score_keeper/utils/validations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:built_collection/built_collection.dart';

class UserDetailsController extends GetxController {
  final STATUS = API_STATUS.IDLE.obs;
  final isEnableContinueButton = false.obs;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final lastNameError = Rxn<String>();
  final firstNameError = Rxn<String>();
  Rx<String> errorMessage = ''.obs;
  AuthService authService = Get.find();
  MatchService matchService = Get.find();

  late String email, otp, fcmToken, deviceId;

  @override
  void onInit() {
    Map<String, dynamic> args = Get.arguments;
    if (args != null && args.containsKey('email')) {
      email = args['email'] ?? '';
    }

    if (args != null && args.containsKey('otp')) {
      otp = args['otp'] ?? '';
    }

    if (args != null && args.containsKey('fcmToken')) {
      fcmToken = args['fcmToken'] ?? '';
    }

    if (args != null && args.containsKey('deviceId')) {
      deviceId = args['deviceId'] ?? '';
    }
    super.onInit();
  }

  void onChangeFirstName() => firstNameError.value = null;

  void onChangeLastName() => lastNameError.value = null;

  void onPressDone() async {
    String? firstError = Validations.validateNameFields(
        value: firstNameController.text, fieldName: 'first name');
    if (firstError != null) {
      firstNameError.value = firstError;
      return;
    }

    String? lastError = Validations.validateNameFields(
        value: lastNameController.text, fieldName: 'last name');
    if (lastError != null) {
      lastNameError.value = lastError;
      return;
    }

    STATUS.value = API_STATUS.LOADING;
    VerifyOtpRequestModel verifyOtpRequestModel = VerifyOtpRequestModel(
      (b) => b
        ..email = email
        ..deviceId = deviceId
        ..fcmToken = fcmToken
        ..otp = int.parse(otp)
        ..firstName = firstNameController.text
        ..lastName = lastNameController.text,
    );

    final response = await authService.verifyOtp(verifyOtpRequestModel);

    if (response.isSuccessful) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString("accessToken", response.body!.token);
      STATUS.value = API_STATUS.SUCCESS;
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

      errorMessage.value = errorResponse['message'];
      STATUS.value = API_STATUS.ERROR;
    }
  }

  void navigateToHomeRoute() {
    Future.delayed(const Duration(seconds: 1), () {
      Get.offAllNamed(HomeView.routeName);
    });
  }
}
