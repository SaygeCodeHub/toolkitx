import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/error_section.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../blocs/qualityManagement/qm_events.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/status_tag_model.dart';
import '../../utils/quality_management_util.dart';
import '../../widgets/custom_tabbar_view.dart';
import '../../widgets/status_tag.dart';
import 'qm_pop_up_menu_screen.dart';
import 'widgets/qm_comments.dart';
import 'widgets/qm_custom_fields.dart';
import 'widgets/qm_custom_timeline.dart';
import 'widgets/qm_details.dart';

class QualityManagementDetailsScreen extends StatelessWidget {
  static const routeName = 'QualityManagementDetailsScreen';
  final Map qmListMap;

  const QualityManagementDetailsScreen({Key? key, required this.qmListMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<QualityManagementBloc>().add(
        FetchQualityManagementDetails(qmId: qmListMap['id'], initialIndex: 0));
    return Scaffold(
      appBar: GenericAppBar(
        actions: [
          BlocBuilder<QualityManagementBloc, QualityManagementStates>(
              builder: (context, state) {
            if (state is QualityManagementDetailsFetched) {
              if (state.showPopUpMenu == true) {
                return QualityManagementPopUpMenuScreen(
                    popUpMenuItems: state.qmPopUpMenu,
                    data: state.fetchQualityManagementDetailsModel.data,
                    fetchQualityManagementDetailsModel:
                        state.fetchQualityManagementDetailsModel);
              } else {
                return const SizedBox.shrink();
              }
            } else {
              return const SizedBox.shrink();
            }
          })
        ],
      ),
      body: BlocBuilder<QualityManagementBloc, QualityManagementStates>(
          buildWhen: (previousState, currentState) =>
              currentState is FetchingQualityManagementDetails ||
              currentState is QualityManagementDetailsFetched ||
              currentState is QualityManagementDetailsNotFetched,
          builder: (context, state) {
            if (state is FetchingQualityManagementDetails) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is QualityManagementDetailsFetched) {
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
                                      Text(qmListMap['refNo'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .medium),
                                      StatusTag(tags: [
                                        StatusTagModel(
                                            title: qmListMap['status'],
                                            bgColor: AppColor.deepBlue)
                                      ])
                                    ])))),
                    const SizedBox(height: xxTinierSpacing),
                    const Divider(
                        height: kDividerHeight, thickness: kDividerWidth),
                    CustomTabBarView(
                        lengthOfTabs: 4,
                        tabBarViewIcons:
                            QualityManagementUtil().tabBarViewIcons,
                        initialIndex: context
                            .read<QualityManagementBloc>()
                            .incidentTabIndex,
                        tabBarViewWidgets: [
                          QualityManagementDetails(
                              data:
                                  state.fetchQualityManagementDetailsModel.data,
                              initialIndex: 0,
                              clientId: state.clientId),
                          QualityManagementCustomFields(
                            data: state.fetchQualityManagementDetailsModel.data,
                            initialIndex: 1,
                          ),
                          QualityManagementComment(
                              data:
                                  state.fetchQualityManagementDetailsModel.data,
                              initialIndex: 2,
                              clientId: state.clientId),
                          QualityManagementCustomTimeline(
                              data:
                                  state.fetchQualityManagementDetailsModel.data,
                              initialIndex: 3)
                        ])
                  ]));
            } else if (state is QualityManagementDetailsNotFetched) {
              return GenericReloadButton(
                  onPressed: () {
                    context.read<QualityManagementBloc>().add(
                        FetchQualityManagementDetails(
                            qmId: qmListMap['id'], initialIndex: 0));
                  },
                  textValue: StringConstants.kReload);
            } else {
              return const SizedBox.shrink();
            }
          }),
    );
  }
}
