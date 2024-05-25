import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/screens/permit/permit_list_screen.dart';
import 'package:toolkit/screens/permit/widgets/permit_comments.dart';
import 'package:toolkit/utils/constants/api_constants.dart';
import 'package:toolkit/utils/permit_util.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/custom_tabbar_view.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/screens/permit/widgets/permit_additional_info.dart';
import 'package:toolkit/screens/permit/widgets/permit_details.dart';
import 'package:toolkit/screens/permit/widgets/permit_group.dart';
import 'package:toolkit/screens/permit/widgets/permit_attachments.dart';
import 'package:toolkit/screens/permit/widgets/permit_timeline.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../blocs/permit/permit_bloc.dart';
import '../../blocs/permit/permit_events.dart';
import '../../blocs/permit/permit_states.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/status_tag_model.dart';
import '../../utils/database_utils.dart';
import 'widgets/ptw_action_menu.dart';
import '../../widgets/status_tag.dart';

class PermitDetailsScreen extends StatelessWidget {
  final String permitId;
  static const routeName = 'PermitDetailsScreen';

  const PermitDetailsScreen({Key? key, required this.permitId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PermitBloc>().add(GetPermitDetails(permitId: permitId));
    return Scaffold(
        appBar: GenericAppBar(
            onPressed: () {
              PermitListScreen.page = 1;
              context.read<PermitBloc>().permitListData = [];
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                  context, PermitListScreen.routeName,
                  arguments: false);
            },
            actions: [
              BlocBuilder<PermitBloc, PermitStates>(
                  buildWhen: (previousState, currentState) =>
                      currentState is PermitDetailsFetched,
                  builder: (context, state) {
                    if (state is PermitDetailsFetched) {
                      return PTWActionMenu(
                          permitDetailsModel: state.permitDetailsModel,
                          popUpMenuItems: state.permitPopUpMenu,
                          permitId: permitId);
                    } else {
                      return const SizedBox();
                    }
                  })
            ]),
        body: BlocConsumer<PermitBloc, PermitStates>(
            listener: (context, state) {
              if (state is GeneratingPDF) {
                ProgressBar.show(context);
              }
              if (state is PDFGenerated) {
                ProgressBar.dismiss(context);
                launchUrlString(
                    '${ApiConstants.baseDocUrl}${state.pdfLink}.pdf',
                    mode: LaunchMode.externalApplication);
              } else if (state is PDFGenerationFailed) {
                ProgressBar.dismiss(context);
                showCustomSnackBar(
                    context,
                    DatabaseUtil.getText('some_unknown_error_please_try_again'),
                    '');
              }
              if (state is RequestingPermit) {
                ProgressBar.show(context);
              }
              if (state is PermitRequested) {
                ProgressBar.dismiss(context);
                Navigator.pop(context);
                Navigator.pushNamed(context, PermitDetailsScreen.routeName,
                    arguments: permitId);
              }
              if (state is RequestPermitError) {
                ProgressBar.dismiss(context);
                showCustomSnackBar(context, state.errorMessage, '');
              }
              if (state is CouldNotFetchPermitDetails) {
                Navigator.pop(context);
                showCustomSnackBar(
                    context, DatabaseUtil.getText('something_went_wrong'), '');
              }
            },
            buildWhen: (previousState, currentState) =>
                currentState is FetchingPermitDetails ||
                currentState is PermitDetailsFetched,
            builder: (context, state) {
              if (state is FetchingPermitDetails || state is GeneratingPDF) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PermitDetailsFetched) {
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
                                        Text(state.permitDetailsModel.data.tab1
                                            .permit),
                                        StatusTag(tags: [
                                          StatusTagModel(
                                              title: state.permitDetailsModel
                                                  .data.tab1.status,
                                              bgColor: AppColor.deepBlue)
                                        ])
                                      ])),
                              subtitle: StatusTag(tags: [
                                StatusTagModel(
                                    title: (state.permitDetailsModel.data.tab1
                                                .expired ==
                                            '2')
                                        ? DatabaseUtil.getText('Expired')
                                        : '',
                                    bgColor: AppColor.errorRed)
                              ]))),
                      const SizedBox(height: xxTinierSpacing),
                      const Divider(
                          height: kDividerHeight, thickness: kDividerWidth),
                      const SizedBox(height: xxTinierSpacing),
                      CustomTabBarView(
                          lengthOfTabs: 6,
                          tabBarViewIcons: PermitUtil().tabBarViewIcons,
                          tabBarViewWidgets: [
                            PermitDetails(
                                permitDetailsModel: state.permitDetailsModel),
                            PermitAdditionalInfo(
                                permitDetailsModel: state.permitDetailsModel),
                            PermitGroup(
                                permitDetailsModel: state.permitDetailsModel),
                            CustomTimeline(
                                permitDetailsModel: state.permitDetailsModel),
                            PermitAttachments(
                                permitDetailsModel: state.permitDetailsModel,
                                clientId: state.clientId),
                            PermitComments(
                                permitDetailsModel: state.permitDetailsModel)
                          ])
                    ]));
              } else {
                return const SizedBox();
              }
            }));
  }
}
