
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/assets/assets_manage_document_filter_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../blocs/assets/assets_bloc.dart';
import '../../widgets/custom_icon_button_row.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_no_records_text.dart';
import 'widgets/assets_add_document_list_body.dart';

class AddAssetsDocumentScreen extends StatelessWidget {
  static const routeName = 'AddAssetsDocumentScreen';
  static List selectedCreatedForIdList = [];
  static Map addDocumentApp = {};
  final bool isFromHome;
  static int pageNo = 1;

  const AddAssetsDocumentScreen({super.key, this.isFromHome = false});

  @override
  Widget build(BuildContext context) {
    selectedCreatedForIdList.clear();
    pageNo = 1;
    context.read<AssetsBloc>().hasDocumentReachedMax = false;
    context.read<AssetsBloc>().addDocumentDatum.clear();
    context
        .read<AssetsBloc>()
        .add(FetchAddAssetsDocument(pageNo: pageNo, isFromHome: isFromHome));
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('AddDocuments')),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing,
            bottom: leftRightMargin),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlocBuilder<AssetsBloc, AssetsState>(
                    buildWhen: (previousState, currentState) {
                  if (currentState is AddAssetsDocumentFetching &&
                      isFromHome == true) {
                    return true;
                  } else if (currentState is AddAssetsDocumentFetched) {
                    return true;
                  }
                  return false;
                }, builder: (context, state) {
                  if (state is AddAssetsDocumentFetched) {
                    return CustomIconButtonRow(
                        primaryOnPress: () {
                          Navigator.pushNamed(context,
                              AssetsManageDocumentFilterScreen.routeName);
                        },
                        secondaryOnPress: () {},
                        secondaryVisible: false,
                        clearVisible: state.documentFilterMap.isNotEmpty &&
                            isFromHome != true,
                        clearOnPress: () {
                          pageNo = 1;
                          context.read<AssetsBloc>().hasDocumentReachedMax =
                              false;
                          context.read<AssetsBloc>().addDocumentDatum.clear();
                          context.read<AssetsBloc>().add(ClearAssetsDocumentFilter());
                          context.read<AssetsBloc>().add(FetchAddAssetsDocument(
                              pageNo: 1, isFromHome: isFromHome));
                        });
                  } else {
                    return const SizedBox();
                  }
                }),
              ],
            ),
            Expanded(
              child: BlocConsumer<AssetsBloc, AssetsState>(
                buildWhen: (previousState, currentState) =>
                    (currentState is AddAssetsDocumentFetching &&
                        AddAssetsDocumentScreen.pageNo == 1) ||
                    currentState is AddAssetsDocumentFetched,
                listener: (context, state) {
                  if (state is AddAssetsDocumentFetched) {
                    if (state.fetchAddAssetsDocumentModel.status == 204 &&
                        context
                            .read<AssetsBloc>()
                            .addDocumentDatum
                            .isNotEmpty) {
                      showCustomSnackBar(
                          context, StringConstants.kAllDataLoaded, '');
                    }
                  }
                },
                builder: (context, state) {
                  if (state is AddAssetsDocumentFetching) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AddAssetsDocumentFetched) {
                    if (context
                        .read<AssetsBloc>()
                        .addDocumentDatum
                        .isNotEmpty) {
                      return AssetsAddDocumentListBody(data: state.data,);
                    } else if (state.fetchAddAssetsDocumentModel.status ==
                            204 &&
                        context.read<AssetsBloc>().addDocumentDatum.isEmpty) {
                      if (context
                          .read<AssetsBloc>()
                          .documentFilters
                          .isNotEmpty) {
                        return const NoRecordsText(
                            text: StringConstants.kNoRecordsFilter);
                      } else {
                        return NoRecordsText(
                            text: DatabaseUtil.getText('no_records_found'));
                      }
                    }
                  }else if(state is AddAssetsDocumentNotFetched){
                    return NoRecordsText(
                        text: DatabaseUtil.getText('no_records_found'));
                  }
                  return const SizedBox.shrink();
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxxTinySpacing),
        child: Row(
          children: [
            Expanded(
                child: PrimaryButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    textValue: DatabaseUtil.getText('buttonBack'))),
            const SizedBox(
              width: xxTinierSpacing,
            ),
            Expanded(
              child: PrimaryButton(
                  onPressed: () {}, textValue: StringConstants.kDone),
            )
          ],
        ),
      ),
    );
  }
}
