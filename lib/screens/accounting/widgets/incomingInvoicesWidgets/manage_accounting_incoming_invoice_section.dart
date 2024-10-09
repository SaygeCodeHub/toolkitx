import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import '../../../../blocs/accounting/accounting_bloc.dart';
import '../../../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../widgets/generic_app_bar.dart';
import '../attach_document_widget.dart';
import 'create_incoming_invoice_bottombar.dart';

class ManageAccountingIncomingInvoiceSection extends StatelessWidget {
  static const routeName = 'ManageAccountingIncomingInvoiceSection';

  const ManageAccountingIncomingInvoiceSection({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PickAndUploadImageBloc>().isInitialUpload = true;
    context.read<PickAndUploadImageBloc>().add(UploadInitial());
    return Scaffold(
        appBar: const GenericAppBar(title: 'Add Incoming Invoice'),
        bottomNavigationBar: const CreateIncomingInvoiceBottomBar(),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinySpacing),
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
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
                      TextFieldWidget(
                          textInputType: TextInputType.number,
                          onTextFieldChanged: (String value) {
                            context
                                    .read<AccountingBloc>()
                                    .manageIncomingInvoiceMap['invoiceamount'] =
                                value;
                          }),
                      const SizedBox(height: xxTinySpacing),
                      if (context
                              .read<AccountingBloc>()
                              .manageIncomingInvoiceMap['other'] ==
                          'Other')
                        Text('Amount(Other)',
                            style: Theme.of(context)
                                .textTheme
                                .xSmall
                                .copyWith(fontWeight: FontWeight.w600)),
                      if (context
                              .read<AccountingBloc>()
                              .manageIncomingInvoiceMap['other'] ==
                          'Other')
                        const SizedBox(height: xxxTinierSpacing),
                      if (context
                              .read<AccountingBloc>()
                              .manageIncomingInvoiceMap['other'] ==
                          'Other')
                        TextFieldWidget(
                            textInputType: TextInputType.number,
                            onTextFieldChanged: (String value) {
                              context
                                      .read<AccountingBloc>()
                                      .manageIncomingInvoiceMap[
                                  'otherinvoiceamount'] = value;
                            }),
                      if (context
                              .read<AccountingBloc>()
                              .manageIncomingInvoiceMap['other'] ==
                          'Other')
                        const SizedBox(height: xxTinySpacing),
                      Text('Comments',
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      TextFieldWidget(
                          maxLines: 5,
                          textInputAction: TextInputAction.done,
                          onTextFieldChanged: (String value) {
                            context
                                .read<AccountingBloc>()
                                .manageIncomingInvoiceMap['comments'] = value;
                          }),
                      const SizedBox(height: xxTinySpacing),
                      AttachDocumentWidget(
                          onUploadDocument: (List<dynamic> uploadDocList) {
                            context
                                    .read<AccountingBloc>()
                                    .manageIncomingInvoiceMap['files'] =
                                uploadDocList;
                          },
                          imagePickerBloc: ImagePickerBloc())
                    ]))));
  }
}
