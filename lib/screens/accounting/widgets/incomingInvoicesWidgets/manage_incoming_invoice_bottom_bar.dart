import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';

import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/primary_button.dart';
import 'manage_accounting_incoming_invoice_section.dart';

class ManageIncomingInvoiceBottomBar extends StatelessWidget {
  const ManageIncomingInvoiceBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        child: Row(children: [
      Expanded(
          child: PrimaryButton(
              onPressed: () {
                Navigator.pop(context);
              },
              textValue: StringConstants.kBack)),
      const SizedBox(width: xxTinierSpacing),
      Expanded(
          child: PrimaryButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, ManageAccountingIncomingInvoiceSection.routeName);
              },
              textValue: StringConstants.kNext))
    ]));
  }
}
