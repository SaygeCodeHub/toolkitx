import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/accounting/widgets/outgoingInvoiceWidgets/manage_accounting_outgoing_invoice_section.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/primary_button.dart';

class ManageOutgoingInvoiceBottomBar extends StatelessWidget {
  const ManageOutgoingInvoiceBottomBar({
    super.key,
    required this.formKey,
    required this.selectedEntity,
    required this.selectedClient,
    required this.selectedProject,
    required this.selectedDate,
  });

  final GlobalKey<FormState> formKey;
  final String selectedEntity;
  final String selectedClient;
  final String selectedProject;
  final String selectedDate;

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
                if (selectedEntity.isNotEmpty &&
                    selectedClient.isNotEmpty &&
                    selectedProject.isNotEmpty &&
                    selectedDate.isNotEmpty) {
                  Navigator.pushNamed(
                    context,
                    ManageAccountingOutgoingInvoiceSection.routeName,
                  );
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
