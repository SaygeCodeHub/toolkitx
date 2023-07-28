import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/models/LogBook/fetch_logbook_master_model.dart';

class LogbookTypeFilter extends StatefulWidget {
  final List<List<LogBokFetchMaster>> data;
  final Map logbookFilterMap;

  const LogbookTypeFilter(
      {super.key, required this.data, required this.logbookFilterMap});

  @override
  State<LogbookTypeFilter> createState() => _LogbookTypeFilterState();
}

class _LogbookTypeFilterState extends State<LogbookTypeFilter> {
  List selectedData = [];

  @override
  void initState() {
    selectedData = (widget.logbookFilterMap['type'] == null)
        ? []
        : widget.logbookFilterMap['type']
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
      for (var item in widget.data[2])
        FilterChip(
            backgroundColor: (selectedData.contains(item.id.toString()))
                ? AppColor.green
                : AppColor.lightestGrey,
            label: Text(item.flagname,
                style: Theme.of(context).textTheme.xxSmall.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.normal)),
            onSelected: (bool selected) {
              multiSelect(item.id.toString());
              widget.logbookFilterMap['type'] = selectedData
                  .toString()
                  .replaceAll('[', '')
                  .replaceAll(']', '');
            })
    ]);
  }
}
