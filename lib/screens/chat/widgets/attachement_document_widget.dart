import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AttachementDocumentWidget extends StatelessWidget {
  final String docPath;

  const AttachementDocumentWidget({super.key, required this.docPath});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: () {
            launchUrlString(docPath, mode: LaunchMode.externalApplication);
          },
          child: Container(
              color: AppColor.lightGrey,
              height: 100,
              width: 100,
              child: const Icon(Icons.folder)),
        ));
  }
}
