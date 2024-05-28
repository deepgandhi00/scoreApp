import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  static String routeName = '/splashView';

  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Image(
            image: const AssetImage('assets/images/app_icon.png'),
            height: 32,
            width: (MediaQuery.of(context).size.width * 2) / 3,
          ),
        ),
      ),
    );
  }
}
