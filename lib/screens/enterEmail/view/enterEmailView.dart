import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:score_keeper/components/buttons/baseButton.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/screens/enterEmail/controllers/enterEmailController.dart';
import 'package:score_keeper/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../components/textFields/baseTextField.dart';

class EnterEmailView extends StatelessWidget {
  static String routeName = '/enterEmail';
  EnterEmailController enterEmailController = Get.find();

  EnterEmailView({Key? key}) : super(key: key);

  void onPrivacyPolicyClick() {
    final Uri url = Uri.parse('https://google.com');
    launchUrl(url, mode: LaunchMode.externalApplication).catchError((err) {
      print(err.toString());
    });
  }

  void onTermsAndConditionClick() {
    final Uri url = Uri.parse('https://google.com');
    launchUrl(url, mode: LaunchMode.externalApplication).catchError((err) {
      print(err.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: CustomColors.background),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 32,
              ),
              const Text(
                'Email',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 6,
              ),
              const Text('Please enter your email.',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.left),
              const SizedBox(
                height: 14,
              ),
              Obx(
                () => BaseTextField(
                  labelText: 'Email',
                  hasBorder: true,
                  isRequired: true,
                  controller: enterEmailController.controller,
                  showUnderLineBorder: true,
                  errorText: enterEmailController.errorMessage.value != ''
                      ? enterEmailController.errorMessage.value
                      : null,
                  onChange: enterEmailController.onChangeText,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w400, height: 1.54),
                  children: [
                    const TextSpan(
                      text: 'By entering your email you agree with the\n',
                    ),
                    TextSpan(
                      text: 'Terms Condition',
                      recognizer: TapGestureRecognizer()..onTap = () => onTermsAndConditionClick(),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        height: 1.54,
                        color: CustomColors.primaryColor,
                      ),
                    ),
                    const TextSpan(text: ' & '),
                    TextSpan(
                      text: 'Privacy Policy',
                      recognizer: TapGestureRecognizer()..onTap = () => onPrivacyPolicyClick(),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        height: 1.54,
                        color: CustomColors.primaryColor,
                      ),
                    ),
                    const TextSpan(text: ' of Score. ')
                  ],
                ),
              ),
              Expanded(child: Container()),
              Obx(
                () => BaseButton(
                  onPressed: enterEmailController.onPressVerifyEmail,
                  text: 'Verify Email',
                  isLoading: enterEmailController.STATUS == API_STATUS.LOADING,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
