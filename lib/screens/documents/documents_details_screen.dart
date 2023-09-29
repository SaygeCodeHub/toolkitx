import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/documents/documents_bloc.dart';
import 'package:toolkit/blocs/documents/documents_events.dart';
import 'package:toolkit/blocs/documents/documents_states.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/utils/documents_util.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../data/models/status_tag_model.dart';
import '../../widgets/custom_tabbar_view.dart';
import '../../widgets/status_tag.dart';

class DocumentsDetailsScreen extends StatelessWidget {
  static const String routeName = 'DocumentsDetailsScreen';

  const DocumentsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<DocumentsBloc>().add(const GetDocumentsDetails());
    return Scaffold(
        appBar: const GenericAppBar(),
        body: BlocConsumer<DocumentsBloc, DocumentsStates>(
            listener: (context, state) {},
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
                                  padding: const EdgeInsets.only(
                                      top: xxTinierSpacing),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(state
                                            .documentDetailsModel.data.name),
                                        StatusTag(tags: [
                                          StatusTagModel(
                                              title: state.documentDetailsModel
                                                  .data.status,
                                              bgColor: AppColor.deepBlue)
                                        ])
                                      ])))),
                      const SizedBox(height: xxTinierSpacing),
                      const Divider(
                          height: kDividerHeight, thickness: kDividerWidth),
                      const SizedBox(height: xxTinierSpacing),
                      CustomTabBarView(
                          lengthOfTabs: 4,
                          tabBarViewIcons: DocumentsUtil().tabBarViewIcons,
                          tabBarViewWidgets: [
                            SizedBox(),
                            SizedBox(),
                            SizedBox(),
                            SizedBox()
                          ])
                    ]));
              } else {
                return const SizedBox();
              }
            }));
  }
}
