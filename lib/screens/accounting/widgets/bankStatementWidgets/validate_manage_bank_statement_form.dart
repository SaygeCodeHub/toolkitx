import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import '../../../../blocs/accounting/accounting_bloc.dart';
import '../../../../blocs/accounting/accounting_event.dart';
import '../../../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../../../blocs/uploadImage/upload_image_bloc.dart';
import '../../../../blocs/uploadImage/upload_image_event.dart';

bool validateForm(dynamic value) {
  if (value is List) {
    return value == [] || value.isEmpty;
  } else {
    return value == null || value.toString().isEmpty;
  }
}

validateBankStatementFormAndProceed(BuildContext context, bool isFromEdit) {
  if (isFromEdit) {
    context.read<AccountingBloc>().manageBankStatementMap.remove('view_files');
    if (context.read<AccountingBloc>().manageBankStatementMap['files'] ==
        null) {
      context.read<AccountingBloc>().add(ManageBankStatement());
    } else if (context
        .read<AccountingBloc>()
        .manageBankStatementMap['files']
        .isEmpty) {
      context.read<AccountingBloc>().add(ManageBankStatement());
    } else {
      context.read<UploadImageBloc>().add(UploadImage(
          images:
              context.read<AccountingBloc>().manageBankStatementMap['files'],
          imageLength: context.read<ImagePickerBloc>().lengthOfImageList));
    }
  } else {
    if (validateForm(
            context.read<AccountingBloc>().manageBankStatementMap['entity']) ||
        validateForm(
            context.read<AccountingBloc>().manageBankStatementMap['bank']) ||
        validateForm(
            context.read<AccountingBloc>().manageBankStatementMap['month']) ||
        validateForm(
            context.read<AccountingBloc>().manageBankStatementMap['year']) ||
        validateForm(
            context.read<AccountingBloc>().manageBankStatementMap['files'])) {
      showCustomSnackBar(context, StringConstants.kAllFieldsMandatory, '');
    } else {
      context.read<UploadImageBloc>().add(UploadImage(
          images:
              context.read<AccountingBloc>().manageBankStatementMap['files'],
          imageLength: context.read<ImagePickerBloc>().lengthOfImageList));
    }
  }
}
