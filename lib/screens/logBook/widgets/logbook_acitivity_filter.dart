import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/models/LogBook/fetch_logbook_master_model.dart';

class LogBookActivityFilter extends StatefulWidget {
  final List<List<LogBokFetchMaster>> data;
  final Map logbookFilterMap;

  const LogBookActivityFilter(
      {Key? key, required this.data, required this.logbookFilterMap})
      : super(key: key);

  @override
  State<LogBookActivityFilter> createState() => _LogBookActivityFilterState();
}

class _LogBookActivityFilterState extends State<LogBookActivityFilter> {
  int selectedIndex = 0;

  @override
  void initState() {
    (widget.logbookFilterMap['activity'] == null)
        ? ''
        : widget.logbookFilterMap['activity'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: kFilterTags, children: choiceChips());
  }

  List<Widget> choiceChips() {
    List<Widget> chips = [];
    for (int i = 0; i < widget.data[3].length; i++) {
      Widget item = ChoiceChip(
        label: Text(widget.data[3][i].activityname),
        labelStyle: Theme.of(context)
            .textTheme
            .xxSmall
            .copyWith(color: AppColor.black, fontWeight: FontWeight.normal),
        backgroundColor: AppColor.lightestGrey,
        selected: (widget.logbookFilterMap['activity'] == null)
            ? false
            : selectedIndex == i,
        selectedColor: AppColor.green,
        onSelected: (bool value) {
          setState(() {
            selectedIndex = i;
            widget.logbookFilterMap['activity'] =
                widget.data[3][i].id.toString();
          });
        },
      );
      chips.add(item);
    }
    return chips;
  }
}
