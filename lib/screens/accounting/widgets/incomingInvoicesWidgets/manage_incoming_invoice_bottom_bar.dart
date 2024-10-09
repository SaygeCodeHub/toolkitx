import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/primary_button.dart';
import 'accounting_invoice_validator.dart';

class ManageIncomingInvoiceBottomBar extends StatelessWidget {
  const ManageIncomingInvoiceBottomBar({super.key});

  bool validateForm(dynamic value) {
    return value == null || value.toString().isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
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
                    validateAndProceed(context);
                  },
                  textValue: StringConstants.kNext))
        ],
      ),
    );
  }
}
