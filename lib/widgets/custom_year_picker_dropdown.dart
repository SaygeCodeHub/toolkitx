import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../configs/app_color.dart';
import '../configs/app_spacing.dart';

class CustomYearPickerDropdown extends StatefulWidget {
  final void Function(String year) onYearChanged;
  final String defaultYear;

  const CustomYearPickerDropdown(
      {super.key, required this.onYearChanged, required this.defaultYear});

  @override
  State<CustomYearPickerDropdown> createState() =>
      _CustomYearPickerDropdownState();
}

class _CustomYearPickerDropdownState extends State<CustomYearPickerDropdown> {
  final int endYear = DateTime.now().year + 1;
  int startYear = 1990;
  int? selectedYear;

  @override
  void initState() {
    print('default year ${widget.defaultYear}');
    startYear = endYear - 11;
    if (widget.defaultYear.isNotEmpty) {
      selectedYear = int.parse(widget.defaultYear);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: AppColor.transparent),
        child: ExpansionTile(
            maintainState: true,
            key: GlobalKey(),
            title: Text(
                (selectedYear != null)
                    ? selectedYear.toString()
                    : StringConstants.kSelectYear,
                style: Theme.of(context).textTheme.xSmall),
            children: List.generate(endYear - startYear + 1, (int itemIndex) {
              int year = startYear + itemIndex;
              return ListTile(
                  contentPadding: const EdgeInsets.only(left: xxxTinierSpacing),
                  title: Text(year.toString(),
                      style: Theme.of(context).textTheme.xSmall),
                  onTap: () {
                    setState(() {
                      selectedYear = year;
                    });
                    widget.onYearChanged(selectedYear.toString());
                  });
            })));
  }
}
