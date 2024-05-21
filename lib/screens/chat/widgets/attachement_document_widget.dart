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
        alignment: Alignment.centerRight,
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
          child: (docPath.toLowerCase().endsWith('.pdf'))
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration:
                          const BoxDecoration(color: AppColor.lightGrey),
                    ),
                    Image.asset(
                      'assets/icons/pdf.png',
                      height: 40,
                      width: 40,
                      fit: BoxFit.contain,
                    ),
                  ],
                )
              : Stack(alignment: Alignment.center, children: [
                  Container(
                      height: 100,
                      width: 100,
                      decoration:
                          const BoxDecoration(color: AppColor.lightGrey)),
                  fileViewer.viewDocumentIcons(docPath)
                ]),
        ),
      ),
    );
  }
}
