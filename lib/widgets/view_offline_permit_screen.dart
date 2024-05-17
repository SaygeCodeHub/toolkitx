import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:toolkit/utils/constants/html_constants.dart';

class OfflineHtmlViewerScreen extends StatelessWidget {
  const OfflineHtmlViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
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
}
