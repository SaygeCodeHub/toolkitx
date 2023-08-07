import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../blocs/qualityManagement/qm_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/enums/incident_and_qm_filter_status_enum.dart';

class QualityManagementStatusFilter extends StatelessWidget {
  final List selectedStatusList;

  const QualityManagementStatusFilter(
      {super.key, required this.selectedStatusList});

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: kFilterTags, children: [
      for (var item in IncidentAndQualityManagementStatusEnum.values)
        FilterChip(
            backgroundColor:
                (selectedStatusList.contains(item.value.toString()))
                    ? AppColor.green
                    : AppColor.lightestGrey,
            label: Text(DatabaseUtil.getText(item.status),
                style: Theme.of(context).textTheme.xxSmall.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.normal)),
            onSelected: (bool selected) {
              context.read<QualityManagementBloc>().add(
                  SelectQualityManagementStatusFilter(
                      statusList: selectedStatusList, statusId: item.value));
            })
    ]);
  }
}
