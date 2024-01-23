import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../blocs/documents/documents_bloc.dart';
import '../../blocs/documents/documents_events.dart';
import '../../blocs/documents/documents_states.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/status_tag_model.dart';
import '../../utils/documents_util.dart';
import '../../widgets/custom_tabbar_view.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/status_tag.dart';
import 'widgets/document_details.dart';
import 'widgets/document_details_comments.dart';
import 'widgets/document_details_custom_fields.dart';
import 'widgets/document_details_linked_doc.dart';
import 'widgets/document_details_popup_menu.dart';
import 'widgets/document_details_timeline.dart';
import 'widgets/documents_details_files.dart';

class DocumentsDetailsScreen extends StatelessWidget {
  static const String routeName = 'DocumentsDetailsScreen';
  static int defaultIndex = 0;

  const DocumentsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    defaultIndex = 0;
    context.read<DocumentsBloc>().add(const GetDocumentsDetails());
    return Scaffold(
        appBar: GenericAppBar(actions: [
          BlocBuilder<DocumentsBloc, DocumentsStates>(
              buildWhen: (previousState, currentState) =>
                  currentState is DocumentsDetailsFetched,
              builder: (context, state) {
                if (state is DocumentsDetailsFetched) {
                  return DocumentsDetailsPopUpMenu(
                      popUpMenuItems: state.documentsPopUpMenu,
                      documentDetailsModel: state.documentDetailsModel);
                } else {
                  return const SizedBox();
                }
              })
        ]),
        body: BlocConsumer<DocumentsBloc, DocumentsStates>(
            listener: (context, state) {
              if (state is DeletingDocuments) {
                ProgressBar.show(context);
              }
              if (state is DocumentsDeleted) {
                ProgressBar.dismiss(context);
                context.read<DocumentsBloc>().add(const GetDocumentsDetails());
              }
              if (state is DeleteDocumentsError) {
                ProgressBar.dismiss(context);
                showCustomSnackBar(context, state.message, '');
              }
              if (state is OpeningDocumentsForInformation) {
                ProgressBar.show(context);
              }
              if (state is DocumentOpenedForInformation) {
                ProgressBar.dismiss(context);
                context.read<DocumentsBloc>().add(const GetDocumentsDetails());
              }
              if (state is OpenDocumentsForInformationError) {
                ProgressBar.dismiss(context);
                showCustomSnackBar(context, state.message, '');
              }
            },
            buildWhen: (previousState, currentState) =>
                currentState is FetchingDocumentsDetails ||
                currentState is DocumentsDetailsFetched ||
                currentState is DocumentsDetailsError,
            builder: (context, state) {
              if (state is FetchingDocumentsDetails) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DocumentsDetailsFetched) {
                return Padding(
                    padding: const EdgeInsets.only(
                        left: leftRightMargin,
                        right: leftRightMargin,
                        top: xxTinierSpacing),
                    child: Column(children: [
                      Card(
                          color: AppColor.white,
                          elevation: kCardElevation,
                          child: ListTile(
                              title: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: xxTinierSpacing),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: Text(state
                                                .documentDetailsModel
                                                .data
                                                .name)),
                                        StatusTag(tags: [
                                          StatusTagModel(
                                              title: state.documentDetailsModel
                                                  .data.statustext,
                                              bgColor: AppColor.deepBlue)
                                        ])
                                      ])))),
                      const SizedBox(height: xxTinierSpacing),
                      const Divider(
                          height: kDividerHeight, thickness: kDividerWidth),
                      const SizedBox(height: xxTinierSpacing),
                      CustomTabBarView(
                          lengthOfTabs: 6,
                          tabBarViewIcons: DocumentsUtil().tabBarViewIcons,
                          initialIndex: defaultIndex,
                          tabBarViewWidgets: [
                            DocumentDetails(
                                documentDetailsModel:
                                    state.documentDetailsModel),
                            DocumentDetailsFiles(
                                documentDetailsModel:
                                    state.documentDetailsModel,
                                clientId: state.clientId),
                            DocumentDetailsCustomFields(
                                documentDetailsModel:
                                    state.documentDetailsModel),
                            DocumentCustomTimeline(
                                documentDetailsModel:
                                    state.documentDetailsModel),
                            DocumentDetailsComments(
                                documentDetailsModel:
                                    state.documentDetailsModel,
                                clientId: state.clientId),
                            DocumentDetailsLinkedDocs(
                                documentDetailsModel:
                                    state.documentDetailsModel)
                          ])
                    ]));
              } else {
                return const SizedBox();
              }
            }));
  }
}
