import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import '../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/status_tag_model.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/workorder_tabs_util.dart';
import '../../widgets/custom_tabbar_view.dart';
import '../../widgets/error_section.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/status_tag.dart';
import 'widgets/workorder_details_tab_one.dart';
import 'widgets/workorder_tab_two_details.dart';
import 'widgets/workorder_tab_four_details.dart';

class WorkOrderDetailsTabScreen extends StatelessWidget {
  static const routeName = 'WorkOrderDetailsTabScreen';
  final Map workOrderMap;

  const WorkOrderDetailsTabScreen({Key? key, required this.workOrderMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<WorkOrderTabDetailsBloc>().add(WorkOrderDetails(
        initialTabIndex: 0, workOrderId: workOrderMap['workOrderId']));
    return Scaffold(
      appBar: const GenericAppBar(),
      body: BlocBuilder<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
          builder: (context, state) {
        if (state is FetchingWorkOrderTabDetails) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is WorkOrderTabDetailsFetched) {
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(workOrderMap['workOrderName'],
                                      style:
                                          Theme.of(context).textTheme.medium),
                                  StatusTag(tags: [
                                    StatusTagModel(
                                        title: workOrderMap['status'],
                                        bgColor: AppColor.deepBlue)
                                  ])
                                ])))),
                const SizedBox(height: xxTinierSpacing),
                const Divider(height: kDividerHeight, thickness: kDividerWidth),
                CustomTabBarView(
                    lengthOfTabs: 5,
                    tabBarViewIcons: WorkOrderTabsUtil().tabBarViewIcons,
                    initialIndex:
                        context.read<WorkOrderTabDetailsBloc>().tabIndex,
                    tabBarViewWidgets: [
                      WorkOrderDetailsTabOne(
                          tabIndex: 0,
                          data: state.fetchWorkOrderDetailsModel.data),
                      WorkOrderTabTwoDetails(
                          data: state.fetchWorkOrderDetailsModel.data,
                          tabIndex: 1)
                          data: state.fetchWorkOrderDetailsModel.data),
                      WorkOrderTabFourDetails(
                          data: state.fetchWorkOrderDetailsModel.data,
                          tabIndex: 3)
                    ])
              ]));
        } else if (state is WorkOrderTabDetailsNotFetched) {
          return Center(
              child: GenericReloadButton(
                  onPressed: () {
                    context.read<WorkOrderTabDetailsBloc>().add(
                        WorkOrderDetails(
                            workOrderId: workOrderMap['workOrderId'],
                            initialTabIndex: 0));
                  },
                  textValue: StringConstants.kReload));
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }
}
