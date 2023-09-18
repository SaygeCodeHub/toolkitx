import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../configs/app_dimensions.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/android_pop_up.dart';
import '../../../widgets/custom_icon_button.dart';

class WorkOrderItemTabDeleteButton extends StatelessWidget {
  final String itemId;

  const WorkOrderItemTabDeleteButton({Key? key, required this.itemId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
        icon: Icons.delete,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AndroidPopUp(
                    titleValue: DatabaseUtil.getText('DeleteRecord'),
                    contentValue: '',
                    onPrimaryButton: () {
                      context
                          .read<WorkOrderTabDetailsBloc>()
                          .add(WorkOrderItemTabDeleteItem(itemId: itemId));
                      Navigator.pop(context);
                    });
              });
        },
        size: kEditAndDeleteIconTogether);
  }
}
