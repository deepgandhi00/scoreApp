import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:score_keeper/components/buttons/baseButton.dart';
import 'package:score_keeper/components/buttons/outlineButton.dart';
import 'package:score_keeper/utils/stringUtils.dart';

class SelectBottomSheet extends StatelessWidget {
  final Function fileSelectCallBack;

  const SelectBottomSheet({Key? key, required this.fileSelectCallBack})
      : super(key: key);

  void selectFile(ImageSource imageSource) {
    ImagePicker().pickImage(source: imageSource).then((value) {
      fileSelectCallBack(value);
      Get.back();
    }).catchError((err) => print(err.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Image(
              image: AssetImage('assets/images/close_icon.png'),
              width: 18,
              height: 18,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BaseButton(
                  onPressed: () => selectFile(ImageSource.camera),
                  text: StringUtils.OPEN_CAMERA,
                ),
                OutlineButton(
                  onPressed: () => selectFile(ImageSource.gallery),
                  text: StringUtils.SELECT_FROM_GALLERY,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
