import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/models/permit/permit_get_master_model.dart';

class PermitTypeFilter extends StatefulWidget {
  final List<List<PermitMasterDatum>> permitMasterDatum;
  final Map permitFilterMap;

  const PermitTypeFilter(
      {super.key,
      required this.permitMasterDatum,
      required this.permitFilterMap});

  @override
  State<PermitTypeFilter> createState() => _PermitTypeFilterState();
}

class _PermitTypeFilterState extends State<PermitTypeFilter> {
  List selectedData = [];

  @override
  void initState() {
    selectedData = (widget.permitFilterMap['type'] == null)
        ? []
        : widget.permitFilterMap['type']
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
      for (var item in widget.permitMasterDatum[0])
        FilterChip(
            backgroundColor: (selectedData.contains(item.permittype.toString()))
                ? AppColor.green
                : AppColor.lightestGrey,
            label: Text(item.permittypename!,
                style: Theme.of(context).textTheme.xxSmall.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.normal)),
            onSelected: (bool selected) {
              multiSelect(item.permittype.toString());
              widget.permitFilterMap['type'] = selectedData
                  .toString()
                  .replaceAll('[', '')
                  .replaceAll(']', '');
            })
    ]);
  }
}
