import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
import 'widgets/document_details_custom_fields.dart';
import 'widgets/document_details_popup_menu.dart';
import 'widgets/documents_details_files.dart';

class DocumentsDetailsScreen extends StatelessWidget {
  static const String routeName = 'DocumentsDetailsScreen';

  const DocumentsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<DocumentsBloc>().add(const GetDocumentsDetails());
    return Scaffold(
        appBar: GenericAppBar(actions: [
          BlocBuilder<DocumentsBloc, DocumentsStates>(
              buildWhen: (previousState, currentState) =>
                  currentState is DocumentsDetailsFetched,
              builder: (context, state) {
                if (state is DocumentsDetailsFetched) {
                  return DocumentsDetailsPopUpMenu(
                      popUpMenuItems: state.documentsPopUpMenu);
                } else {
                  return const SizedBox();
                }
              })
        ]),
        body: BlocConsumer<DocumentsBloc, DocumentsStates>(
            listener: (context, state) {},
            buildWhen: (previousState, currentState) =>
                currentState is FetchingDocumentsDetails ||
                currentState is DocumentsDetailsFetched,
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
                          tabBarViewWidgets: [
                            DocumentDetails(
                                documentDetailsModel:
                                    state.documentDetailsModel),
                            DocumentDetailsFiles(
                                documentDetailsModel:
                                    state.documentDetailsModel),
                            DocumentDetailsCustomFields(
                                documentDetailsModel:
                                    state.documentDetailsModel),
                            const SizedBox(),
                            const SizedBox(),
                            const SizedBox()
                          ])
                    ]));
              } else {
                return const SizedBox();
              }
            }));
  }
}
