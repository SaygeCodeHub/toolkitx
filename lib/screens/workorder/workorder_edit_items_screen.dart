import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/generic_text_field.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/progress_bar.dart';

class WorkOrderEditItemsScreen extends StatelessWidget {
  const WorkOrderEditItemsScreen({
    super.key,
    required this.workOrderItemMap,
  });

  static const routeName = 'WorkOrderEditItemsScreen';

  final Map workOrderItemMap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('EditWorkOrderItem')),
      body: Padding(
          padding: const EdgeInsets.only(
              left: xxxTinierSpacing,
              right: xxxTinierSpacing,
              top: xxTinierSpacing,
              bottom: tinierSpacing),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(workOrderItemMap['item'],
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.black)),
            const SizedBox(height: xxxSmallestSpacing),
            Text(DatabaseUtil.getText('PlannedQuantity'),
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.mediumBlack)),
            const SizedBox(height: tinierSpacing),
            TextFieldWidget(
                value: workOrderItemMap['plannedquan'].toString(),
                textInputType: TextInputType.number,
                onTextFieldChanged: (textField) {
                  workOrderItemMap['plannedquan'] = textField;
                }),
            Visibility(
              visible: (workOrderItemMap['status'] ==
                      DatabaseUtil.getText('Accepted') ||
                  workOrderItemMap['status'] ==
                      DatabaseUtil.getText('Started')),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: xxxSmallestSpacing),
                  Text(DatabaseUtil.getText('ActualQuantity'),
                      style: Theme.of(context).textTheme.xSmall.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColor.mediumBlack)),
                  const SizedBox(height: tinierSpacing),
                  TextFieldWidget(
                      value: workOrderItemMap['actualquan'].toString() == 'null'
                          ? ''
                          : workOrderItemMap['actualquan'].toString(),
                      textInputType: TextInputType.number,
                      onTextFieldChanged: (textField) {
                        workOrderItemMap['actualquan'] = textField;
                      }),
                ],
              ),
            )
          ])),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: BlocListener<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
          listener: (context, state) {
            if (state is WorkOrderItemUpdating) {
              ProgressBar.show(context);
            } else if (state is WorkOrderItemUpdated) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
              context.read<WorkOrderTabDetailsBloc>().add(WorkOrderDetails(
                  initialTabIndex: 2,
                  workOrderId:
                      context.read<WorkOrderTabDetailsBloc>().workOrderId));
            } else if (state is WorkOrderItemNotUpdated) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.errorMessage, '');
            }
          },
          child: PrimaryButton(
              onPressed: () {
                context.read<WorkOrderTabDetailsBloc>().add(
                    UpdateWorkOrderItem(workOrderItemMap: workOrderItemMap));
              },
              textValue: DatabaseUtil.getText('buttonSave')),
        ),
      ),
    );
  }
}
