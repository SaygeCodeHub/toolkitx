import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_bloc.dart';
import 'package:toolkit/blocs/imagePickerBloc/image_picker_bloc.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/accounting/widgets/attach_document_widget.dart';
import 'package:toolkit/screens/accounting/widgets/outgoingInvoiceWidgets/edit_outgoing_section_bottombar.dart';
import 'package:toolkit/utils/constants/api_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/utils/generic_alphanumeric_generator_util.dart';
import 'package:toolkit/utils/incident_view_image_util.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:url_launcher/url_launcher_string.dart';

class EditOutgoingInvoiceSection extends StatelessWidget {
  static const routeName = "EditOutgoingInvoiceSection";
  final String clientId;

  const EditOutgoingInvoiceSection({super.key, required this.clientId});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    List<dynamic> uploadedDocuments = [];

    return Scaffold(
        appBar: const GenericAppBar(title: 'Edit Outgoing Invoice'),
        bottomNavigationBar: EditOutgoingSectionBottomBar(formKey: formKey),
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
                            .manageOutgoingInvoiceMap['invoiceamount'] ??
                        '',
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
                            .manageOutgoingInvoiceMap['comments'] ??
                        '',
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
                            .manageOutgoingInvoiceMap['edit_files'] !=
                        null,
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: (context
                                            .read<AccountingBloc>()
                                            .manageIncomingInvoiceMap[
                                        'edit_files'] ??
                                    '')
                                .split(',')
                                .length ??
                            0,
                        itemBuilder: (context, index) {
                          return InkWell(
                              splashColor: AppColor.transparent,
                              highlightColor: AppColor.transparent,
                              onTap: () {
                                // print("clientId==>${clientId}");
                                // print("fileslist =======>${context.read<AccountingBloc>().manageOutgoingInvoiceMap['files']}");
                                if (clientId != '') {
                                  // print(
                                  //     "Url==>${ApiConstants.viewDocBaseUrl}${ViewImageUtil.viewImageList(context
                                  //         .read<AccountingBloc>()
                                  //         .manageOutgoingInvoiceMap['files'] ?? '')[index]}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}");
                                  launchUrlString(
                                      '${ApiConstants.viewDocBaseUrl}${ViewImageUtil.viewImageList(context.read<AccountingBloc>().manageOutgoingInvoiceMap['edit_files'] ?? '')[index]}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
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
                                    ViewImageUtil.viewImageList(context
                                                .read<AccountingBloc>()
                                                .manageOutgoingInvoiceMap[
                                            'edit_files'] ??
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
                          .manageOutgoingInvoiceMap['files'] = uploadDocList;
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
