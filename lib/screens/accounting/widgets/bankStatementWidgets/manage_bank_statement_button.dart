import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/accounting/widgets/bankStatementWidgets/validate_manage_bank_statement_form.dart';
import '../../../../blocs/accounting/accounting_bloc.dart';
import '../../../../blocs/accounting/accounting_event.dart';
import '../../../../blocs/accounting/accounting_state.dart';
import '../../../../blocs/uploadImage/upload_image_bloc.dart';
import '../../../../blocs/uploadImage/upload_image_state.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../../widgets/generic_loading_popup.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/progress_bar.dart';

class ManageBankStatementButton extends StatelessWidget {
  final bool isFromEdit;

  const ManageBankStatementButton({super.key, required this.isFromEdit});

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
                  textValue: StringConstants.kBack)),
          const SizedBox(width: xxTinierSpacing),
          Expanded(
            child: MultiBlocListener(
              listeners: [
                BlocListener<UploadImageBloc, UploadImageState>(
                  listener: (context, state) {
                    if (state is UploadingImage) {
                      GenericLoadingPopUp.show(
                          context, StringConstants.kUploadFiles);
                    } else if (state is ImageUploaded) {
                      GenericLoadingPopUp.dismiss(context);
                      List uploadedImages = state.images;
                      if (uploadedImages.isNotEmpty && isFromEdit) {
                        uploadedImages = [
                          ...state.images,
                          ...context
                              .read<AccountingBloc>()
                              .manageBankStatementMap['view_files']
                              .toString()
                              .split(',')
                        ];
                      }
                      context
                              .read<AccountingBloc>()
                              .manageBankStatementMap['files'] =
                          uploadedImages
                              .toString()
                              .replaceAll('[', '')
                              .replaceAll(']', '')
                              .replaceAll(' ', '');
                      context.read<AccountingBloc>().add(ManageBankStatement());
                    } else if (state is ImageCouldNotUpload) {
                      GenericLoadingPopUp.dismiss(context);
                      showCustomSnackBar(context, state.errorMessage, '');
                    }
                  },
                ),
                BlocListener<AccountingBloc, AccountingState>(
                  listener: (context, state) {
                    if (state is ManagingBankStatement) {
                      ProgressBar.show(context);
                    } else if (state is BankStatementManaged) {
                      ProgressBar.dismiss(context);
                      Navigator.pop(context);
                      context.read<AccountingBloc>().bankStatements.clear();
                      context
                          .read<AccountingBloc>()
                          .manageBankStatementMap
                          .clear();
                      context
                          .read<AccountingBloc>()
                          .add(FetchBankStatements(pageNo: 1));
                    } else if (state is FailedToManageBankStatement) {
                      ProgressBar.dismiss(context);
                      showCustomSnackBar(context, state.errorMessage, '');
                    }
                  },
                ),
              ],
              child: PrimaryButton(
                  onPressed: () {
                    validateBankStatementFormAndProceed(context, isFromEdit);
                  },
                  textValue: StringConstants.kSave),
            ),
          ),
        ],
      ),
    );
  }
}
