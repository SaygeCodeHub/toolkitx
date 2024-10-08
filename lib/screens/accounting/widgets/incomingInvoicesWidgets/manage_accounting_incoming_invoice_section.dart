import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/generic_text_field.dart';

import '../../../../blocs/accounting/accounting_bloc.dart';
import '../../../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/generic_app_bar.dart';
import '../../../../widgets/primary_button.dart';
import '../invoice_currency_dropdown.dart';
import 'mode_of_payment_dropdown.dart';

class ManageAccountingIncomingInvoiceSection extends StatelessWidget {
  static const routeName = 'ManageAccountingIncomingInvoiceSection';

  const ManageAccountingIncomingInvoiceSection({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PickAndUploadImageBloc>().add(UploadInitial());
    return Scaffold(
      appBar: const GenericAppBar(title: 'Add Incoming Invoice'),
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
            child: PrimaryButton(
                onPressed: () {}, textValue: StringConstants.kSave),
          ),
        ],
      )),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin, right: leftRightMargin, top: xxTinySpacing),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Mode of payment',
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: xxxTinierSpacing),
              ModeOfPaymentDropdown(
                  onPaymentModeSelected: (String paymentMode) {
                context
                    .read<AccountingBloc>()
                    .manageIncomingInvoiceMap['mode'] = paymentMode;
              }),
              const SizedBox(height: xxTinySpacing),
              Text('Invoice Currency',
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: xxxTinierSpacing),
              InvoiceCurrencyDropdown(onCurrencySelected: (String currency) {
                context
                    .read<AccountingBloc>()
                    .manageIncomingInvoiceMap['othercurrency'] = currency;
              }),
              const SizedBox(height: xxTinySpacing),
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
                    .manageIncomingInvoiceMap['invoiceamount'] = value;
              }),
              const SizedBox(height: xxTinySpacing),
              Text('Amount(Other)',
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: xxxTinierSpacing),
              TextFieldWidget(onTextFieldChanged: (String value) {
                context
                    .read<AccountingBloc>()
                    .manageIncomingInvoiceMap['otherinvoiceamount'] = value;
              }),
              const SizedBox(height: xxTinySpacing),
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
                        .manageIncomingInvoiceMap['comments'] = value;
                  }),
              const SizedBox(height: xxTinySpacing),
              Text('Attached Documents',
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: xxxTinierSpacing),
              // SecondaryButton(
              //     onPressed: () {
              //       showDialog(
              //           context: context,
              //           builder: (context) {
              //             return BlocBuilder<PickAndUploadImageBloc,
              //                     PickAndUploadImageStates>(
              //                 builder: (context, state) {
              //               return AlertDialog(
              //                   shape: RoundedRectangleBorder(
              //                       borderRadius:
              //                           BorderRadius.circular(kCardRadius),
              //                       side: const BorderSide(
              //                           color: AppColor.black)),
              //                   actions: [
              //                     Center(
              //                         child: Text(StringConstants.kUploadFrom,
              //                             style: Theme.of(context)
              //                                 .textTheme
              //                                 .medium)),
              //                     const SizedBox(height: tiniestSpacing),
              //                     IntrinsicHeight(
              //                         child: Row(
              //                             crossAxisAlignment:
              //                                 CrossAxisAlignment.center,
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.center,
              //                             children: [
              //                           Padding(
              //                               padding: const EdgeInsets.all(
              //                                   xxTinierSpacing),
              //                               child: Column(children: [
              //                                 InkWell(
              //                                     onTap: () {},
              //                                     borderRadius:
              //                                         BorderRadius.circular(
              //                                             kAlertDialogRadius),
              //                                     child: Container(
              //                                         width:
              //                                             kAlertDialogTogether,
              //                                         height:
              //                                             kAlertDialogTogether,
              //                                         decoration: BoxDecoration(
              //                                             color:
              //                                                 AppColor.blueGrey,
              //                                             borderRadius:
              //                                                 BorderRadius.circular(
              //                                                     kAlertDialogRadius)),
              //                                         child: const Center(
              //                                             child: Icon(
              //                                                 Icons
              //                                                     .camera_alt_outlined,
              //                                                 size: 30)))),
              //                                 const SizedBox(
              //                                     height: tiniestSpacing),
              //                                 const Text(
              //                                   StringConstants.kCamera,
              //                                 )
              //                               ])),
              //                           const VerticalDivider(
              //                               color: AppColor.grey,
              //                               width: kDividerWidth,
              //                               thickness: kDividerThickness,
              //                               indent: kDividerIndent,
              //                               endIndent: kDividerEndIndent),
              //                           Padding(
              //                               padding: const EdgeInsets.all(
              //                                   xxTinierSpacing),
              //                               child: Column(children: [
              //                                 InkWell(
              //                                   onTap: () {},
              //                                   child: Container(
              //                                     width: kAlertDialogTogether,
              //                                     height: kAlertDialogTogether,
              //                                     decoration: BoxDecoration(
              //                                         color: AppColor.blueGrey,
              //                                         borderRadius:
              //                                             BorderRadius.circular(
              //                                                 kAlertDialogRadius)),
              //                                     child: const Center(
              //                                         child: Icon(
              //                                       Icons.drive_folder_upload,
              //                                       size: 30,
              //                                     )),
              //                                   ),
              //                                 ),
              //                                 const SizedBox(
              //                                     height: tiniestSpacing),
              //                                 Text(StringConstants.kDevice,
              //                                     style: Theme.of(context)
              //                                         .textTheme
              //                                         .small
              //                                         .copyWith(
              //                                             color:
              //                                                 AppColor.black))
              //                               ])),
              //                           Padding(
              //                               padding: const EdgeInsets.all(
              //                                   xxTinierSpacing),
              //                               child: Column(children: [
              //                                 InkWell(
              //                                   onTap: () {},
              //                                   child: Container(
              //                                     width: kAlertDialogTogether,
              //                                     height: kAlertDialogTogether,
              //                                     decoration: BoxDecoration(
              //                                         color: AppColor.blueGrey,
              //                                         borderRadius:
              //                                             BorderRadius.circular(
              //                                                 kAlertDialogRadius)),
              //                                     child: const Center(
              //                                         child: Icon(
              //                                       Icons.edit,
              //                                       size: 30,
              //                                     )),
              //                                   ),
              //                                 ),
              //                                 const SizedBox(
              //                                     height: tiniestSpacing),
              //                                 Text(StringConstants.kSignature,
              //                                     style: Theme.of(context)
              //                                         .textTheme
              //                                         .small
              //                                         .copyWith(
              //                                             color:
              //                                                 AppColor.black))
              //                               ]))
              //                         ]))
              //                   ]);
              //             });
              //           });
              //     },
              //     textValue: StringConstants.kUpload),
              const SizedBox(height: xxTinySpacing)
            ],
          ),
        ),
      ),
    );
  }
}
