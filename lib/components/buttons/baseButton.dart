import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/stringUtils.dart';

class BaseButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isEnabled;
  final double width;
  final double fontSize;
  final double height;
  final bool isLoading;

  const BaseButton({
    super.key,
    required this.onPressed,
    this.text = StringUtils.OKAY,
    this.isEnabled = true,
    this.width = double.infinity,
    this.fontSize = 16,
    this.height = 56,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton.icon(
        onPressed: () => {
          if (isEnabled && !isLoading) {onPressed()}
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled
              ? CustomColors.primaryColor
              : CustomColors.buttonDisabledColor,
        ),
        icon: isLoading
            ? Container(
                width: 24,
                height: 24,
                padding: const EdgeInsets.all(2.0),
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 1,
                ),
              )
            : Container(),
        label: Text(
          text,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: isEnabled ? Colors.white : Colors.white54),
        ),
      ),
    );
  }
}
