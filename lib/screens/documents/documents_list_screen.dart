import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/documents/documents_bloc.dart';
import 'package:toolkit/blocs/documents/documents_events.dart';
import 'package:toolkit/screens/documents/widgets/document_list_tile.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_icon_button_row.dart';
import '../../widgets/text_button.dart';

class DocumentsListScreen extends StatelessWidget {
  static const routeName = 'DocumentsListScreen';
  static int page = 1;
  final bool isFromHome;

  const DocumentsListScreen({super.key, required this.isFromHome});

  @override
  Widget build(BuildContext context) {
    page = 1;
    context
        .read<DocumentsBloc>()
        .add(GetDocumentsList(page: 1, isFromHome: isFromHome));
    return Scaffold(
        appBar: const GenericAppBar(title: 'Documents'),
        body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Visibility(
                  visible: context.read<DocumentsBloc>().filters.isNotEmpty,
                  child: CustomTextButton(
                      onPressed: () {
                        page = 1;
                      },
                      textValue: DatabaseUtil.getText('Clear'))),
              CustomIconButtonRow(
                  isEnabled: true,
                  primaryOnPress: () {},
                  secondaryOnPress: () {},
                  clearOnPress: () {})
            ]),
            const SizedBox(height: xxTinierSpacing),
            const DocumentListTile()
          ]),
        ));
  }
}
