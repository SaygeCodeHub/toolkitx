import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/safetyNotice/safety_notice_bloc.dart';
import 'package:toolkit/blocs/safetyNotice/safety_notice_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/error_section.dart';

import '../../blocs/safetyNotice/safety_notice_events.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/status_tag_model.dart';
import '../../utils/safety_notice_tabs_util.dart';
import '../../widgets/custom_tabbar_view.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/status_tag.dart';
import 'widgets/safety_notice_list_card.dart';
import 'widgets/safety_notice_tab_one.dart';

class SafetyNoticeDetailsScreen extends StatelessWidget {
  static const routeName = 'SafetyNoticeDetailsScreen';

  const SafetyNoticeDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SafetyNoticeBloc>().add(FetchSafetyNoticeDetails(
        safetyNoticeId: SafetyNoticeListCard.safetyNoticeId, tabIndex: 0));
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('SafetyNotice')),
        body: BlocBuilder<SafetyNoticeBloc, SafetyNoticeStates>(
          buildWhen: (previousState, currentState) =>
              currentState is FetchingSafetyNoticeDetails ||
              currentState is SafetyNoticeDetailsFetched ||
              currentState is SafetyNoticeDetailsNotFetched,
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
                              clientId: state.clientId)
                        ])
                  ]));
            } else if (state is SafetyNoticeDetailsNotFetched) {
              return GenericReloadButton(
                  onPressed: () {
                    context.read<SafetyNoticeBloc>().add(
                        FetchSafetyNoticeDetails(
                            safetyNoticeId: SafetyNoticeListCard.safetyNoticeId,
                            tabIndex: 0));
                  },
                  textValue: StringConstants.kReload);
            } else {
              return const SizedBox.shrink();
            }
          },
        ));
  }
}
