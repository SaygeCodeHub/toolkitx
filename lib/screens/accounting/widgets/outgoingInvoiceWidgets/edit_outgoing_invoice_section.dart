import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_event.dart';
import 'package:toolkit/blocs/accounting/accounting_state.dart';
import 'package:toolkit/blocs/imagePickerBloc/image_picker_bloc.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/accounting/widgets/attach_document_widget.dart';
import 'package:toolkit/utils/constants/api_constants.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/utils/generic_alphanumeric_generator_util.dart';
import 'package:toolkit/utils/incident_view_image_util.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import 'package:url_launcher/url_launcher_string.dart';

class EditOutgoingInvoiceSection extends StatelessWidget {
  static const routeName = "EditOutgoingInvoiceSection";
  final String clientId;

  const EditOutgoingInvoiceSection(
      {super.key, required this.clientId});


  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    List<dynamic> uploadedDocuments = [];

    return Scaffold(
        appBar: const GenericAppBar(title: 'Edit Outgoing Invoice'),
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
                        if (context
                            .read<AccountingBloc>()
                            .manageOutgoingInvoiceMap['invoiceamount'].isNotEmpty &&
                            context
                                .read<AccountingBloc>()
                                .manageOutgoingInvoiceMap["files"].isNotEmpty) {
                          context
                              .read<AccountingBloc>()
                              .add(CreateOutgoingInvoice(outgoingInvoiceId:  context
                              .read<AccountingBloc>()
                              .manageOutgoingInvoiceMap['id']??""));
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
                  TextFieldWidget(
                    onTextFieldChanged: (String value) {
                      // invoiceAmount = value;
                      context
                          .read<AccountingBloc>()
                          .manageOutgoingInvoiceMap['invoiceamount'] = value;
                    },
                    value: context
                        .read<AccountingBloc>()
                        .manageOutgoingInvoiceMap['invoiceamount']?? '',
                  ),
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
                    },
                    value: context
                        .read<AccountingBloc>()
                        .manageOutgoingInvoiceMap['comments']?? '',
                  ),
                  const SizedBox(height: xxxTinierSpacing),
                  Text(DatabaseUtil.getText('viewimage'),
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: xxxTinierSpacing),
                  Visibility(
                    visible: context
                        .read<AccountingBloc>()
                        .manageOutgoingInvoiceMap['files'] != null,
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: (context
                            .read<AccountingBloc>()
                            .manageOutgoingInvoiceMap['files'] ?? '').split(',').length ?? 0,
                        itemBuilder: (context, index) {
                          return InkWell(
                              splashColor: AppColor.transparent,
                              highlightColor: AppColor.transparent,
                              onTap: () {
                                // print("clientId==>${clientId}");
                                // print("fileslist =======>${context.read<AccountingBloc>().manageOutgoingInvoiceMap['files']}");
                                if(clientId != '') {
                                  // print(
                                  //     "Url==>${ApiConstants.viewDocBaseUrl}${ViewImageUtil.viewImageList(context
                                  //         .read<AccountingBloc>()
                                  //         .manageOutgoingInvoiceMap['files'] ?? '')[index]}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}");
                                  launchUrlString(
                                      '${ApiConstants.viewDocBaseUrl}${ViewImageUtil.viewImageList(context
                                          .read<AccountingBloc>()
                                          .manageOutgoingInvoiceMap['files'] ?? '')[index]}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
                                      mode: LaunchMode.externalApplication);
                                }
                                // else{
                                //   print("clientId is Empty");
                                // }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: xxxTinierSpacing),
                                child: Text(
                                    ViewImageUtil.viewImageList(
                                        context
                                            .read<AccountingBloc>()
                                            .manageOutgoingInvoiceMap['files'] ??
                                            '')[index],
                                    style: const TextStyle(
                                        color: AppColor.deepBlue)),
                              ));
                        }),
                  ),
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
                    imagePickerBloc: ImagePickerBloc(),
                      initialImages: uploadedDocuments,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
