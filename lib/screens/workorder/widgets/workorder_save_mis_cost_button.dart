import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/primary_button.dart';
import '../workorder_add_mis_cost_screen.dart';

class WorkOrderSaveMisCostButton extends StatelessWidget {
  const WorkOrderSaveMisCostButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
          Expanded(
              child: PrimaryButton(
            onPressed: () {
              Navigator.pop(context);
            },
            textValue: DatabaseUtil.getText('Cancel'),
          )),
          const SizedBox(width: xxTinierSpacing),
          BlocListener<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
            listener: (context, state) {
              if (state is ManagingWorkOrderMisCost) {
                ProgressBar.show(context);
              } else if (state is WorkOrderMisCostManaged) {
                ProgressBar.dismiss(context);
                Navigator.pop(context);
                context.read<WorkOrderTabDetailsBloc>().add(WorkOrderDetails(
                    initialTabIndex: 0,
                    workOrderId: WorkOrderAddMisCostScreen
                        .workOrderDetailsMap['workorderId']));
              } else if (state is WorkOrderMisCostCannotManage) {
                ProgressBar.dismiss(context);
                showCustomSnackBar(context, state.cannotManageMiscCost, '');
              }
            },
            child: Expanded(
              child: PrimaryButton(
                  onPressed: () {
                    context.read<WorkOrderTabDetailsBloc>().add(
                        ManageWorkOrderMiscCost(
                            manageMisCostMap:
                                WorkOrderAddMisCostScreen.workOrderDetailsMap));
                  },
                  textValue: DatabaseUtil.getText('Save')),
            ),
          ),
        ],
      ),
    );
  }
}
