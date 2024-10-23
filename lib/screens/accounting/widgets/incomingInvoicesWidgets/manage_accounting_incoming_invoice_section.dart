import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/api_constants.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/utils/generic_alphanumeric_generator_util.dart';
import 'package:toolkit/utils/incident_view_image_util.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../blocs/accounting/accounting_bloc.dart';
import '../../../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../widgets/generic_app_bar.dart';
import '../attach_document_widget.dart';
import 'create_incoming_invoice_bottombar.dart';

class ManageAccountingIncomingInvoiceSection extends StatelessWidget {
  final bool isFromEdit;
  static const routeName = 'ManageAccountingIncomingInvoiceSection';

  const ManageAccountingIncomingInvoiceSection(
      {super.key, required this.isFromEdit});

  @override
  Widget build(BuildContext context) {
    context.read<PickAndUploadImageBloc>().isInitialUpload = true;
    context.read<PickAndUploadImageBloc>().add(UploadInitial());
    return Scaffold(
        appBar: GenericAppBar(
            title: isFromEdit
                ? StringConstants.kEditIncomingInvoice
                : StringConstants.kAddIncomingInvoice),
        bottomNavigationBar:
            CreateIncomingInvoiceBottomBar(isFromEdit: isFromEdit),
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
                              ? '${StringConstants.kAmount}(${context.read<AccountingBloc>().fetchIAccountingMasterModel.data![3][0].name})'
                              : StringConstants.kAmount,
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
                        },
                        value: isFromEdit
                            ? context
                                        .read<AccountingBloc>()
                                        .manageIncomingInvoiceMap[
                                    'invoiceamount'] ??
                                ''
                            : '',
                      ),
                      const SizedBox(height: xxTinySpacing),
                      (isFromEdit
                              ? context
                                          .read<AccountingBloc>()
                                          .manageIncomingInvoiceMap[
                                      'othercurrencyname'] !=
                                  ''
                              : context
                                      .read<AccountingBloc>()
                                      .manageIncomingInvoiceMap['other'] ==
                                  'Other')
                          ? Text(
                              StringConstants.kAmountOther,
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(fontWeight: FontWeight.w600),
                            )
                          : const SizedBox.shrink(),
                      (isFromEdit
                              ? context
                                          .read<AccountingBloc>()
                                          .manageIncomingInvoiceMap[
                                      'othercurrencyname'] !=
                                  ''
                              : context
                                      .read<AccountingBloc>()
                                      .manageIncomingInvoiceMap['other'] ==
                                  'Other')
                          ? const SizedBox(height: xxxTinierSpacing)
                          : const SizedBox.shrink(),
                      (isFromEdit
                              ? context
                                          .read<AccountingBloc>()
                                          .manageIncomingInvoiceMap[
                                      'othercurrencyname'] !=
                                  ''
                              : context
                                      .read<AccountingBloc>()
                                      .manageIncomingInvoiceMap['other'] ==
                                  'Other')
                          ? TextFieldWidget(
                              textInputType: TextInputType.number,
                              onTextFieldChanged: (String value) {
                                context
                                        .read<AccountingBloc>()
                                        .manageIncomingInvoiceMap[
                                    'otherinvoiceamount'] = value;
                              },
                              value: isFromEdit
                                  ? context
                                          .read<AccountingBloc>()
                                          .manageIncomingInvoiceMap[
                                      'otherinvoiceamount']
                                  : '')
                          : const SizedBox.shrink(),
                      (isFromEdit
                              ? context
                                          .read<AccountingBloc>()
                                          .manageIncomingInvoiceMap[
                                      'othercurrencyname'] !=
                                  ''
                              : context
                                      .read<AccountingBloc>()
                                      .manageIncomingInvoiceMap['other'] ==
                                  'Other')
                          ? const SizedBox(height: xxTinySpacing)
                          : Container(),
                      if (context
                              .read<AccountingBloc>()
                              .manageIncomingInvoiceMap['other'] ==
                          'Other')
                        const SizedBox(height: xxTinySpacing),
                      Text(StringConstants.kcomments,
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
                        },
                        value: context
                                .read<AccountingBloc>()
                                .manageIncomingInvoiceMap['comments'] ??
                            '',
                      ),
                      const SizedBox(height: xxTinySpacing),
                      Visibility(
                        visible: isFromEdit,
                        child: Text(DatabaseUtil.getText('viewimage'),
                            style: Theme.of(context)
                                .textTheme
                                .xSmall
                                .copyWith(fontWeight: FontWeight.w600)),
                      ),
                      Visibility(
                          visible: isFromEdit,
                          child: const SizedBox(height: xxTinySpacing)),
                      Visibility(
                        visible: isFromEdit,
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
                                    if (context
                                                .read<AccountingBloc>()
                                                .manageIncomingInvoiceMap[
                                            "clientid"] !=
                                        '') {
                                      launchUrlString(
                                          '${ApiConstants.viewDocBaseUrl}${ViewImageUtil.viewImageList(context.read<AccountingBloc>().manageIncomingInvoiceMap['edit_files'] ?? '')[index]}&code=${RandomValueGeneratorUtil.generateRandomValue(context.read<AccountingBloc>().manageIncomingInvoiceMap["clientid"])}',
                                          mode: LaunchMode.externalApplication);
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: xxxTinierSpacing),
                                    child: Text(
                                        ViewImageUtil.viewImageList(context
                                                    .read<AccountingBloc>()
                                                    .manageIncomingInvoiceMap[
                                                'edit_files'] ??
                                            '')[index],
                                        style: const TextStyle(
                                            color: AppColor.deepBlue)),
                                  ));
                            }),
                      ),
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
