import 'package:flutter/material.dart';

import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/primary_button.dart';

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
          Expanded(
              child: PrimaryButton(
                  onPressed: () {}, textValue: DatabaseUtil.getText('Save')))
        ],
      ),
    );
  }
}
