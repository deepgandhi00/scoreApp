import 'dart:io';

import 'package:flutter/material.dart';
import 'package:score_keeper/components/custom/networkImageWithPlaceholder.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/utils.dart';

class ConditionalImage extends StatelessWidget {
  final String? filePath;
  final String? imageUrl;
  final Function fileSelectCallBack;
  final double width;

  const ConditionalImage({
    Key? key,
    this.filePath,
    this.imageUrl,
    required this.fileSelectCallBack,
    this.width = 60,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if ((filePath != null && filePath != '') || imageUrl != null) {
      return GestureDetector(
        onTap: () =>
            Utils.onPickImagePress(fileSelectCallBack: fileSelectCallBack),
        child: NetworkImageWithPlaceHolder(imageUrl: imageUrl, filePath: filePath, width: width,),
      );
    } else {
      return GestureDetector(
        onTap: () =>
            Utils.onPickImagePress(fileSelectCallBack: fileSelectCallBack),
        child: Container(
          width: width * 2,
          height: width * 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(120),
            color: CustomColors.imagePickBackground,
          ),
          child: const Center(
            child: Image(
              image: AssetImage('assets/images/camera_icon.png'),
              width: 32,
              height: 32,
            ),
          ),
        ),
      );
    }
  }

  ImageProvider<Object>? getImage() {
    if (filePath != null && filePath != '') {
      return FileImage(File(filePath!));
    } else {
      return FadeInImage.assetNetwork(
        placeholder: 'assets/images/app_icon.png',
        image: imageUrl!,
      ).image;
    }
  }
}
