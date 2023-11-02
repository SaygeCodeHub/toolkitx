import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/documents/documents_bloc.dart';
import 'package:toolkit/blocs/documents/documents_events.dart';
import 'package:toolkit/screens/documents/widgets/document_list_tile.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../blocs/documents/documents_states.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_icon_button_row.dart';
import 'change_role_documents.dart';
import 'document_filter_screen.dart';

class DocumentsListScreen extends StatelessWidget {
  static const routeName = 'DocumentsListScreen';
  static int page = 1;
  final bool isFromHome;

  const DocumentsListScreen({super.key, required this.isFromHome});

  @override
  Widget build(BuildContext context) {
    page = 1;
    context.read<DocumentsBloc>().docListReachedMax = false;
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
              BlocBuilder<DocumentsBloc, DocumentsStates>(
                  builder: (context, state) {
                return CustomIconButtonRow(
                    clearVisible:
                        context.read<DocumentsBloc>().filters.isNotEmpty,
                    isEnabled: true,
                    primaryOnPress: () {
                      Navigator.pushNamed(
                          context, DocumentFilterScreen.routeName);
                    },
                    secondaryOnPress: () {
                      Navigator.pushNamed(
                          context, ChangeRoleDocumentsScreen.routeName);
                    },
                    clearOnPress: () {});
              }),
              const SizedBox(height: xxTinierSpacing),
              const DocumentListTile()
            ])));
  }
}
