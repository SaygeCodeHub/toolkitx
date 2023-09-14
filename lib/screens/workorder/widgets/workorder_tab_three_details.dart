import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/models/workorder/fetch_workorder_details_model.dart';
import 'workorder_tab_three_document_tab.dart';
import 'workorder_tab_three_items_tab.dart';
import 'workorder_tab_three_misc_cost_tab.dart';
import 'workorder_tab_three_show_downtime_tab.dart';

class WorkOrderTabThreeDetails extends StatelessWidget {
  final WorkOrderDetailsData data;
  final int tabIndex;

  const WorkOrderTabThreeDetails(
      {Key? key, required this.data, required this.tabIndex})
      : super(key: key);
  static int toggleIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
        builder: (context, state) {
      if (state is WorkOrderTabDetailsFetched) {
        return Column(children: [
          const SizedBox(height: tinierSpacing),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ToggleSwitch(
                  animate: true,
                  minHeight: MediaQuery.of(context).size.width * 0.093,
                  minWidth: MediaQuery.of(context).size.width * 0.215,
                  initialLabelIndex: toggleIndex,
                  cornerRadius: kSignInToggleCornerRadius,
                  activeFgColor: AppColor.black,
                  inactiveBgColor: AppColor.blueGrey,
                  inactiveFgColor: AppColor.black,
                  totalSwitches: 4,
                  labels: [
                    DatabaseUtil.getText('Documents'),
                    DatabaseUtil.getText('ItemsParts'),
                    DatabaseUtil.getText('MiscCost'),
                    DatabaseUtil.getText('ScheduleDowntime')
                  ],
                  activeBgColors: const [
                    [AppColor.lightBlue],
                    [AppColor.lightBlue],
                    [AppColor.lightBlue],
                    [AppColor.lightBlue]
                  ],
                  onToggle: (index) {
                    toggleIndex = index!;
                    context.read<WorkOrderTabDetailsBloc>().add(
                        WorkOrderToggleSwitchIndex(
                            fetchWorkOrderDetailsModel:
                                state.fetchWorkOrderDetailsModel,
                            tabInitialIndex: tabIndex,
                            toggleIndex: index));
                  }),
            ],
          ),
          const SizedBox(height: xxSmallestSpacing),
          (toggleIndex == 0)
              ? WorkOrderTabThreeDocumentTab(
                  data: data, clientId: state.clientId!)
              : const SizedBox.shrink(),
          (toggleIndex == 1)
              ? WorkOrderTabThreeItemsTab(data: data)
              : const SizedBox.shrink(),
          (toggleIndex == 2)
              ? WorkOrderTabThreeMiscCostTab(data: data)
              : const SizedBox.shrink(),
          (toggleIndex == 3)
              ? WorkOrderTabThreeShowDowntimeTab(data: data)
              : const SizedBox.shrink()
        ]);
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
