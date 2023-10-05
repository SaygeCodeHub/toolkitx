import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/models/status_tag_model.dart';
import '../../../data/models/workorder/fetch_assign_workforce_model.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/status_tag.dart';
import 'assign_workforce_alert_dialog.dart';
import 'assign_workforce_body.dart';

class AssignWorkForceStatusTags extends StatelessWidget {
  final AssignWorkForceDatum assignWorkForceDatum;
  final int index;

  const AssignWorkForceStatusTags(
      {Key? key, required this.assignWorkForceDatum, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StatusTag(tags: [
          StatusTagModel(
              title: (assignWorkForceDatum.certificatecode == '0')
                  ? DatabaseUtil.getText('Expired')
                  : DatabaseUtil.getText('Valid'),
              bgColor: (assignWorkForceDatum.certificatecode == '0')
                  ? AppColor.errorRed
                  : AppColor.green),
        ]),
        BlocListener<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
          listener: (context, state) {
            if (state is AssigningWorkForce) {
              ProgressBar.show(context);
            } else if (state is WorkForceAssigned) {
              ProgressBar.dismiss(context);
              context
                  .read<WorkOrderTabDetailsBloc>()
                  .add(FetchAssignWorkForceList(pageNo: 1));
            } else if (state is WorkForceNotAssigned) {
              ProgressBar.dismiss(context);
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return AssignWorkForceAlertDialog(
                        warningMessage: state.workForceNotFetched);
                  });
            }
          },
          child: FloatingActionButton.small(
              heroTag: "btn$index",
              backgroundColor: AppColor.blueGrey,
              onPressed: () {
                AssignWorkForceBody.assignWorkForceMap['peopleid'] =
                    assignWorkForceDatum.id;
                if (AssignWorkForceBody.assignWorkForceMap['hrs'] == null) {
                  showCustomSnackBar(context,
                      DatabaseUtil.getText('Pleaseinsertvalidworkhours'), '');
                } else {
                  context.read<WorkOrderTabDetailsBloc>().add(AssignWorkForce(
                      assignWorkOrderMap:
                          AssignWorkForceBody.assignWorkForceMap,
                      showWarningCount: '1'));
                }
              },
              child: const Icon(Icons.add,
                  size: kIconSize, color: AppColor.black)),
        )
      ],
    );
  }
}
