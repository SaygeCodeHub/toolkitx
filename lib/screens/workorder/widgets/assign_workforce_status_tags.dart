import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/models/status_tag_model.dart';
import '../../../data/models/workorder/fetch_assign_workforce_model.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/status_tag.dart';
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
        FloatingActionButton.small(
            heroTag: "btn$index",
            backgroundColor: AppColor.blueGrey,
            onPressed: () {
              AssignWorkForceBody.assignWorkForceMap['peopleid'] = context
                  .read<WorkOrderTabDetailsBloc>()
                  .assignWorkForceDatum[index]
                  .id;
              context.read<WorkOrderTabDetailsBloc>().add(AssignWorkForce(
                  assignWorkOrderMap: AssignWorkForceBody.assignWorkForceMap,
                  showWarningCount: '1'));
            },
            child:
                const Icon(Icons.add, size: kIconSize, color: AppColor.black))
      ],
    );
  }
}
