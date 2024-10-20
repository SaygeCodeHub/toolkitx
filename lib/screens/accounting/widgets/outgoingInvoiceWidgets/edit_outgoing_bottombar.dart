import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/accounting/widgets/outgoingInvoiceWidgets/edit_outgoing_invoice_section.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/primary_button.dart';

class EditOutgoingBottombar extends StatelessWidget {
  const EditOutgoingBottombar({
    super.key,
    required this.formKey,
    required this.clientId,
  });

  final GlobalKey<FormState> formKey;
  final String clientId;

  bool isValidField(String? value) {
    return value != null && value.trim().isNotEmpty;
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
              textValue: StringConstants.kBack),
        ),
        const SizedBox(width: xxTinierSpacing),
        Expanded(
          child: PrimaryButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                if (isValidField(context
                        .read<AccountingBloc>()
                        .manageOutgoingInvoiceMap['entity']) &&
                    isValidField(context
                        .read<AccountingBloc>()
                        .manageOutgoingInvoiceMap["client"]) &&
                    isValidField(context
                        .read<AccountingBloc>()
                        .manageOutgoingInvoiceMap['project']) &&
                    isValidField(context
                        .read<AccountingBloc>()
                        .manageOutgoingInvoiceMap["date"])) {
                  Navigator.pushNamed(
                      context, EditOutgoingInvoiceSection.routeName,
                      arguments: clientId);
                } else {
                  showCustomSnackBar(
                      context,
                      StringConstants
                          .kEntityClientProjectInvoiceDateCanNotBeEmpty,
                      '');
                }
              }
            },
            textValue: StringConstants.kNext,
          ),
        ),
      ],
    ));
  }
}
