import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/android_pop_up.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/progress_bar.dart';
import '../workorder_assign_document_screen.dart';

class WorkOrderAssignDocumentsBottomAppBar extends StatelessWidget {
  const WorkOrderAssignDocumentsBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: BlocListener<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
        listener: (context, state) {
          if (state is SavingWorkOrderDocuments) {
            ProgressBar.show(context);
          } else if (state is WorkOrderDocumentsSaved) {
            ProgressBar.dismiss(context);
            Navigator.pop(context);
            context.read<WorkOrderTabDetailsBloc>().add(WorkOrderDetails(
                initialTabIndex: 0,
                workOrderId:
                    context.read<WorkOrderTabDetailsBloc>().workOrderId));
          } else if (state is WorkOrderDocumentsNotSaved) {
            ProgressBar.dismiss(context);
            showCustomSnackBar(context, state.documentsNotSaved, '');
          }
        },
        child: PrimaryButton(
            onPressed: () {
              if (WorkOrderAssignDocumentScreen
                          .workOrderDocumentMap['documents'] ==
                      null ||
                  WorkOrderAssignDocumentScreen
                      .workOrderDocumentMap['documents'].isEmpty) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AndroidPopUp(
                          titleValue: StringConstants.kAlert,
                          isNoVisible: false,
                          contentValue:
                              DatabaseUtil.getText('PleaseSelectDocuments'),
                          textValue: StringConstants.kOk,
                          onPrimaryButton: () => Navigator.pop(context));
                    });
              } else {
                context
                    .read<WorkOrderTabDetailsBloc>()
                    .add(SaveWorkOrderDocuments());
              }
            },
            textValue: DatabaseUtil.getText('buttonDone')),
      ),
    );
  }
}
