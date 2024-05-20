import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/safetyNotice/safety_notice_bloc.dart';
import 'package:toolkit/blocs/safetyNotice/safety_notice_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/error_section.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../blocs/safetyNotice/safety_notice_events.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/status_tag_model.dart';
import '../../utils/safety_notice_tabs_util.dart';
import '../../widgets/custom_tabbar_view.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/status_tag.dart';
import 'safety_notice_pop_up_menu_screen.dart';
import 'safety_notice_screen.dart';
import 'widgets/safety_notice_details_tab_two.dart';
import 'widgets/safety_notice_tab_one.dart';

class SafetyNoticeDetailsScreen extends StatelessWidget {
  static const routeName = 'SafetyNoticeDetailsScreen';
  final String safetyNoticeId;

  const SafetyNoticeDetailsScreen({Key? key, required this.safetyNoticeId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SafetyNoticeBloc>().add(
        FetchSafetyNoticeDetails(safetyNoticeId: safetyNoticeId, tabIndex: 0));
    return Scaffold(
        appBar: GenericAppBar(
          title: DatabaseUtil.getText('SafetyNotice'),
          actions: [
            BlocBuilder<SafetyNoticeBloc, SafetyNoticeStates>(
                buildWhen: (previousState, currentState) =>
                    currentState is SafetyNoticeDetailsFetched,
                builder: (context, state) {
                  if (state is SafetyNoticeDetailsFetched) {
                    SafetyNoticePopUpMenuScreen.safetyNoticeDetailsMap =
                        state.safetyNoticeDetailsMap;
                    return SafetyNoticePopUpMenuScreen(
                        popUpMenuOptionsList: state.popUpMenuOptionsList);
                  } else {
                    return const SizedBox.shrink();
                  }
                })
          ],
        ),
        body: BlocConsumer<SafetyNoticeBloc, SafetyNoticeStates>(
          buildWhen: (previousState, currentState) =>
              currentState is FetchingSafetyNoticeDetails ||
              currentState is SafetyNoticeDetailsFetched ||
              currentState is SafetyNoticeDetailsNotFetched,
          listener: (context, state) {
            if (state is IssuingSafetyNotice) {
              ProgressBar.show(context);
            } else if (state is SafetyNoticeIssued) {
              ProgressBar.dismiss(context);
              context.read<SafetyNoticeBloc>().add(FetchSafetyNoticeDetails(
                  safetyNoticeId: safetyNoticeId, tabIndex: 0));
            } else if (state is SafetyNoticeFailedToIssue) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.noticeNotIssued, '');
            }
            if (state is PuttingSafetyNoticeOnHold) {
              ProgressBar.show(context);
            } else if (state is SafetyNoticeOnHold) {
              ProgressBar.dismiss(context);
              context.read<SafetyNoticeBloc>().add(FetchSafetyNoticeDetails(
                  safetyNoticeId: safetyNoticeId, tabIndex: 0));
            } else if (state is SafetyNoticeNotOnHold) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.noticeNotOnHold, '');
            }
            if (state is CancellingSafetyNotice) {
              ProgressBar.show(context);
            } else if (state is SafetyNoticeCancelled) {
              ProgressBar.dismiss(context);
              context.read<SafetyNoticeBloc>().add(FetchSafetyNoticeDetails(
                  safetyNoticeId: safetyNoticeId, tabIndex: 0));
            } else if (state is SafetyNoticeNotCancelled) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.noticeNotCancelled, '');
            }
            if (state is ClosingSafetyNotice) {
              ProgressBar.show(context);
            } else if (state is SafetyNoticeClosed) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                  context, SafetyNoticeScreen.routeName,
                  arguments: false);
            } else if (state is SafetyNoticeNotClosed) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.noticeNotClosed, '');
            }

            if (state is ReIssuingSafetyNotice) {
              ProgressBar.show(context);
            } else if (state is SafetyNoticeReIssued) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                  context, SafetyNoticeScreen.routeName,
                  arguments: false);
            } else if (state is SafetyNoticeFailedToReIssue) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.noticeNotReIssued, '');
            }
          },
          builder: (context, state) {
            if (state is FetchingSafetyNoticeDetails) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SafetyNoticeDetailsFetched) {
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
                                padding:
                                    const EdgeInsets.only(top: xxTinierSpacing),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          state.fetchSafetyNoticeDetailsModel
                                              .data.refno,
                                          style: Theme.of(context)
                                              .textTheme
                                              .medium),
                                      StatusTag(tags: [
                                        StatusTagModel(
                                            title: state
                                                .fetchSafetyNoticeDetailsModel
                                                .data
                                                .statusText,
                                            bgColor: AppColor.deepBlue)
                                      ])
                                    ])))),
                    const SizedBox(height: xxTinierSpacing),
                    const Divider(
                        height: kDividerHeight, thickness: kDividerWidth),
                    CustomTabBarView(
                        lengthOfTabs: 2,
                        tabBarViewIcons: SafetyNoticeTabsUtil().tabBarViewIcons,
                        initialIndex: context
                            .read<SafetyNoticeBloc>()
                            .safetyNoticeTabIndex,
                        tabBarViewWidgets: [
                          SafetyNoticeTabOne(
                              tabIndex: 0,
                              safetyNoticeData:
                                  state.fetchSafetyNoticeDetailsModel.data,
                              clientId: state.clientId),
                          SafetyNoticeDetailsTabTwo(
                              tabIndex: 1,
                              safetyNoticeData:
                                  state.fetchSafetyNoticeDetailsModel.data)
                        ])
                  ]));
            } else if (state is SafetyNoticeDetailsNotFetched) {
              return GenericReloadButton(
                  onPressed: () {
                    context.read<SafetyNoticeBloc>().add(
                        FetchSafetyNoticeDetails(
                            safetyNoticeId: safetyNoticeId, tabIndex: 0));
                  },
                  textValue: StringConstants.kReload);
            } else {
              return const SizedBox.shrink();
            }
          },
        ));
  }
}
