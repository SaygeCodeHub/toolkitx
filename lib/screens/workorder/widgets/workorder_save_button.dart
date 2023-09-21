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
import '../workorder_details_tab_screen.dart';
import '../workorder_form_one_screen.dart';
import '../workorder_form_screen_four.dart';
import '../workorder_list_screen.dart';

class WorkOrderSaveButton extends StatelessWidget {
  final Map workOrderDetailsMap;

  const WorkOrderSaveButton({Key? key, required this.workOrderDetailsMap})
      : super(key: key);

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
            textValue: DatabaseUtil.getText('buttonBack'),
          )),
          const SizedBox(width: xxTinierSpacing),
          BlocListener<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
              listener: (context, state) {
                if (state is SavingNewAndSimilarWorkOrder) {
                  ProgressBar.show(context);
                } else if (state is NewAndSimilarWorkOrderSaved) {
                  if (WorkOrderFormScreenOne.isSimilarWorkOrder == true) {
                    ProgressBar.dismiss(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    context.read<WorkOrderTabDetailsBloc>().add(
                        WorkOrderDetails(
                            initialTabIndex: 0,
                            workOrderId: WorkOrderDetailsTabScreen
                                .workOrderMap['workOrderId']));
                  } else {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pushNamed(context, WorkOrderListScreen.routeName,
                        arguments: false);
                  }
                } else if (state is NewAndSimilarWorkOrderNotSaved) {
                  ProgressBar.dismiss(context);
                  showCustomSnackBar(context, state.workOrderNotSaved, '');
                }
              },
              child: Expanded(
                  child: PrimaryButton(
                      onPressed: () {
                        workOrderDetailsMap['customfields'] =
                            WorkOrderFormScreenFour.customFieldList;
                        context.read<WorkOrderTabDetailsBloc>().add(
                            SaveSimilarAndNewWorkOrder(
                                workOrderDetailsMap: workOrderDetailsMap));
                      },
                      textValue: DatabaseUtil.getText('Save')))),
        ],
      ),
    );
  }
}
