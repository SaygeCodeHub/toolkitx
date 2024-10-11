import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_event.dart';
import 'package:toolkit/blocs/accounting/accounting_state.dart';
import 'package:toolkit/blocs/imagePickerBloc/image_picker_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/accounting/widgets/attach_document_widget.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';

class ManageAccountingOutgoingInvoiceSection extends StatelessWidget {
  const ManageAccountingOutgoingInvoiceSection({super.key});

  static const routeName = "ManageAccountingOutgoingInvoiceSection";

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String invoiceAmount = '';
    List<dynamic> uploadedDocuments = [];
    return Scaffold(
        appBar: const GenericAppBar(title: 'Add Outgoing Invoice'),
        bottomNavigationBar: BottomAppBar(
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
                              StringConstants
                                  .kAmountAttachedDocumentsCanNotBeEmpty,
                              '');
                        }
                      }
                    },
                    textValue: StringConstants.kSave),
              ),
            ),
          ],
        )),
        body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinySpacing),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      (context
                                  .read<AccountingBloc>()
                                  .fetchIAccountingMasterModel
                                  .data !=
                              null)
                          ? 'Amount(${context.read<AccountingBloc>().fetchIAccountingMasterModel.data![3][0].name})'
                          : 'Amount',
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: xxxTinierSpacing),
                  TextFieldWidget(onTextFieldChanged: (String value) {
                    invoiceAmount = value;
                    context
                        .read<AccountingBloc>()
                        .manageOutgoingInvoiceMap['invoiceamount'] = value;
                  }),
                  Text('Comments',
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: xxxTinierSpacing),
                  TextFieldWidget(
                      maxLines: 5,
                      onTextFieldChanged: (String value) {
                        context
                            .read<AccountingBloc>()
                            .manageOutgoingInvoiceMap['comments'] = value;
                      }),
                  AttachDocumentWidget(
                      onUploadDocument: (List<dynamic> uploadDocList) {
                        uploadedDocuments = uploadDocList;

                        context
                                .read<AccountingBloc>()
                                .manageOutgoingInvoiceMap['files'] =
                            uploadDocList
                                .toString()
                                .replaceAll("[", "")
                                .replaceAll("]", "");
                      },
                      imagePickerBloc: ImagePickerBloc())
                ],
              ),
            ),
          ),
        ));
  }
}
