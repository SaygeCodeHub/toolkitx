import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/enums/incident_filter_status_enum.dart';

class IncidentStatusFilter extends StatefulWidget {
  final Map incidentFilterMap;

  const IncidentStatusFilter({super.key, required this.incidentFilterMap});

  @override
  State<IncidentStatusFilter> createState() => _IncidentStatusFilterState();
}

class _IncidentStatusFilterState extends State<IncidentStatusFilter> {
  List selectedData = [];

  @override
  void initState() {
    selectedData = (widget.incidentFilterMap['status'] == null)
        ? []
        : widget.incidentFilterMap['status']
            .toString()
            .replaceAll(' ', '')
            .split(',');
    super.initState();
  }

  multiSelect(item) {
    setState(() {
      if (selectedData.contains(item)) {
        selectedData.remove(item);
      } else {
        selectedData.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: kFilterTags, children: [
      for (var item in IncidentStatusEnum.values)
        FilterChip(
            backgroundColor: (selectedData.contains(item.value.toString()))
                ? AppColor.green
                : AppColor.lightestGrey,
            label: Text(DatabaseUtil.getText(item.status),
                style: Theme.of(context).textTheme.xxSmall.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.normal)),
            onSelected: (bool selected) {
              multiSelect(item.value.toString());
              widget.incidentFilterMap['status'] = selectedData
                  .toString()
                  .replaceAll('[', '')
                  .replaceAll(']', '')
                  .replaceAll(' ', '');
            })
    ]);
  }
}
