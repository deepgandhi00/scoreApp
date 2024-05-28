import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:score_keeper/components/noDataScreen/noDataScreen.dart';
import 'package:score_keeper/screens/home/view/homeView.dart';
import 'package:score_keeper/screens/splash/view/splashView.dart';

class NoConnectionView extends StatelessWidget {
  static String routeName = '/noConnection';
  const NoConnectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NoDataScreen(
        title: 'No Internet Connection',
        message: 'Please check your internet connection and try again',
        showButton: true,
        btnText: 'Back',
        onPress: () {
          Get.offAllNamed(HomeView.routeName);
        },
      ),
    );
  }
}
