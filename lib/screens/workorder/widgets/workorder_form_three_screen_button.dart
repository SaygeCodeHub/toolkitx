import 'package:flutter/material.dart';

import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/primary_button.dart';
import '../workorder_form_screen_four.dart';

class WorkOrderFormThreeScreenButton extends StatelessWidget {
  final Map workOrderDetailsMap;

  const WorkOrderFormThreeScreenButton(
      {Key? key, required this.workOrderDetailsMap})
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
                  } else {
                    Navigator.pushNamed(
                        context, WorkOrderFormScreenFour.routeName,
                        arguments: workOrderDetailsMap);
                  }
                },
                textValue: DatabaseUtil.getText('nextButtonText')),
          ),
        ],
      ),
    );
  }
}
