import 'dart:io';

import 'package:flutter/material.dart';
import 'package:toolkit/screens/chat/widgets/attachement_document_widget.dart';
import 'package:toolkit/screens/chat/widgets/attachement_video_widget.dart';

class AttachementMsgTypeUtil {
  Widget renderWidget(String type, String mediaPath) {
    switch (type) {
      case '2':
        return Image.file(fit: BoxFit.cover, errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return Text('Failed to load image: $exception');
        }, File(mediaPath));
      case '3':
        return AttachementVideoWidget(videoPath: mediaPath);
      case '4':
        return AttachementDocumentWidget(docPath: mediaPath);
      default:
        return const SizedBox.shrink();
    }
  }
}
