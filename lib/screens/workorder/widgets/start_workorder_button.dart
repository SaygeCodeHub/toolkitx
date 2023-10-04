import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/primary_button.dart';
import '../start_workorder_screen.dart';

class StartWorkOrderButton extends StatelessWidget {
  const StartWorkOrderButton({Key? key}) : super(key: key);

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
                workOrderId:
                    StartWorkOrderScreen.startWorkOrderMap['workorderId']));
          } else if (state is WorkOderNotStarted) {
            ProgressBar.dismiss(context);
            showCustomSnackBar(context, state.workOrderNotStarted, '');
          }
        },
        child: PrimaryButton(
            onPressed: () {
              context.read<WorkOrderTabDetailsBloc>().add(StartWorkOrder(
                  startWorkOrderMap: StartWorkOrderScreen.startWorkOrderMap));
            },
            textValue: DatabaseUtil.getText('Start')),
      ),
    );
  }
}
