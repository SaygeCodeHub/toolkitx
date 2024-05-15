import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/screens/chat/widgets/document_viewer_screen.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AttachementDocumentWidget extends StatelessWidget {
  final String docPath;

  const AttachementDocumentWidget({super.key, required this.docPath});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Click to view document',
      child: Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () {
              print('open path $docPath');
              // OpenFile.open(docPath);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DocumentViewerScreen(documentPath: docPath)));
            },
            child: Container(
                color: AppColor.lightGrey,
                height: 100,
                width: 100,
                child: const Icon(Icons.folder)),
          )),
    );
  }
}
