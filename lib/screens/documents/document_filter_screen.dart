import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/documents/documents_bloc.dart';
import 'package:toolkit/blocs/documents/documents_events.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/documents/widgets/document_location_screen.dart';
import 'package:toolkit/screens/documents/widgets/document_status_filter.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../blocs/documents/documents_states.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_snackbar.dart';
import 'documents_list_screen.dart';

class DocumentFilterScreen extends StatelessWidget {
  static const routeName = "DocumentFilterScreen";

  const DocumentFilterScreen({super.key});

  static Map documentFilterMap = {};

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
                  DatabaseUtil.getText('some_unknown_error_please_try_again'),
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
              documentFilterMap.clear();
              documentFilterMap.addAll(context.read<DocumentsBloc>().filters);
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
                      value: documentFilterMap["documentName"] ?? '',
                        onTextFieldChanged: (textField) {
                          documentFilterMap["documentName"] = textField;
                        },
                        hintText: "Search by Document name"),
                    const SizedBox(height: xxTinySpacing),
                    Text(DatabaseUtil.getText('dms_documentid'),
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: tiniestSpacing),
                    TextFieldWidget(
                      value: documentFilterMap["documentId"] ?? '',
                      onTextFieldChanged: (textField) {
                        documentFilterMap["documentId"] = textField;
                      },
                      hintText: "Search by Document Id",
                    ),
                    const SizedBox(height: xxTinySpacing),
                    Text(DatabaseUtil.getText('Author'),
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: tiniestSpacing),
                    TextFieldWidget(
                      value: documentFilterMap["author"] ?? '',
                      onTextFieldChanged: (textField) {
                        documentFilterMap["author"] = textField;
                      },
                      hintText: "Search by Document Id",
                    ),
                    const SizedBox(height: xxTinySpacing),
                    Text(DatabaseUtil.getText('Status'),
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: tiniestSpacing),
                    DocumentStatusFilter(documentFilterMap: documentFilterMap),
                    const SizedBox(height: xxTinySpacing),
                    DocumentTypeScreen(
                        documentFilterMap: documentFilterMap,
                        locationList: state.fetchDocumentMasterModel.data,
                        isFromLinkDoc: false),
                    const SizedBox(height: xxTinySpacing),
                    PrimaryButton(
                        onPressed: () {
                          context.read<DocumentsBloc>().add(ApplyDocumentFilter(
                              filterMap: documentFilterMap));
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                              context, DocumentsListScreen.routeName,
                              arguments: false);
                        },
                        textValue: StringConstants.kApply),
                  ],
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
