import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/global.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/primary_button.dart';
import '../start_and_complete_workorder_screen.dart';
import 'offline/workorder_sap_model.dart';
import 'offline/workorder_sign_as_user_screen.dart';

class StartWorkOrderButton extends StatelessWidget {
  const StartWorkOrderButton({super.key, required this.isFromStart});

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
              if (isNetworkEstablished) {
                (isFromStart == true)
                    ? context.read<WorkOrderTabDetailsBloc>().add(
                        StartWorkOrder(
                            startWorkOrderMap: StartAndCompleteWorkOrderScreen
                                .startAndCompleteWorkOrderMap))
                    : context.read<WorkOrderTabDetailsBloc>().add(
                        CompleteWorkOrder(
                            completeWorkOrderMap:
                                StartAndCompleteWorkOrderScreen
                                    .startAndCompleteWorkOrderMap));
              } else {
                if (StartAndCompleteWorkOrderScreen
                            .startAndCompleteWorkOrderMap['date'] ==
                        null ||
                    StartAndCompleteWorkOrderScreen
                            .startAndCompleteWorkOrderMap['date'] ==
                        '' ||
                    StartAndCompleteWorkOrderScreen
                            .startAndCompleteWorkOrderMap['time'] ==
                        null ||
                    StartAndCompleteWorkOrderScreen
                            .startAndCompleteWorkOrderMap['time'] ==
                        '') {
                  showCustomSnackBar(context, StringConstants.kAddDateTime, '');
                } else {
                  Navigator.pushNamed(
                    context,
                    WorkOrderSignAsUserScreen.routeName,
                    arguments: WorkOrderSapModel(
                        sapMap: StartAndCompleteWorkOrderScreen
                            .startAndCompleteWorkOrderMap,
                        previousScreen:
                            (isFromStart) ? 'StartScreen' : 'CompleteScreen'),
                  );
                }
              }
            },
            textValue: (isFromStart == true)
                ? DatabaseUtil.getText('Start')
                : DatabaseUtil.getText('Complete')),
      ),
    );
  }
}
