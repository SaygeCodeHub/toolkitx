import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_event.dart';
import 'package:toolkit/blocs/accounting/accounting_state.dart';
import 'package:toolkit/blocs/imagePickerBloc/image_picker_bloc.dart';
import 'package:toolkit/blocs/uploadImage/upload_image_bloc.dart';
import 'package:toolkit/blocs/uploadImage/upload_image_event.dart';
import 'package:toolkit/blocs/uploadImage/upload_image_state.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/accounting/outgoing_list_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_loading_popup.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';

class CreateOutgoingInvoiceBottomBar extends StatelessWidget {
  const CreateOutgoingInvoiceBottomBar({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  bool isValidField(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  bool isValidFileList(List<dynamic>? files) {
    return files != null && files.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UploadImageBloc, UploadImageState>(
          listener: (context, state) {
            if (state is UploadingImage) {
              GenericLoadingPopUp.show(context, StringConstants.kUploadFiles);
            } else if (state is ImageUploaded) {
              GenericLoadingPopUp.dismiss(context);
              context.read<AccountingBloc>().manageOutgoingInvoiceMap['files'] =
                  state.images
                      .toString()
                      .replaceAll('[', '')
                      .replaceAll(']', '')
                      .replaceAll(' ', '');
              context.read<AccountingBloc>().add(CreateOutgoingInvoice(
                  outgoingInvoiceId: context
                          .read<AccountingBloc>()
                          .manageOutgoingInvoiceMap['id'] ??
                      ""));
            } else if (state is ImageCouldNotUpload) {
              GenericLoadingPopUp.dismiss(context);
              showCustomSnackBar(context, state.errorMessage, '');
            }
          },
        ),
        // Listener for AccountingBloc states
        BlocListener<AccountingBloc, AccountingState>(
          listener: (context, state) {
            if (state is CreatingOutgoingInvoice) {
              ProgressBar.show(context);
            } else if (state is OutgoingInvoiceCreated) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                  context, OutgoingListScreen.routeName);
              context.read<AccountingBloc>().outgoingInvoices.clear();
              context.read<AccountingBloc>().manageOutgoingInvoiceMap.clear();
            } else if (state is FailedToCreateOutgoingInvoice) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(
                  context, "Failed To create Outgoing Invoice", '');
            }
          },
        ),
      ],
      child: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: PrimaryButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                textValue: StringConstants.kBack,
              ),
            ),
            const SizedBox(width: xxTinierSpacing),
            Expanded(
              child: PrimaryButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (isValidField(context
                            .read<AccountingBloc>()
                            .manageOutgoingInvoiceMap['invoiceamount']) &&
                        isValidFileList(context
                            .read<AccountingBloc>()
                            .manageOutgoingInvoiceMap['files'])) {
                      context.read<UploadImageBloc>().add(UploadImage(
                          images: context
                              .read<AccountingBloc>()
                              .manageOutgoingInvoiceMap['files'],
                          imageLength: context
                              .read<ImagePickerBloc>()
                              .lengthOfImageList));
                    } else {
                      showCustomSnackBar(
                          context,
                          StringConstants.kAmountAttachedDocumentsCanNotBeEmpty,
                          '');
                    }
                  }
                },
                textValue: StringConstants.kSave,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
