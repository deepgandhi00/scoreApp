import 'package:flutter/material.dart';
import 'package:score_keeper/utils/colors.dart';

class BaseTextField extends StatelessWidget {
  final String? labelText;
  final bool hasBorder;
  final TextEditingController? controller;
  final bool showUnderLineBorder;
  final Color outlineBorderColor;
  final Color underLineBorderColor;
  final Color focusedOutlineBorderColor;
  final Color focusedUnderLineBorderColor;
  final Color focusedLabelColor;
  final TextAlign textAlign;
  final bool alignLabelWithHint;
  final String? errorText;
  final Function? onChange;
  final Function? onTap;
  final Color? fillColor;
  final String? hintText;
  final Widget? prefixIcon;
  final bool isRequired;

  const BaseTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.hasBorder = false,
    this.showUnderLineBorder = false,
    this.outlineBorderColor = CustomColors.inputBorderColor,
    this.underLineBorderColor = CustomColors.inputBorderColor,
    this.focusedOutlineBorderColor = CustomColors.primaryColor,
    this.focusedUnderLineBorderColor = CustomColors.primaryColor,
    this.focusedLabelColor = CustomColors.primaryColor,
    this.textAlign = TextAlign.start,
    this.alignLabelWithHint = false,
    this.errorText,
    this.onChange,
    this.onTap,
    this.fillColor,
    this.hintText,
    this.prefixIcon,
    required this.isRequired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: Colors.white,
      textAlign: textAlign,
      style: const TextStyle(fontSize: 15),
      focusNode: onTap != null ? AlwaysDisabledFocusNode() : null,
      onChanged: (String s) {
        if (onChange != null) {
          onChange!();
        }
      },
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      decoration: InputDecoration(
        label: labelText != null
            ? RichText(
                text: TextSpan(
                    text: labelText,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                    children: isRequired
                        ? [
                            const TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                ))
                          ]
                        : []),
              )
            : null,
        prefixIcon: prefixIcon,
        alignLabelWithHint: alignLabelWithHint,
        errorText: errorText,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CustomColors.redText, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CustomColors.redText, width: 1),
        ),
        enabledBorder: hasBorder
            ? OutlineInputBorder(
                borderSide: BorderSide(color: outlineBorderColor, width: 1),
              )
            : showUnderLineBorder
                ? UnderlineInputBorder(
                    borderSide: BorderSide(color: underLineBorderColor),
                  )
                : InputBorder.none,
        focusedBorder: hasBorder
            ? OutlineInputBorder(
                borderSide:
                    BorderSide(color: focusedOutlineBorderColor, width: 1),
              )
            : showUnderLineBorder
                ? UnderlineInputBorder(
                    borderSide: BorderSide(color: focusedUnderLineBorderColor),
                  )
                : InputBorder.none,
        focusColor:
            errorText != null ? CustomColors.redText : focusedLabelColor,
        labelStyle: TextStyle(
          color: errorText != null ? CustomColors.redText : focusedLabelColor,
        ),
        fillColor: fillColor,
        filled: fillColor != null ? true : false,
        hintText: hintText,
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
