import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:open_file/open_file.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/blocs/permit/permit_states.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:path_provider/path_provider.dart';

class OfflineHtmlViewerScreen extends StatelessWidget {
  static const routeName = 'OfflineHtmlViewerScreen';
  final String permitId;

  const OfflineHtmlViewerScreen({super.key, required this.permitId});

  @override
  Widget build(BuildContext context) {
    String htmlText = '';
    context.read<PermitBloc>().add(GenerateOfflinePdf(permitId: permitId));
    return Scaffold(
      appBar: const GenericAppBar(),
      bottomNavigationBar: BottomAppBar(
        child: PrimaryButton(
          onPressed: () async {
            final output = await getTemporaryDirectory();
            final File file = File('${output.path}/permit_pdf.html');

            await file.writeAsString(htmlText);

            await OpenFile.open(file.path);
          },
          textValue: StringConstants.kPrintPermit,
        ),
      ),
      body: BlocBuilder<PermitBloc, PermitStates>(
        buildWhen: (previousState, currentState) =>
            currentState is GeneratingOfflinePdf ||
            currentState is OfflinePdfGenerated ||
            currentState is ErrorGeneratingPdfOffline,
        builder: (context, state) {
          if (state is GeneratingOfflinePdf) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is OfflinePdfGenerated) {
            htmlText = state.htmlContent;
            return InAppWebView(
                initialUrlRequest: URLRequest(
                    url: Uri.dataFromString(
              state.htmlContent,
              mimeType: 'text/html',
              encoding: Encoding.getByName('UTF-8'),
            )));
          } else if (state is ErrorGeneratingPdfOffline) {
            return const Center(child: Text('Generating PDF error'));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
