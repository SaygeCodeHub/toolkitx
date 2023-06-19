import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InAppWebViewScreen extends StatefulWidget {
  static const routeName = 'InAppWebView';
  final String url;

  const InAppWebViewScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<InAppWebViewScreen> createState() => _InAppWebViewScreenState();
}

class _InAppWebViewScreenState extends State<InAppWebViewScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Stack(children: [
          InAppWebView(
            onLoadStop: (controller, url) {
              setState(() {
                isLoading = false;
              });
            },
            initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
          ),
          Visibility(
              visible: isLoading,
              child: const Center(child: CircularProgressIndicator()))
        ]));
  }
}
