import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/documents/documents_bloc.dart';
import '../../../blocs/documents/documents_events.dart';
import '../../../blocs/documents/documents_states.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_no_records_text.dart';
import '../documents_list_screen.dart';
import 'documents_list_card.dart';

class DocumentListTile extends StatelessWidget {
  const DocumentListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DocumentsBloc, DocumentsStates>(
        buildWhen: (previousState, currentState) =>
            ((currentState is DocumentsListFetched) ||
                (currentState is FetchingDocumentsList &&
                    DocumentsListScreen.page == 1)) ||
            currentState is DocumentsListError,
        listener: (context, state) {
          if (state is DocumentsListFetched) {
            if (state.documentsListModel.status == 204) {
              showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
            }
          }
        },
        builder: (context, state) {
          if (state is FetchingDocumentsList) {
            return Center(
                child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3.5),
                    child: const CircularProgressIndicator()));
          } else if (state is DocumentsListFetched) {
            if (context.read<DocumentsBloc>().documentsListDatum.isNotEmpty) {
              return Expanded(
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          context.read<DocumentsBloc>().docListReachedMax ==
                                  true
                              ? context
                                  .read<DocumentsBloc>()
                                  .documentsListDatum
                                  .length
                              : context
                                      .read<DocumentsBloc>()
                                      .documentsListDatum
                                      .length +
                                  1,
                      itemBuilder: (context, index) {
                        if (index <
                            context
                                .read<DocumentsBloc>()
                                .documentsListDatum
                                .length) {
                          return DocumentsListCard(
                              documentsListData: context
                                  .read<DocumentsBloc>()
                                  .documentsListDatum[index]);
                        } else if (!context
                            .read<DocumentsBloc>()
                            .docListReachedMax) {
                          DocumentsListScreen.page++;
                          log('dms increment====>${DocumentsListScreen.page}');
                          context.read<DocumentsBloc>().add((GetDocumentsList(
                              page: DocumentsListScreen.page,
                              isFromHome: false)));
                          return const Center(
                              child: Padding(
                                  padding: EdgeInsets.all(
                                      kCircularProgressIndicatorPadding),
                                  child: SizedBox(
                                      width: kCircularProgressIndicatorWidth,
                                      child: CircularProgressIndicator())));
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: xxTinySpacing);
                      }));
            } else if (state.documentsListModel.status == 204 &&
                context.read<DocumentsBloc>().documentsListDatum.isEmpty) {
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
