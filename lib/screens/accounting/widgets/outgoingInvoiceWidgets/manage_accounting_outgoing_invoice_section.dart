import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_bloc.dart';
import 'package:toolkit/blocs/imagePickerBloc/image_picker_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/accounting/widgets/attach_document_widget.dart';
import 'package:toolkit/screens/accounting/widgets/outgoingInvoiceWidgets/create_outgoing_invoice_bottombar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';

class ManageAccountingOutgoingInvoiceSection extends StatelessWidget {
  const ManageAccountingOutgoingInvoiceSection({super.key});

  static const routeName = "ManageAccountingOutgoingInvoiceSection";

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: const GenericAppBar(title: 'Add Outgoing Invoice'),
        bottomNavigationBar: CreateOutgoingInvoiceBottomBar(formKey: formKey),
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
                        context
                            .read<AccountingBloc>()
                            .manageOutgoingInvoiceMap['files'] = uploadDocList;
                      },
                      imagePickerBloc: ImagePickerBloc())
                ],
              ),
            ),
          ),
        ));
  }
}
