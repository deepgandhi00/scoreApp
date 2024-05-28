import 'package:flutter/material.dart';
import 'package:score_keeper/components/buttons/baseButton.dart';
import 'package:score_keeper/components/textFields/otpInput.dart';
import 'package:score_keeper/screens/verifyEmail/controllers/verifyEmailController.dart';
import 'package:get/get.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/utils.dart';

class VerifyEmail extends StatefulWidget {
  static String routeName = '/verifyEmail';

  VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> with WidgetsBindingObserver {
  VerifyEmailController verifyEmailController =
      Get.find<VerifyEmailController>();

  void otpCallBack(String otp) {
    verifyEmailController.setOtpString(otp);
    verifyEmailController.setIsEnabledContinueButton(true);
  }

  void otpEditCallBack() {
    verifyEmailController.setIsEnabledContinueButton(false);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      verifyEmailController.onResumeCallBack();
    }

    if (state == AppLifecycleState.paused) {
      verifyEmailController.onPauseCallBack();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: CustomColors.background,
        ),
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 32,
                ),
                const Text(
                  'Enter OTP',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 6,
                ),
                const Text('Please enter the otp.',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left),
                const SizedBox(
                  height: 16,
                ),
                OtpInput(
                  callBack: otpCallBack,
                  editCallBack: otpEditCallBack,
                  errorText: verifyEmailController.errorMessage.value != ''
                      ? verifyEmailController.errorMessage.value
                      : null,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  verifyEmailController.secondsRemaining.value.toString(),
                  style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                    'OTP not received?\nCheck your junk mail or try to resend ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Column(
                  children: [
                    verifyEmailController.RESEND_STATUS.value ==
                            API_STATUS.LOADING
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: CustomColors.primaryColor,
                              strokeWidth: 1,
                            ),
                          )
                        : GestureDetector(
                            onTap: () => verifyEmailController.startTimer(
                                isResend: true),
                            child: Text(
                              'Resend',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: verifyEmailController
                                          .isEnableResendButton.isTrue
                                      ? CustomColors.primaryColor
                                      : Colors.white),
                            ),
                          ),
                    const SizedBox(
                      height: 24,
                    ),
                    BaseButton(
                      onPressed: verifyEmailController.onPressDone,
                      text: 'Done',
                      isEnabled:
                          verifyEmailController.isEnableContinueButton.value,
                      isLoading:
                          verifyEmailController.STATUS == API_STATUS.LOADING,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
