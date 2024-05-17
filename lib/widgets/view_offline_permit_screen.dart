import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toolkit/utils/constants/html_constants.dart';
import 'package:toolkit/widgets/text_button.dart';

class OfflineHtmlViewerScreen extends StatelessWidget {
  const OfflineHtmlViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: [
            CustomTextButton(
              onPressed: () {
                // generatePdfFromHtml(HTMLOfflineConstants.offlinePermitType12);
              },
              textValue: 'Generate PDF',
            )
          ],
        ),
        body: InAppWebView(
          initialUrlRequest: URLRequest(
              url: WebUri.uri(Uri.dataFromString(
                  HTMLOfflineConstants.offlinePermitType12,
                  mimeType: 'text/html',
                  encoding: Encoding.getByName('UTF-8')))), // Updated line
        ),
      ),
    );
  }

  Future<void> generatePdfFromHtml(String htmlContent) async {
    try {
      Directory appDocDir = await getTemporaryDirectory();
      String appDocPath = appDocDir.path;

      // Define the output file path
      var targetFileName = "example.pdf";
      var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        htmlContent,
        appDocPath,
        targetFileName,
      );

      print("Generated PDF File Path: ${generatedPdfFile.path}");
    } catch (e) {
      print("eeeeeee $e");
    }
  }
}
