import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:score_keeper/screens/enterEmail/view/enterEmailView.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/firebaseMessagingUtils.dart';

class IntroScreenView extends StatelessWidget {
  static String routeName = '/introScreens';

  const IntroScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: CustomColors.appBarColor,
          ),
        ),
        body: IntroductionScreen(
          done: const Text('Done'),
          skip: const Text('Skip'),
          onDone: () {
            Get.offNamed(EnterEmailView.routeName);
          },
          onSkip: () {
            Get.offNamed(EnterEmailView.routeName);
          },
          showNextButton: true,
          next: const Text('Next'),
          showSkipButton: true,
          pages: [
            PageViewModel(
              titleWidget: Container(),
              bodyWidget: getPageWidget(
                context: context,
                title: 'Create and Manage Teams',
                description: 'Description 1',
                assetImage: 'assets/images/image3.jpg',
              ),
            ),
            PageViewModel(
              titleWidget: Container(),
              bodyWidget: getPageWidget(
                context: context,
                title: 'Track Matches',
                description: 'Description 2',
                assetImage: 'assets/images/image1.jpg',
              ),
            ),
            PageViewModel(
              titleWidget: Container(),
              bodyWidget: getPageWidget(
                context: context,
                title: 'Players',
                description: 'Description 3',
                assetImage: 'assets/images/image2.jpg',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getPageWidget(
      {required BuildContext context,
      required String title,
      required String description,
      required String assetImage}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Image.asset(
          assetImage,
          height: MediaQuery.of(context).size.height * 0.45,
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: CustomColors.primaryColor,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.white,
            height: 1.5,
          ),
        )
      ],
    );
  }
}
