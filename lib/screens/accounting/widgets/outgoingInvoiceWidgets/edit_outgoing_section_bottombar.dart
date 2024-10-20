import 'dart:developer';

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

class EditOutgoingSectionBottomBar extends StatelessWidget {
  const EditOutgoingSectionBottomBar({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  //
  // bool isInvalidField(String? value) {
  //   return value == null || value.trim().isEmpty;
  // }
  //
  // bool isInvalidFileList(List<dynamic>? files) {
  //   return files == null || files.isEmpty;
  // }
  bool isValidField(String? value) {
    if (value is List) {
      return value == null || value.isEmpty;
    } else {
      return value == null || value.trim().isEmpty;
    }
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
              List uploadedImages = state.images;
              if (uploadedImages.isNotEmpty) {
                uploadedImages = [
                  ...state.images,
                  ...context
                      .read<AccountingBloc>()
                      .manageOutgoingInvoiceMap['edit_files']
                      .toString()
                      .split(',')
                ];
              }
              log('uploadedImages $uploadedImages');
              log('map ${context.read<AccountingBloc>().manageOutgoingInvoiceMap}');
              context.read<AccountingBloc>().manageOutgoingInvoiceMap['files'] =
                  uploadedImages
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
        // Listener for AccountingBloc
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
                        .manageOutgoingInvoiceMap['invoiceamount'])) {
                      showCustomSnackBar(
                          context,
                          StringConstants.kAmountAttachedDocumentsCanNotBeEmpty,
                          '');
                    } else if (context
                            .read<AccountingBloc>()
                            .manageOutgoingInvoiceMap['files'] ==
                        null) {
                      context
                              .read<AccountingBloc>()
                              .manageOutgoingInvoiceMap['files'] =
                          context
                              .read<AccountingBloc>()
                              .manageOutgoingInvoiceMap['edit_files'];
                      context.read<AccountingBloc>().add(CreateOutgoingInvoice(
                          outgoingInvoiceId: context
                                  .read<AccountingBloc>()
                                  .manageOutgoingInvoiceMap['id'] ??
                              ""));
                    } else if (context
                        .read<AccountingBloc>()
                        .manageOutgoingInvoiceMap['files']
                        .isEmpty) {
                      context
                              .read<AccountingBloc>()
                              .manageOutgoingInvoiceMap['files'] =
                          context
                              .read<AccountingBloc>()
                              .manageOutgoingInvoiceMap['edit_files'];
                      context.read<AccountingBloc>().add(CreateOutgoingInvoice(
                          outgoingInvoiceId: context
                                  .read<AccountingBloc>()
                                  .manageOutgoingInvoiceMap['id'] ??
                              ""));
                    } else {
                      context.read<UploadImageBloc>().add(UploadImage(
                          images: context
                              .read<AccountingBloc>()
                              .manageOutgoingInvoiceMap['files'],
                          imageLength: context
                              .read<ImagePickerBloc>()
                              .lengthOfImageList));
                    }
                  }
                  //   if (context.read<AccountingBloc>().manageOutgoingInvoiceMap['files'] ==
                  //       null ||
                  //       context.read<AccountingBloc>().manageOutgoingInvoiceMap['files'] ==
                  //           []) {
                  //     context.read<AccountingBloc>().add(CreateOutgoingInvoice(
                  //         outgoingInvoiceId:
                  //         context.read<AccountingBloc>().manageOutgoingInvoiceMap['id'] ??
                  //             ''));
                  //     context.read<AccountingBloc>().add(FetchOutgoingInvoices(pageNo: 1));
                  //   } else {
                  //     print("data======>${context.read<AccountingBloc>().manageOutgoingInvoiceMap['files'].runtimeType}");
                  //     context.read<UploadImageBloc>().add(UploadImage(
                  //         images:
                  //         context.read<AccountingBloc>().manageOutgoingInvoiceMap['files'],
                  //         imageLength: context.read<ImagePickerBloc>().lengthOfImageList));
                  //   }
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
