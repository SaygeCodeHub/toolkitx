import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/primary_button.dart';
import '../start_and_complete_workorder_screen.dart';

class StartWorkOrderButton extends StatelessWidget {
  const StartWorkOrderButton({Key? key, required this.isFromStart})
      : super(key: key);
  final bool isFromStart;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: BlocListener<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
        listener: (context, state) {
          if (state is StartingWorkOder) {
            ProgressBar.show(context);
          } else if (state is WorkOderStarted) {
            ProgressBar.dismiss(context);
            Navigator.pop(context);
            context.read<WorkOrderTabDetailsBloc>().add(WorkOrderDetails(
                initialTabIndex: 0,
                workOrderId: StartAndCompleteWorkOrderScreen
                    .startAndCompleteWorkOrderMap['workorderId']));
          } else if (state is WorkOderNotStarted) {
            ProgressBar.dismiss(context);
            showCustomSnackBar(context, state.workOrderNotStarted, '');
          }
          if (state is WorkOrderCompleting) {
            ProgressBar.show(context);
          } else if (state is WorkOrderCompleted) {
            ProgressBar.dismiss(context);
            Navigator.pop(context);
            context.read<WorkOrderTabDetailsBloc>().add(WorkOrderDetails(
                initialTabIndex: 0,
                workOrderId: StartAndCompleteWorkOrderScreen
                    .startAndCompleteWorkOrderMap['workorderId']));
          } else if (state is WorkOrderNotCompleted) {
            ProgressBar.dismiss(context);
            showCustomSnackBar(context, state.errorMessage, '');
          }
        },
        child: PrimaryButton(
            onPressed: () {
              isFromStart == true
                  ? context.read<WorkOrderTabDetailsBloc>().add(StartWorkOrder(
                      startWorkOrderMap: StartAndCompleteWorkOrderScreen
                          .startAndCompleteWorkOrderMap))
                  : context.read<WorkOrderTabDetailsBloc>().add(
                      CompleteWorkOrder(
                          completeWorkOrderMap: StartAndCompleteWorkOrderScreen
                              .startAndCompleteWorkOrderMap));
            },
            textValue: isFromStart == true
                ? DatabaseUtil.getText('Start')
                : DatabaseUtil.getText('Complete')),
      ),
    );
  }
}
