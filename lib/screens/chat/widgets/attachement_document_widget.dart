import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../file_viewer.dart';
import 'document_viewer_screen.dart';

class AttachmentDocumentWidget extends StatelessWidget {
  final String docPath;
  final String fileName;

  const AttachmentDocumentWidget(
      {super.key, required this.docPath, required this.fileName});

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
                      height: 120,
                      width: 120,
                      decoration:
                          const BoxDecoration(color: AppColor.lightGrey),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: tiniestSpacing),
                        Image.asset(
                          'assets/icons/pdf.png',
                          height: 40,
                          width: 40,
                          fit: BoxFit.contain,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            fileName,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.tinySmall,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              : Stack(alignment: Alignment.topCenter, children: [
                  Container(
                      height: 120,
                      width: 120,
                      decoration:
                          const BoxDecoration(color: AppColor.lightGrey)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: tiniestSpacing),
                      fileViewer.viewDocumentIcons(docPath),
                      Text(fileName,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.tinySmall),
                    ],
                  )
                ]),
        ),
      ),
    );
  }
}
