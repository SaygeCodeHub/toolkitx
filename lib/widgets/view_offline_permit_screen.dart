import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/blocs/permit/permit_states.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

class OfflineHtmlViewerScreen extends StatelessWidget {
  static const routeName = 'OfflineHtmlViewerScreen';
  final String permitId;

  const OfflineHtmlViewerScreen({super.key, required this.permitId});

  @override
  Widget build(BuildContext context) {
    context.read<PermitBloc>().add(GenerateOfflinePdf(permitId: permitId));
    return Scaffold(
        appBar: const GenericAppBar(),
        body: BlocBuilder<PermitBloc, PermitStates>(builder: (context, state) {
          if (state is GeneratingOfflinePdf) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is OfflinePdfGenerated) {
            // generatePdfFromHtml(state.htmlContent);
            return InAppWebView(
                initialUrlRequest: URLRequest(
                    url: WebUri.uri(Uri.dataFromString(state.htmlContent,
                        mimeType: 'text/html',
                        encoding: Encoding.getByName('UTF-8')))));
          } else if (state is ErrorGeneratingPdfOffline) {
            return const Center(child: Text('Generating PDF error'));
          } else {
            return const SizedBox();
          }
        }));
  }

// Future<void> generatePdfFromHtml(String htmlContent) async {
//   try {
//     Directory appDocDir = await getTemporaryDirectory();
//     String appDocPath = appDocDir.path;
//
//     var targetFileName = "example.pdf";
//     var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
//       htmlContent,
//       appDocPath,
//       targetFileName,
//     );
//
//     print("Generated PDF File Path: ${generatedPdfFile.path}");
//   } catch (e) {
//     print("eeeeeee $e");
//   }
// }
}
