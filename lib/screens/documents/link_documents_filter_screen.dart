import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../blocs/documents/documents_bloc.dart';
import '../../blocs/documents/documents_events.dart';
import '../../blocs/documents/documents_states.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_text_field.dart';
import '../../widgets/primary_button.dart';
import 'link_document_screen.dart';
import 'widgets/document_location_screen.dart';
import 'widgets/document_status_filter.dart';

class LinkDocumentsFilterScreen extends StatelessWidget {
  static const routeName = 'LinkDocumentsFilterScreen';

  const LinkDocumentsFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<DocumentsBloc>().add(FetchDocumentMaster());
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('Filters')),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomPadding),
            child: BlocConsumer<DocumentsBloc, DocumentsStates>(
                listener: (context, state) {
                  if (state is DocumentMasterError) {
                    Navigator.pop(context);
                    showCustomSnackBar(
                        context,
                        DatabaseUtil.getText(
                            'some_unknown_error_please_try_again'),
                        '');
                  }
                },
                buildWhen: (previousState, currentState) =>
                    currentState is FetchingDocumentMaster ||
                    currentState is DocumentMasterFetched ||
                    currentState is DocumentMasterError,
                builder: (context, state) {
                  if (state is FetchingDocumentMaster) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is DocumentMasterFetched) {
                    return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(DatabaseUtil.getText('DocumentName'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(fontWeight: FontWeight.w600)),
                              const SizedBox(height: tiniestSpacing),
                              TextFieldWidget(
                                  value: context
                                          .read<DocumentsBloc>()
                                          .linkDocFilters["name"] ??
                                      '',
                                  onTextFieldChanged: (textField) {
                                    context
                                        .read<DocumentsBloc>()
                                        .linkDocFilters["name"] = textField;
                                  },
                                  hintText: "Search by Document name"),
                              const SizedBox(height: xxTinySpacing),
                              Text(DatabaseUtil.getText('Status'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(fontWeight: FontWeight.w600)),
                              const SizedBox(height: tiniestSpacing),
                              DocumentStatusFilter(
                                  documentFilterMap: context
                                      .read<DocumentsBloc>()
                                      .linkDocFilters),
                              const SizedBox(height: xxTinySpacing),
                              DocumentTypeScreen(
                                  documentFilterMap: context
                                      .read<DocumentsBloc>()
                                      .linkDocFilters,
                                  locationList:
                                      state.fetchDocumentMasterModel.data,
                                  isFromLinkDoc: true),
                              const SizedBox(height: xxTinySpacing),
                              PrimaryButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    LinkDocumentScreen.page = 1;
                                    context
                                        .read<DocumentsBloc>()
                                        .documentsToLinkList = [];
                                    context
                                        .read<DocumentsBloc>()
                                        .add(const GetDocumentsToLink(page: 1));
                                  },
                                  textValue: StringConstants.kApply)
                            ]));
                  } else {
                    return const SizedBox.shrink();
                  }
                })));
  }
}
