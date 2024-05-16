import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';

import '../file_viewer.dart';
import 'document_viewer_screen.dart';

class AttachmentDocumentWidget extends StatelessWidget {
  final String docPath;

  const AttachmentDocumentWidget({super.key, required this.docPath});

  @override
  Widget build(BuildContext context) {
    final FileViewer fileViewer = FileViewer();

    return Tooltip(
      message: 'Click to view document',
      child: Align(
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: () async {
            if (docPath.toLowerCase().endsWith('.pdf')) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DocumentViewerScreen(documentPath: docPath)));
            } else {
              await fileViewer.viewFile(context, docPath);
            }
          },
          child: Container(
            color: AppColor.lightGrey,
            height: 100,
            width: 100,
            child: const Icon(Icons.folder),
          ),
        ),
      ),
    );
  }
}
