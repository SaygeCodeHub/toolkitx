import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../workorder_add_mis_cost_screen.dart';

class WorkOrderMisCostVendorExpansionTile extends StatelessWidget {
  const WorkOrderMisCostVendorExpansionTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<WorkOrderTabDetailsBloc>().add(WorkOrderSelectVendorOption(
        vendorName:
            WorkOrderAddMisCostScreen.workOrderDetailsMap['vendor'] ?? ''));
    return BlocBuilder<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
        buildWhen: (previousState, currentState) =>
            currentState is WorkOrderVendorOptionSelected,
        builder: (context, state) {
          if (state is WorkOrderVendorOptionSelected) {
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    maintainState: true,
                    key: GlobalKey(),
                    title: Text(
                        (state.vendorName.isEmpty)
                            ? StringConstants.kSelectVendor
                            : state.vendorName,
                        style: Theme.of(context).textTheme.xSmall),
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: WorkOrderAddMisCostScreen
                              .workOrderMasterDatum[8].length,
                          itemBuilder: (BuildContext context, int index) {
                            return RadioListTile(
                                contentPadding: const EdgeInsets.only(
                                    left: xxxTinierSpacing),
                                activeColor: AppColor.deepBlue,
                                title: Text(
                                    WorkOrderAddMisCostScreen
                                        .workOrderMasterDatum[8][index].name,
                                    style: Theme.of(context).textTheme.xSmall),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                value: WorkOrderAddMisCostScreen
                                    .workOrderMasterDatum[8][index].name,
                                groupValue: state.vendorName,
                                toggleable: true,
                                onChanged: (_) {
                                  WorkOrderAddMisCostScreen
                                          .workOrderDetailsMap['vendor'] =
                                      WorkOrderAddMisCostScreen
                                          .workOrderMasterDatum[8][index].id
                                          .toString();
                                  context.read<WorkOrderTabDetailsBloc>().add(
                                      WorkOrderSelectVendorOption(
                                          vendorName: WorkOrderAddMisCostScreen
                                              .workOrderMasterDatum[8][index]
                                              .name));
                                });
                          })
                    ]));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}