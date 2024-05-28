import 'dart:io';

import 'package:flutter/material.dart';

class NetworkImageWithPlaceHolder extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final String placeholderAssetPath;
  final String? filePath;

  const NetworkImageWithPlaceHolder({
    Key? key,
    required this.imageUrl,
    this.width = 50,
    this.placeholderAssetPath = 'assets/images/app_icon.png',
    this.filePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (filePath != null) {
      return CircleAvatar(
        radius: width / 2,
        backgroundImage: FileImage(
          File(filePath!),
        ),
      );
    } else if (imageUrl != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(width / 2),
        child: FadeInImage.assetNetwork(
          width: width,
          height: width,
          fit: BoxFit.fill,
          placeholder: placeholderAssetPath,
          image: imageUrl!,
        ),
      );
    } else {
      return CircleAvatar(
        radius: width / 2,
        backgroundImage: Image.asset(
          placeholderAssetPath,
          width: width,
          height: width,
          fit: BoxFit.contain,
        ).image,
      );
    }
  }
}
