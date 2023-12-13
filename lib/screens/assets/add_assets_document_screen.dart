import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/assets/assets_manage_document_filter_screen.dart';
import 'package:toolkit/screens/assets/assets_manage_document_screeen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../blocs/assets/assets_bloc.dart';
import '../../widgets/custom_icon_button_row.dart';
import 'widgets/add_assets_document_screen.dart';

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
                      Navigator.pushNamed(
                          context, AssetsManageDocumentFilterScreen.routeName);
                    },
                    secondaryOnPress: () {},
                    secondaryVisible: false,
                    clearVisible: state.documentFilterMap.isNotEmpty &&
                        isFromHome != true,
                    clearOnPress: () {
                      pageNo = 1;
                      context.read<AssetsBloc>().hasDocumentReachedMax = false;
                      context.read<AssetsBloc>().addDocumentDatum.clear();
                      context
                          .read<AssetsBloc>()
                          .add(ClearAssetsDocumentFilter());
                      context.read<AssetsBloc>().add(FetchAddAssetsDocument(
                          pageNo: 1, isFromHome: isFromHome));
                    });
              } else {
                return const SizedBox();
              }
            }),
            AddAssetsDocumentBody(pageNo: pageNo)
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxxTinySpacing),
        child: BlocListener<AssetsBloc, AssetsState>(
            listener: (context, state) {
              if (state is ManageDocumentAdding) {
                ProgressBar.show(context);
              } else if (state is ManageDocumentAdded) {
                ProgressBar.dismiss(context);
                Navigator.pop(context);
                Navigator.pushReplacementNamed(
                    context, AssetsManageDocumentScreen.routeName);
              } else if (state is ManageDocumentNotAdded) {
                ProgressBar.dismiss(context);
                showCustomSnackBar(context, state.errorMessage, '');
              }
            },
            child: PrimaryButton(
                onPressed: () {
                  context
                      .read<AssetsBloc>()
                      .add(AddManageDocument(addDocumentMap: addDocumentApp));
                },
                textValue: StringConstants.kDone)),
      ),
    );
  }
}
