import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/enums/logbook_status_enum.dart';

class LogbookStatusFilter extends StatefulWidget {
  final Map logbookFilterMap;

  const LogbookStatusFilter({Key? key, required this.logbookFilterMap})
      : super(key: key);

  @override
  State<LogbookStatusFilter> createState() => _LogbookStatusFilterState();
}

class _LogbookStatusFilterState extends State<LogbookStatusFilter> {
  int selectedIndex = 0;

  @override
  void initState() {
    (widget.logbookFilterMap['log'] == null)
        ? ''
        : widget.logbookFilterMap['log'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: kFilterTags, children: choiceChips());
  }

  List<Widget> choiceChips() {
    List<Widget> chips = [];
    for (int i = 0; i < LogbookStatusEnum.values.length; i++) {
      Widget item = ChoiceChip(
        label: Text(LogbookStatusEnum.values[i].status),
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
            widget.logbookFilterMap['log'] =
                LogbookStatusEnum.values[i].value.toString();
          });
        },
      );
      chips.add(item);
    }
    return chips;
  }
}
