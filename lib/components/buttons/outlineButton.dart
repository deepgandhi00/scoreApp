import 'package:flutter/material.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/stringUtils.dart';

class OutlineButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double width;
  final EdgeInsets padding;
  final double fontSize;
  final double height;
  final Color textColor;
  final Color borderColor;
  final bool isLoading;

  const OutlineButton({
    super.key,
    required this.onPressed,
    this.text = StringUtils.OKAY,
    this.width = double.infinity,
    this.padding = const EdgeInsets.all(0),
    this.fontSize = 16,
    this.height = 56,
    this.textColor = CustomColors.outlineButtonBorder,
    this.borderColor = CustomColors.outlineButtonBorder,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        width: width,
        height: height,
        child: ElevatedButton.icon(
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
          onPressed: () => {onPressed()},
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.appBarColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: BorderSide(width: 1, color: borderColor),
            ),
          ),
          label: Text(
            text,
            style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                color: textColor),
          ),
        ),
      ),
    );
  }
}
