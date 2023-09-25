import 'package:flutter/material.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/models/status_tag_model.dart';
import '../../../data/models/workorder/fetch_assign_workforce_model.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/status_tag.dart';

class AssignWorkForceStatusTags extends StatelessWidget {
  final AssignWorkForceDatum assignWorkForceDatum;

  const AssignWorkForceStatusTags(
      {Key? key, required this.assignWorkForceDatum})
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
            backgroundColor: AppColor.blueGrey,
            onPressed: () {},
            child:
                const Icon(Icons.add, size: kIconSize, color: AppColor.black))
      ],
    );
  }
}
