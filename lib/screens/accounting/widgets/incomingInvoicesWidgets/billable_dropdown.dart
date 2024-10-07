import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../data/enums/accounting/accounting_billable_enum.dart';
import '../../../../utils/constants/string_constants.dart';

class BillableDropdown extends StatefulWidget {
  final void Function(String selectedValue) onBillableChanged;

  const BillableDropdown({super.key, required this.onBillableChanged});

  @override
  State<BillableDropdown> createState() => _BillableDropdownState();
}

class _BillableDropdownState extends State<BillableDropdown> {
  String selectedText = '';
  String selectedValue = '';

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: AppColor.transparent),
        child: ExpansionTile(
            maintainState: true,
            key: GlobalKey(),
            title: Text(
                (selectedText.isEmpty) ? StringConstants.kSelect : selectedText,
                style: Theme.of(context).textTheme.xSmall),
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: AccountingBillableEnum.values.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: xxxTinierSpacing),
                        title: Text(
                            AccountingBillableEnum.values[index].billText,
                            style: Theme.of(context).textTheme.xSmall),
                        onTap: () {
                          setState(() {
                            selectedText =
                                AccountingBillableEnum.values[index].billText;
                            selectedValue =
                                AccountingBillableEnum.values[index].billValue;
                          });
                          widget.onBillableChanged(selectedValue);
                        });
                  })
            ]));
  }
}
