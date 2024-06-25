import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/enums/permit_status_enum.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';

class PermitStatusFilter extends StatefulWidget {
  final Map permitFilterMap;

  const PermitStatusFilter({super.key, required this.permitFilterMap});

  @override
  State<PermitStatusFilter> createState() => _PermitStatusFilterState();
}

class _PermitStatusFilterState extends State<PermitStatusFilter> {
  List selectedData = [];

  @override
  void initState() {
    selectedData = (widget.permitFilterMap['status'] == null)
        ? []
        : widget.permitFilterMap['status']
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
      for (var item in PermitStatusEnum.values)
        FilterChip(
            backgroundColor: (selectedData.contains(item.value.toString()))
                ? AppColor.green
                : AppColor.lightestGrey,
            label: Text(DatabaseUtil.getText(item.status),
                style: Theme.of(context).textTheme.xxSmall.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.normal)),
            onSelected: (bool selected) {
              multiSelect(item.value.toString());
              widget.permitFilterMap['status'] = selectedData
                  .toString()
                  .replaceAll('[', '')
                  .replaceAll(']', '')
                  .replaceAll(' ', '');
            })
    ]);
  }
}
