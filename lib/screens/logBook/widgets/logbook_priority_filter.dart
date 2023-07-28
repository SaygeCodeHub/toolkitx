import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/enums/logbook_priority_enum.dart';

class LogbookPriorityFilter extends StatefulWidget {
  final Map logbookFilterMap;

  const LogbookPriorityFilter({Key? key, required this.logbookFilterMap})
      : super(key: key);

  @override
  State<LogbookPriorityFilter> createState() => _LogbookPriorityFilterState();
}

class _LogbookPriorityFilterState extends State<LogbookPriorityFilter> {
  int selectedIndex = 0;

  @override
  void initState() {
    (widget.logbookFilterMap['priority'] == null)
        ? ''
        : widget.logbookFilterMap['priority'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: kFilterTags, children: choiceChips());
  }

  List<Widget> choiceChips() {
    List<Widget> chips = [];
    for (int i = 0; i < LogbookPriorityEnum.values.length; i++) {
      Widget item = ChoiceChip(
        label: Text(LogbookPriorityEnum.values[i].priority),
        labelStyle: Theme.of(context)
            .textTheme
            .xxSmall
            .copyWith(color: AppColor.black, fontWeight: FontWeight.normal),
        backgroundColor: AppColor.lightestGrey,
        selected: (widget.logbookFilterMap['log'] == null)
            ? false
            : selectedIndex == i,
        selectedColor: AppColor.green,
        onSelected: (bool value) {
          setState(() {
            selectedIndex = i;
            widget.logbookFilterMap['priority'] =
                LogbookPriorityEnum.values[i].value.toString();
          });
        },
      );
      chips.add(item);
    }
    return chips;
  }
}
