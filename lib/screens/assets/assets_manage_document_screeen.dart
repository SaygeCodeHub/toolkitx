import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/assets/add_assets_document_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../blocs/assets/assets_bloc.dart';
import 'widgets/assets_manage_document_popup_menu.dart';

class AssetsManageDocumentScreen extends StatelessWidget {
  static const routeName = "AssetsManageDocumentScreen";
  static int pageNo = 1;

  const AssetsManageDocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                currentState is AssetsGetDocumentFetching ||
                currentState is AssetsGetDocumentFetched ||
                currentState is AssetsGetDocumentError,
            builder: (context, state) {
              if (state is AssetsGetDocumentFetching) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AssetsGetDocumentFetched) {
                return Padding(
                    padding: const EdgeInsets.only(
                        left: leftRightMargin,
                        right: leftRightMargin,
                        top: xxTinierSpacing,
                        bottom: leftRightMargin),
                    child: ListView.separated(
                        itemCount:
                            state.fetchAssetsManageDocumentModel.data.length,
                        itemBuilder: (context, index) {
                          return CustomCard(
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: xxxTinierSpacing),
                                  child: ListTile(
                                      title: Row(children: [
                                        Expanded(
                                            child: Text(
                                                state
                                                    .fetchAssetsManageDocumentModel
                                                    .data[index]
                                                    .name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .small
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppColor.black))),
                                        SizedBox(
                                            width: smallerSpacing,
                                            child: AssetsManageDocumentPopUp(
                                              popUpMenuItems:
                                                  state.assetsPopUpMenu,
                                              fetchAssetsManageDocumentModel: state
                                                  .fetchAssetsManageDocumentModel,
                                              documentId: state
                                                  .fetchAssetsManageDocumentModel
                                                  .data[index]
                                                  .docid,
                                            ))
                                      ]),
                                      subtitle: Text(
                                          state.fetchAssetsManageDocumentModel
                                              .data[index].type,
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall
                                              .copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColor.grey)))));
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: tinierSpacing);
                        }));
              } else {
                return const SizedBox.shrink();
              }
            }));
  }
}
