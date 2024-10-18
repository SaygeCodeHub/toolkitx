import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_spacing.dart';
import '../../../data/enums/accounting/accounting_month_enum.dart';

class CustomMonthPickerDropdown extends StatefulWidget {
  final void Function(String month) onMonthChanged;
  final String defaultMonth;

  const CustomMonthPickerDropdown(
      {super.key, required this.onMonthChanged, required this.defaultMonth});

  @override
  State<CustomMonthPickerDropdown> createState() =>
      _CustomMonthPickerDropdownState();
}

class _CustomMonthPickerDropdownState extends State<CustomMonthPickerDropdown> {
  String? selectedMonth;

  @override
  void initState() {
    if (widget.defaultMonth.isNotEmpty) {
      int defaultMonthIndex = int.parse(widget.defaultMonth) - 1;
      if (defaultMonthIndex >= 0 && defaultMonthIndex < 12) {
        selectedMonth =
            AccountingMonthsEnum.values[defaultMonthIndex].toString();
      }
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
          selectedMonth ?? 'Select month',
          style: Theme.of(context).textTheme.xSmall,
        ),
        children: List.generate(AccountingMonthsEnum.values[0].months.length,
            (int index) {
          return ListTile(
            contentPadding: const EdgeInsets.only(left: xxxTinierSpacing),
            title: Text(
              AccountingMonthsEnum.values[0].months[index],
              style: Theme.of(context).textTheme.xSmall,
            ),
            onTap: () {
              setState(() {
                selectedMonth = AccountingMonthsEnum.values[0].months[index];
              });
              widget.onMonthChanged((index + 1).toString());
            },
          );
        }),
      ),
    );
  }
}
