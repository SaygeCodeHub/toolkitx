import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/workorder/fetch_assign_workforce_model.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/generic_text_field.dart';
import 'assign_workforce_body.dart';
import 'assign_workforce_status_tags.dart';

class WorkOrderAssignWorkforceCard extends StatelessWidget {
  const WorkOrderAssignWorkforceCard(
      {super.key, required this.index, required this.assignWorkForceDatum});
  final AssignWorkForceDatum assignWorkForceDatum;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            contentPadding: const EdgeInsets.all(tiniestSpacing),
            title: Text(assignWorkForceDatum.name,
                style: Theme.of(context)
                    .textTheme
                    .xSmall
                    .copyWith(fontWeight: FontWeight.w500)),
            subtitle:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: xxTinierSpacing),
              Text(assignWorkForceDatum.jobTitle),
              const SizedBox(height: xxTinierSpacing),
              TextFieldWidget(
                  hintText: DatabaseUtil.getText('PlannedWorkingHours'),
                  onTextFieldChanged: (String textField) {
                    AssignWorkForceBody.assignWorkForceMap['hrs'] = textField;
                  }),
              const SizedBox(height: xxTinierSpacing),
              AssignWorkForceStatusTags(
                  assignWorkForceDatum: assignWorkForceDatum, index: index)
            ])));
  }
}
