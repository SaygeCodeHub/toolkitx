import 'dart:io';

import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/chat/widgets/attachement_document_widget.dart';
import 'package:toolkit/screens/chat/widgets/attachement_video_widget.dart';
import 'package:toolkit/screens/chat/widgets/view_attached_image_widget.dart';

import '../../configs/app_color.dart';

class AttachementMsgTypeUtil {
  Widget renderWidget(String type, String mediaPath, BuildContext context,
      int isReceiver, String fileName, String msgStatus) {
    switch (type) {
      case '2':
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, ViewAttachedImageWidget.routeName,
                arguments: mediaPath);
          },
          child: Container(
            height: 120,
            width: 120,
            decoration: const BoxDecoration(color: AppColor.lightGrey),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: tiniestSpacing),
                Image.file(fit: BoxFit.fitHeight, height: 50, width: 50,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                  return Flexible(
                      child: Text('Failed to load image: $exception'));
                }, File(mediaPath)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(fileName,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.tinySmall),
                      ),
                      const SizedBox(width: tiniestSpacing),
                      (msgStatus != '1')
                          ? const Icon(Icons.timer,
                              size: 10, color: AppColor.greyBlack)
                          : const SizedBox.shrink(),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      case '3':
        return AttachementVideoWidget(
            videoPath: mediaPath, fileName: fileName, msgStatus: msgStatus);
      case '4':
        return AttachmentDocumentWidget(
            docPath: mediaPath, fileName: fileName, msgStatus: msgStatus);
      default:
        return const SizedBox.shrink();
    }
  }
}
