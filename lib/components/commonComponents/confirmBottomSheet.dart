import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:score_keeper/components/buttons/baseButton.dart';
import 'package:score_keeper/components/buttons/outlineButton.dart';
import 'package:score_keeper/utils/stringUtils.dart';

class ConfirmBottomSheet extends StatelessWidget {
  final String title;
  final String message;
  final Function onDeletePress;
  final Function? onCancelPress;
  final bool isLoading;
  final String deleteButtonText;
  final String cancelButtonText;
  final bool cancelButtonIsLoading;

  const ConfirmBottomSheet({
    Key? key,
    this.title = StringUtils.DELETE,
    this.message = StringUtils.DELETE_CONFIRMATION,
    required this.onDeletePress,
    this.onCancelPress,
    required this.isLoading,
    this.deleteButtonText = StringUtils.DELETE,
    this.cancelButtonText = StringUtils.CANCEL,
    this.cancelButtonIsLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: 250,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              children: [
                isLoading
                    ? BaseButton(
                        onPressed: onDeletePress,
                        text: deleteButtonText,
                        isLoading: true,
                        width: MediaQuery.of(context).size.width / 2 - 24,
                      )
                    : BaseButton(
                        onPressed: onDeletePress,
                        text: deleteButtonText,
                        isLoading: false,
                        width: MediaQuery.of(context).size.width / 2 - 24,
                      ),
                OutlineButton(
                  onPressed: () {
                    Get.back();
                    if (onCancelPress != null) {
                      onCancelPress!();
                    }
                  },
                  isLoading: cancelButtonIsLoading ? true : false,
                  text: cancelButtonText,
                  width: MediaQuery.of(context).size.width / 2 - 24,
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
