import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/primary_button.dart';
import '../workorder_form_screen_two.dart';

class WorkOrderFormOneButton extends StatelessWidget {
  final Map workOrderDetailsMap;

  const WorkOrderFormOneButton({super.key, required this.workOrderDetailsMap});

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
                  if (workOrderDetailsMap['companyid'] == null ||
                      workOrderDetailsMap['companyid'].isEmpty) {
                    showCustomSnackBar(
                        context, DatabaseUtil.getText('SelectCompany'), '');
                  } else if ((workOrderDetailsMap['plannedstartdate'] != null ||
                          workOrderDetailsMap['plannedfinishdate'] != null)
                      ? DateFormat('dd.MM.yyyy')
                              .parse(workOrderDetailsMap['plannedstartdate'])
                              .compareTo(DateFormat('dd.MM.yyyy').parse(
                                  workOrderDetailsMap['plannedfinishdate'])) >
                          0
                      : false) {
                    showCustomSnackBar(
                        context, StringConstants.kPlannedDateValidation, '');
                  } else {
                    Navigator.pushNamed(
                        context, WorkOrderFormScreenTwo.routeName,
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
