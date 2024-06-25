import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_text_field.dart';
import '../../widgets/primary_button.dart';
import 'widgets/workorder_docuement_type_list_tile.dart';
import 'widgets/workorder_document_status_expansion_tile.dart';
import 'workorder_assign_document_screen.dart';

class WorkOrderDocumentFilterScreen extends StatelessWidget {
  static const routeName = 'WorkOrderDocumentFilterScreen';

  const WorkOrderDocumentFilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kApplyFilter),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: [
              Expanded(
                child: PrimaryButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    textValue: DatabaseUtil.getText('Close')),
              ),
              const SizedBox(width: xxTinySpacing),
              BlocListener<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
                listener: (context, state) {
                  if (state is WorkOrderDocumentApplyingFilter) {
                    ProgressBar.show(context);
                  } else if (state is WorkOrderDocumentFilterApplied) {
                    ProgressBar.dismiss(context);
                    context
                        .read<WorkOrderTabDetailsBloc>()
                        .add(FetchWorkOrderDocuments());
                    Navigator.pushReplacementNamed(
                        context, WorkOrderAssignDocumentScreen.routeName);
                  } else if (state is WorkOrderDocumentDidNotFilter) {
                    ProgressBar.dismiss(context);
                  }
                },
                child: Expanded(
                    child: PrimaryButton(
                        onPressed: () {
                          context
                              .read<WorkOrderTabDetailsBloc>()
                              .add(ApplyWorkOrderDocumentFilter());
                        },
                        textValue: DatabaseUtil.getText('buttonSave'))),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.only(
                  left: leftRightMargin,
                  right: leftRightMargin,
                  top: xxTinierSpacing),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DatabaseUtil.getText('DocumentName'),
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: xxxTinierSpacing),
                  TextFieldWidget(
                      value: WorkOrderAssignDocumentScreen
                              .documentFilterMap['name'] ??
                          '',
                      maxLength: 70,
                      onTextFieldChanged: (String textValue) {
                        WorkOrderAssignDocumentScreen
                            .documentFilterMap['name'] = textValue;
                      }),
                  const WorkOrderDocumentTypeListTile(),
                  Text(DatabaseUtil.getText('Status'),
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: xxxTinierSpacing),
                  const WorkOrderDocumentStatusExpansionTile(),
                  const SizedBox(height: xxTinySpacing),
                  Text(DatabaseUtil.getText('owner'),
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: xxxTinierSpacing),
                  TextFieldWidget(
                      value: WorkOrderAssignDocumentScreen
                              .documentFilterMap['author'] ??
                          '',
                      maxLength: 70,
                      onTextFieldChanged: (String textValue) {
                        WorkOrderAssignDocumentScreen
                            .documentFilterMap['author'] = textValue;
                      })
                ],
              )),
        ));
  }
}
