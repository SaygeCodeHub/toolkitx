import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_event.dart';
import 'package:toolkit/blocs/accounting/accounting_state.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';

class ManageOutgoingInvoiceSectionBottomBar extends StatelessWidget {
  const ManageOutgoingInvoiceSectionBottomBar({
    super.key,
    required this.formKey,
    required this.invoiceAmount,
    required this.uploadedDocuments,
  });

  final GlobalKey<FormState> formKey;
  final String invoiceAmount;
  final List uploadedDocuments;

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
          child: BlocListener<AccountingBloc, AccountingState>(
            listener: (context, state) {
              if (state is CreatingOutgoingInvoice) {
                ProgressBar.show(context);
              } else if (state is OutgoingInvoiceCreated) {
                ProgressBar.dismiss(context);
                Navigator.pop(context);
                Navigator.pop(context);
                context
                    .read<AccountingBloc>()
                    .add(FetchOutgoingInvoices(pageNo: 1));
              } else if (state is FailedToCreateOutgoingInvoice) {
                ProgressBar.dismiss(context);
                showCustomSnackBar(
                    context, "Failed To create Outgoing Invoice", '');
              }
            },
            child: PrimaryButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (invoiceAmount.isNotEmpty &&
                        uploadedDocuments.isNotEmpty) {
                      context
                          .read<AccountingBloc>()
                          .add(CreateOutgoingInvoice());
                    } else {
                      showCustomSnackBar(
                          context,
                          StringConstants.kAmountAttachedDocumentsCanNotBeEmpty,
                          '');
                    }
                  }
                },
                textValue: StringConstants.kSave),
          ),
        ),
      ],
    ));
  }
}
