import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';
import 'workorder_cost_center_list.dart';

class WorkOrderCostCenterListTile extends StatelessWidget {
  final List data;
  final Map workOrderDetailsMap;

  const WorkOrderCostCenterListTile(
      {Key? key, required this.data, required this.workOrderDetailsMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<WorkOrderTabDetailsBloc>().add(
        SelectWorkOrderCostCenterOptions(
            costCenterId: workOrderDetailsMap['costcenterid'] ?? '',
            costCenterValue: workOrderDetailsMap['costcenter'] ?? ''));
    return BlocBuilder<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
        buildWhen: (previousState, currentState) =>
            currentState is WorkOrderCategoryCostCenterSelected,
        builder: (context, state) {
          if (state is WorkOrderCategoryCostCenterSelected) {
            workOrderDetailsMap['costcenterid'] = state.costCenterId;
            return ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WorkOrderCostCenterList(
                              data: data, costCenterId: state.costCenterId)));
                },
                title: Text(DatabaseUtil.getText('CostCenter'),
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        color: AppColor.black, fontWeight: FontWeight.w600)),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: tiniestSpacing),
                  child: Text(state.costCenterValue,
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(color: AppColor.black)),
                ),
                trailing:
                    const Icon(Icons.navigate_next_rounded, size: kIconSize));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
