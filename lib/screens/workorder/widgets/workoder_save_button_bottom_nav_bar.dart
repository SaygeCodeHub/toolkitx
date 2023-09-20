import 'package:flutter/material.dart';

import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/primary_button.dart';

class WorkOrderSaveButtonBottomNavBar extends StatelessWidget {
  final Map workOrderDetailsMap;
  final bool? isSaveVisible;

  const WorkOrderSaveButtonBottomNavBar(
      {Key? key, required this.workOrderDetailsMap, this.isSaveVisible = false})
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
                onPressed: () {
                  if (workOrderDetailsMap['subject'] == null ||
                      workOrderDetailsMap['subject'].isEmpty ||
                      workOrderDetailsMap['description'] == null ||
                      workOrderDetailsMap['description'].isEmpty) {
                    showCustomSnackBar(
                        context,
                        DatabaseUtil.getText('SubjectDescriptionMandatory'),
                        '');
                  }
                },
                textValue: (isSaveVisible == true)
                    ? DatabaseUtil.getText('Save')
                    : DatabaseUtil.getText('nextButtonText')),
          ),
        ],
      ),
    );
  }
}
