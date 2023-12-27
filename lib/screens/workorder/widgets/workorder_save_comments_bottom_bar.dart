import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/progress_bar.dart';
import '../workorder_add_comments_screen.dart';

class WorkOrderSaveCommentsBottomBar extends StatelessWidget {
  const WorkOrderSaveCommentsBottomBar({Key? key}) : super(key: key);

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
          BlocListener<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
              listener: (context, state) {
                if (state is SavingWorkOrderComments) {
                  ProgressBar.show(context);
                } else if (state is WorkOrderCommentsSaved) {
                  ProgressBar.dismiss(context);
                  Navigator.pop(context);
                  context.read<WorkOrderTabDetailsBloc>().add(WorkOrderDetails(
                      initialTabIndex: 4,
                      workOrderId: WorkOrderAddCommentsScreen
                          .addCommentsMap['workorderId']));
                } else if (state is WorkOrderCommentsNotSaved) {
                  ProgressBar.dismiss(context);
                  showCustomSnackBar(context, state.commentsNotSaved, '');
                }
              },
              child: Expanded(
                child: PrimaryButton(
                    onPressed: () {
                      context
                          .read<WorkOrderTabDetailsBloc>()
                          .add(SaveWorkOrderComments());
                    },
                    textValue: StringConstants.kSave),
              )),
        ],
      ),
    );
  }
}
