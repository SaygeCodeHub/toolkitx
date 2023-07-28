import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/models/LogBook/fetch_logbook_master_model.dart';

class LogbookFilter extends StatefulWidget {
  final List<List<LogBokFetchMaster>> data;
  final Map logbookFilterMap;

  const LogbookFilter(
      {Key? key, required this.data, required this.logbookFilterMap})
      : super(key: key);

  @override
  State<LogbookFilter> createState() => _LogbookFilterState();
}

class _LogbookFilterState extends State<LogbookFilter> {
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
    for (int i = 0; i < widget.data[0].length; i++) {
      Widget item = ChoiceChip(
        label: Text(widget.data[0][i].name),
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
            widget.logbookFilterMap['log'] = widget.data[0][i].id.toString();
          });
        },
      );
      chips.add(item);
    }
    return chips;
  }
}
