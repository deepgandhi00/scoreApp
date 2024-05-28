import 'package:flutter/material.dart';
import 'package:score_keeper/components/buttons/baseButton.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/stringUtils.dart';

class NoDataScreen extends StatelessWidget {
  final String title;
  final String message;
  Function? onPress;
  String btnText;
  bool isLoading;
  bool showButton;
  bool showPointer;
  EdgeInsetsGeometry? padding;

  NoDataScreen({
    Key? key,
    required this.title,
    required this.message,
    this.onPress,
    this.btnText = StringUtils.OKAY,
    this.isLoading = false,
    this.showButton = false,
    this.showPointer = false,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            Image.asset(
              'assets/images/empty_view.jpg',
              width: 144,
              height: 168,
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              message,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            Expanded(child: Container()),
            showButton
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                    child: BaseButton(
                      onPressed: () => onPress!(),
                      text: btnText,
                      isLoading: isLoading,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
