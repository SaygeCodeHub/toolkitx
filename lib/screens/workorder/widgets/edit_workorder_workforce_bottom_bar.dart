import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/progress_bar.dart';

class EditWorkOrderWorkForceBottomBar extends StatelessWidget {
  const EditWorkOrderWorkForceBottomBar(
      {super.key, required this.editWorkOrderWorkForceMap});
  final Map editWorkOrderWorkForceMap;

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
              if (state is EditingWorkOrderWorkForce) {
                ProgressBar.show(context);
              } else if (state is WorkOrderWorkForceEdited) {
                ProgressBar.dismiss(context);
                Navigator.pop(context);
                context.read<WorkOrderTabDetailsBloc>().add(WorkOrderDetails(
                    initialTabIndex: 1,
                    workOrderId:
                        editWorkOrderWorkForceMap['workorderId'] ?? ''));
              } else if (state is WorkOrderWorkForceNotEdited) {
                ProgressBar.dismiss(context);
                showCustomSnackBar(context, state.workForceNotEdited, '');
              }
            },
            child: Expanded(
              child: PrimaryButton(
                  onPressed: () {
                    context.read<WorkOrderTabDetailsBloc>().add(
                        EditWorkOrderWorkForce(
                            editWorkOrderWorkForceMap:
                                editWorkOrderWorkForceMap));
                  },
                  textValue: DatabaseUtil.getText('Save')),
            ),
          ),
        ],
      ),
    );
  }
}
