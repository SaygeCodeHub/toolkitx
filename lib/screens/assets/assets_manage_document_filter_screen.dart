import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/assets/add_assets_document_screen.dart';
import 'package:toolkit/screens/assets/widgets/assets_document_type_screen.dart';
import '../../blocs/assets/assets_bloc.dart';
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
import '../documents/widgets/document_status_filter.dart';

class AssetsManageDocumentFilterScreen extends StatelessWidget {
  static const routeName = 'AssetsManageDocumentFilterScreen';
  const AssetsManageDocumentFilterScreen({super.key});
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
                    const SizedBox(height: xxTinySpacing),
                    Text(DatabaseUtil.getText('Status'),
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: tiniestSpacing),
                    DocumentStatusFilter(documentFilterMap: documentFilterMap),
                    const SizedBox(height: xxTinySpacing),
                    const AssetsDocumentTypeScreen(),
                    const SizedBox(height: xxTinySpacing),
                    Text(DatabaseUtil.getText('owner'),
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: tiniestSpacing),
                    TextFieldWidget(
                        value: documentFilterMap["owner"] ?? '',
                        onTextFieldChanged: (textField) {
                          documentFilterMap["owner"] = textField;
                        },
                        hintText: "Search by Owner name"),
                  ],
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: PrimaryButton(
            onPressed: () {
              context.read<AssetsBloc>().add(ApplyAssetsDocumentFilter(
                  assetsDocumentFilterMap: documentFilterMap));
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                  context, AddAssetsDocumentScreen.routeName);
            },
            textValue: StringConstants.kApply),
      ),
    );
  }
}
