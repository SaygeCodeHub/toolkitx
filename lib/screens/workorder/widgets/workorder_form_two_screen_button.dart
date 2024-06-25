import 'package:flutter/material.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/primary_button.dart';
import '../workorder_form_screen_three.dart';

class WorkOrderFormTwoScreenButton extends StatelessWidget {
  final Map workOrderDetailsMap;

  const WorkOrderFormTwoScreenButton(
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
                  if (workOrderDetailsMap['type'] == null ||
                      workOrderDetailsMap['type'].isEmpty) {
                    showCustomSnackBar(
                        context, StringConstants.kSelectTypeValidation, '');
                  } else {
                    Navigator.pushNamed(
                        context, WorkOrderFormScreenThree.routeName,
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
