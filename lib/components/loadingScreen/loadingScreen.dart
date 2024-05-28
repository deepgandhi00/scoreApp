import 'package:flutter/material.dart';
import 'package:score_keeper/utils/colors.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: CustomColors.appBarColor,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
