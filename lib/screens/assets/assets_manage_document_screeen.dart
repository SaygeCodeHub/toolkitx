import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/assets/add_assets_document_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../blocs/assets/assets_bloc.dart';
import '../../utils/database_utils.dart';
import '../../widgets/generic_no_records_text.dart';
import 'widgets/assets_mnage_document_body.dart';

class AssetsManageDocumentScreen extends StatelessWidget {
  static const routeName = "AssetsManageDocumentScreen";
  static int pageNo = 1;

  const AssetsManageDocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context.read<AssetsBloc>().hasDocumentReachedMax = false;
    context.read<AssetsBloc>().manageDocumentDatum.clear();
    context.read<AssetsBloc>().add(FetchAssetsManageDocument(
        assetsId: context.read<AssetsBloc>().assetId, pageNo: pageNo));
    return Scaffold(
        floatingActionButton: Padding(
            padding: const EdgeInsets.all(tinierSpacing),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddAssetsDocumentScreen.routeName);
              },
              child: const Icon(Icons.add),
            )),
        appBar: const GenericAppBar(title: StringConstants.kManageDocuments),
        body: BlocConsumer<AssetsBloc, AssetsState>(
            listener: (context, state) {
              if (state is AssetsGetDocumentFetched &&
                  context.read<AssetsBloc>().hasDocumentReachedMax) {
                showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
              }
              if (state is AssetsDocumentDeleting) {
                ProgressBar.show(context);
              } else if (state is AssetsDocumentDeleted) {
                ProgressBar.dismiss(context);
                Navigator.pop(context);
                Navigator.pushReplacementNamed(
                    context, AssetsManageDocumentScreen.routeName);
              } else if (state is AssetsDocumentNotDeleted) {
                ProgressBar.dismiss(context);
                showCustomSnackBar(context, state.errorMessage, '');
              }
            },
            buildWhen: (previousState, currentState) =>
                (currentState is AssetsGetDocumentFetching && pageNo == 1) ||
                (currentState is AssetsGetDocumentFetched),
            builder: (context, state) {
              if (state is AssetsGetDocumentFetching) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AssetsGetDocumentFetched) {
                if (state.manageDocumentDatum.isNotEmpty) {
                  return Padding(
                      padding: const EdgeInsets.only(
                          left: leftRightMargin,
                          right: leftRightMargin,
                          top: xxTinierSpacing,
                          bottom: leftRightMargin),
                      child: AssetsManageDocumentBody(
                        manageDocumentDatum: state.manageDocumentDatum,
                        assetsPopUpMenu: state.assetsPopUpMenu,
                      ));
                } else {
                  return NoRecordsText(
                      text: DatabaseUtil.getText('no_records_found'));
                }
              } else if (state is AssetsGetDocumentError) {
                return Center(
                  child: NoRecordsText(
                      text: DatabaseUtil.getText('no_records_found')),
                );
              } else {
                return const SizedBox.shrink();
              }
            }));
  }
}


