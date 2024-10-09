import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/accounting/accounting_bloc.dart';
import '../../../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../../../blocs/uploadImage/upload_image_bloc.dart';
import '../../../../blocs/uploadImage/upload_image_event.dart';
import '../../../../widgets/custom_snackbar.dart';
import 'manage_accounting_incoming_invoice_section.dart';

bool validateForm(dynamic value) {
  return value == null || value.toString().isEmpty;
}

String showValidationMessage(String key) {
  const String selectMessage = 'Please select';
  const String addMessage = 'Please add';
  switch (key) {
    case 'entity':
      return '$selectMessage entity';
    case 'billable':
      return '$selectMessage billable';
    case 'date':
      return 'Please add invoice date';
    case 'purposename':
      return '$addMessage purpose of payment';
    case 'mode':
      return '$selectMessage mode of payment';
    case 'creditcard':
      return '$selectMessage credit card';
    case 'othercurrency':
      return '$selectMessage currency';
    case 'otherinvoiceamount':
      return '$addMessage other amount';
    case 'invoiceamount':
      return '$addMessage amount';
    case 'files':
      return '$addMessage files';
    default:
      return '';
  }
}

void validateAndProceed(BuildContext context) {
  if (validateForm(
          context.read<AccountingBloc>().manageIncomingInvoiceMap['entity']) ||
      validateForm(context
          .read<AccountingBloc>()
          .manageIncomingInvoiceMap['billable'])) {
    showCustomSnackBar(context, 'Please select entity & billable', '');
  } else if (context
              .read<AccountingBloc>()
              .manageIncomingInvoiceMap['billable'] ==
          '1' &&
      validateForm(
          context.read<AccountingBloc>().manageIncomingInvoiceMap['client']) &&
      validateForm(
          context.read<AccountingBloc>().manageIncomingInvoiceMap['project'])) {
    showCustomSnackBar(context, 'Please select client & project', '');
  } else if (validateForm(
      context.read<AccountingBloc>().manageIncomingInvoiceMap['date'])) {
    showCustomSnackBar(context, showValidationMessage('date'), '');
  } else if (validateForm(
      context.read<AccountingBloc>().manageIncomingInvoiceMap['purposename'])) {
    showCustomSnackBar(context, showValidationMessage('purposename'), '');
  } else if (validateForm(
      context.read<AccountingBloc>().manageIncomingInvoiceMap['mode'])) {
    showCustomSnackBar(context, showValidationMessage('mode'), '');
  } else if (context.read<AccountingBloc>().manageIncomingInvoiceMap['mode'] ==
          '2' &&
      validateForm(context
          .read<AccountingBloc>()
          .manageIncomingInvoiceMap['creditcard'])) {
    showCustomSnackBar(context, showValidationMessage('creditcard'), '');
  } else if (context.read<AccountingBloc>().manageIncomingInvoiceMap['other'] ==
          'Other' &&
      validateForm(context
          .read<AccountingBloc>()
          .manageIncomingInvoiceMap['othercurrency'])) {
    showCustomSnackBar(context, showValidationMessage('othercurrency'), '');
  } else {
    context
        .read<AccountingBloc>()
        .manageIncomingInvoiceMap['otherinvoiceamount'] = '';
    context.read<AccountingBloc>().manageIncomingInvoiceMap['invoiceamount'] =
        '';
    context.read<AccountingBloc>().manageIncomingInvoiceMap['files'] = '';
    Navigator.pushNamed(
        context, ManageAccountingIncomingInvoiceSection.routeName);
  }
}

void validateFormAndProceed(BuildContext context) {
  if (validateForm(context
      .read<AccountingBloc>()
      .manageIncomingInvoiceMap['invoiceamount'])) {
    showCustomSnackBar(context, showValidationMessage('invoiceamount'), '');
  } else if (context.read<AccountingBloc>().manageIncomingInvoiceMap['other'] ==
          'Other' &&
      validateForm(context
          .read<AccountingBloc>()
          .manageIncomingInvoiceMap['otherinvoiceamount'])) {
    showCustomSnackBar(
        context, showValidationMessage('otherinvoiceamount'), '');
  } else if (validateForm(
      context.read<AccountingBloc>().manageIncomingInvoiceMap['files'])) {
    showCustomSnackBar(context, showValidationMessage('files'), '');
  } else {
    context.read<UploadImageBloc>().add(UploadImage(
        images:
            context.read<AccountingBloc>().manageIncomingInvoiceMap['files'],
        imageLength: context.read<ImagePickerBloc>().lengthOfImageList));
  }
}
