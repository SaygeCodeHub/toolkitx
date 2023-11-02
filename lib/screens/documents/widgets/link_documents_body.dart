import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/documents/documents_bloc.dart';
import '../../../blocs/documents/documents_states.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_no_records_text.dart';
import '../link_document_screen.dart';
import 'link_document_multiselect.dart';

class LinkDocumentsBody extends StatelessWidget {
  const LinkDocumentsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DocumentsBloc, DocumentsStates>(
        buildWhen: (previousState, currentState) =>
            ((currentState is DocumentsToLinkFetched) ||
                (currentState is FetchingDocumentsToLink &&
                    LinkDocumentScreen.page == 1 &&
                    context
                        .read<DocumentsBloc>()
                        .documentsToLinkList
                        .isEmpty)) ||
            currentState is DocumentsListError,
        listener: (context, state) {
          if (state is DocumentsToLinkFetched) {
            if (state.documentsToLinkModel.status == 204 &&
                context.read<DocumentsBloc>().documentsToLinkList.isNotEmpty) {
              showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
            }
          }
        },
        builder: (context, state) {
          if (state is FetchingDocumentsToLink) {
            return Center(
                child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3.5),
                    child: const CircularProgressIndicator()));
          } else if (state is DocumentsToLinkFetched) {
            if (context.read<DocumentsBloc>().documentsToLinkList.isNotEmpty) {
              return LinkDocumentMultiSelect(
                  linkDocumentsList: state.documentsToLinkList);
            } else if (state.documentsToLinkModel.status == 204 &&
                context.read<DocumentsBloc>().documentsToLinkList.isEmpty) {
              if (context.read<DocumentsBloc>().filters.isEmpty) {
                return const NoRecordsText(
                    text: StringConstants.kNoRecordsFilter);
              } else {
                return NoRecordsText(
                    text: DatabaseUtil.getText('no_records_found'));
              }
            } else {
              return const SizedBox.shrink();
            }
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
