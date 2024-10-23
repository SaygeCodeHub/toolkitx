import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';

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
import '../../incoming_invoices_screen.dart';
import 'accounting_invoice_validator.dart';

class CreateIncomingInvoiceBottomBar extends StatelessWidget {
  final bool isFromEdit;

  const CreateIncomingInvoiceBottomBar({super.key, required this.isFromEdit});

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
              context.read<AccountingBloc>().manageIncomingInvoiceMap['files'] =
                  state.images
                      .toString()
                      .replaceAll('[', '')
                      .replaceAll(']', '')
                      .replaceAll(' ', '');
              context.read<AccountingBloc>().add(CreateIncomingInvoice(
                  incomingInvoiceId: context
                          .read<AccountingBloc>()
                          .manageIncomingInvoiceMap['id'] ??
                      ""));
            } else if (state is ImageCouldNotUpload) {
              GenericLoadingPopUp.dismiss(context);
              showCustomSnackBar(context, state.errorMessage, '');
            }
          },
        ),
        BlocListener<AccountingBloc, AccountingState>(
          listener: (context, state) {
            if (state is CreatingIncomingInvoice) {
              ProgressBar.show(context);
            } else if (state is IncomingInvoiceCreated) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                  context, IncomingInvoicesScreen.routeName);
              context.read<AccountingBloc>().incomingInvoices.clear();
            } else if (state is FailedToCreateIncomingInvoice) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.errorMessage, '');
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
                textValue: StringConstants.kBack),
          ),
          const SizedBox(width: xxTinierSpacing),
          Expanded(
              child: PrimaryButton(
                  onPressed: () {
                    validateFormAndProceed(context, isFromEdit);
                  },
                  textValue: StringConstants.kSave)),
        ],
      )),
    );
  }
}
