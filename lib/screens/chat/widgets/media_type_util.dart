import 'dart:io';

import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

class MediaTypeUtil {
  Widget showMediaWidget(type, Map typeData, BuildContext context,
      {double? width, double? height, int? isMe}) {
    switch (type) {
      case 'Image':
        return Image.file(File(typeData['file'] ?? ''),
            width: width ?? 400, height: height ?? 650);
      case 'Video':
        return const Icon(Icons.video_collection);
      case 'Document':
        return const Icon(Icons.folder);
      default:
        return Text(typeData['file'] ?? '',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(fontWeight: FontWeight.w500));
    }
  }
}
