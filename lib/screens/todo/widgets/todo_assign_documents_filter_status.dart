import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/enums/todo_status_enum.dart';

class ToDoStatusFilter extends StatefulWidget {
  final Map todoFilterMap;

  const ToDoStatusFilter({super.key, required this.todoFilterMap});

  @override
  State<ToDoStatusFilter> createState() => _ToDoStatusFilterState();
}

class _ToDoStatusFilterState extends State<ToDoStatusFilter> {
  List selectedData = [];

  @override
  void initState() {
    selectedData = (widget.todoFilterMap['status'] == null)
        ? []
        : widget.todoFilterMap['status']
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
      for (var item in TodoStatusEnum.values)
        FilterChip(
            backgroundColor: (selectedData.contains(item.value.toString()))
                ? AppColor.green
                : AppColor.lightestGrey,
            label: Text(item.status,
                style: Theme.of(context).textTheme.xxSmall.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.normal)),
            onSelected: (bool selected) {
              multiSelect(item.value.toString());
              widget.todoFilterMap['status'] = selectedData
                  .toString()
                  .replaceAll('[', '')
                  .replaceAll(']', '')
                  .replaceAll(' ', '');
            })
    ]);
  }
}
