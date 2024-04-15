import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../configs/app_spacing.dart';
import '../../widgets/generic_text_field.dart';
import 'widgets/edit_workorder_workforce_bottom_bar.dart';

class WorkOrderEditWorkForceScreen extends StatelessWidget {
  static const routeName = 'WorkOrderEditWorkForceScreen';

  static Map editWorkOrderWorkForceMap = {};

  const WorkOrderEditWorkForceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(
          title: DatabaseUtil.getText('EditWorkForce'),
        ),
        bottomNavigationBar: EditWorkOrderWorkForceBottomBar(
            editWorkOrderWorkForceMap: editWorkOrderWorkForceMap),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinySpacing),
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('${DatabaseUtil.getText('workforce')} :',
                            style: Theme.of(context)
                                .textTheme
                                .xSmall
                                .copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(width: xxxTinierSpacing),
                        Text(
                            WorkOrderEditWorkForceScreen
                                        .editWorkOrderWorkForceMap[
                                    'workForceName'] ??
                                '',
                            style: Theme.of(context).textTheme.xSmall),
                      ],
                    ),
                    const SizedBox(height: xxTinySpacing),
                    Text(DatabaseUtil.getText('PlannedWorkingHours'),
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxxTinierSpacing),
                    TextFieldWidget(
                        value: editWorkOrderWorkForceMap['plannedhrs'] ?? '',
                        maxLength: 4,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.number,
                        onTextFieldChanged: (String textField) {
                          editWorkOrderWorkForceMap['plannedhrs'] = textField;
                        }),
                    const SizedBox(height: xxTinySpacing),
                    Text(DatabaseUtil.getText('ActualWorkingHours'),
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxxTinierSpacing),
                    TextFieldWidget(
                        maxLength: 4,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.number,
                        onTextFieldChanged: (String textField) {
                          editWorkOrderWorkForceMap['actualhrs'] = textField;
                        }),
                    const SizedBox(height: xxTinySpacing)
                  ],
                ))));
  }
}
