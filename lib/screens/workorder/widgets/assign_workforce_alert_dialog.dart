import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';
import 'assign_workforce_body.dart';

class AssignWorkForceAlertDialog extends StatelessWidget {
  final String warningMessage;

  const AssignWorkForceAlertDialog({Key? key, required this.warningMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        buttonPadding: const EdgeInsets.all(xxTiniestSpacing),
        contentPadding: const EdgeInsets.all(xxTinySpacing),
        actionsPadding: const EdgeInsets.only(right: xxTinySpacing),
        title: const Icon(Icons.error_outline, size: 40),
        content: Text(warningMessage),
        titleTextStyle: Theme.of(context)
            .textTheme
            .medium
            .copyWith(fontWeight: FontWeight.w500),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(DatabaseUtil.getText('No'))),
          TextButton(
              onPressed: () {
                context.read<WorkOrderTabDetailsBloc>().add(AssignWorkForce(
                    assignWorkOrderMap: AssignWorkForceBody.assignWorkForceMap,
                    showWarningCount: '0'));
                Navigator.pop(context);
              },
              child: Text(DatabaseUtil.getText('continue')))
        ]);
  }
}
