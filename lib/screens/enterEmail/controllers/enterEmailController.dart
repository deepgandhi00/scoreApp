import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:score_keeper/di/services/auth/authService.dart';
import 'package:score_keeper/screens/enterEmail/models/generateOtpRequestModel.dart';
import 'package:score_keeper/screens/verifyEmail/view/verifyEmailView.dart';
import 'package:score_keeper/utils/utils.dart';

class EnterEmailController extends GetxController {
  AuthService authService = Get.find();
  TextEditingController controller = TextEditingController();
  var STATUS = API_STATUS.IDLE.obs;
  Rx<String> errorMessage = ''.obs;

  void onPressVerifyEmail() async {
    if (checkValidEmail()) {
      STATUS.value = API_STATUS.LOADING;

      final generateOtpRequestModel =
          GenerateOtpRequestModel((b) => b ..email = controller.text);

      final response = await authService
          .generateOtpForEmailVerification(generateOtpRequestModel);

      if (response.isSuccessful) {
        STATUS.value = API_STATUS.SUCCESS;
        Get.toNamed(VerifyEmail.routeName, arguments: [controller.text]);
      } else {
        Map<String, dynamic> errorResponse =
            response.error as Map<String, dynamic>;
        errorMessage.value = errorResponse['message'];
        STATUS.value = API_STATUS.ERROR;
      }
    } else {
      errorMessage.value = 'Please enter a valid email';
      STATUS.value = API_STATUS.ERROR;
    }
  }

  void onChangeText() {
    errorMessage.value = '';
    STATUS.value = API_STATUS.IDLE;
  }

  bool checkValidEmail() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(controller.text);
  }
}
