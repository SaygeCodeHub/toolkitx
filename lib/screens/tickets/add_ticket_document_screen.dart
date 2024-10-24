import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../blocs/tickets/tickets_bloc.dart';
import '../../blocs/uploadImage/upload_image_bloc.dart';
import '../../blocs/uploadImage/upload_image_event.dart';
import '../../blocs/uploadImage/upload_image_state.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_loading_popup.dart';
import '../../widgets/generic_text_field.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/progress_bar.dart';
import '../accounting/widgets/attach_document_widget.dart';

class AddTicketDocumentScreen extends StatelessWidget {
  const AddTicketDocumentScreen({super.key});

  static const routeName = 'AddTicketDocumentScreen';

  static Map saveDocumentMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('AddDocuments')),
        body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DatabaseUtil.getText('Comments'),
                  style: Theme.of(context).textTheme.small.copyWith(
                      fontWeight: FontWeight.w500, color: AppColor.black)),
              const SizedBox(height: tiniestSpacing),
              TextFieldWidget(
                maxLines: 3,
                onTextFieldChanged: (textField) {
                  saveDocumentMap['comments'] = textField;
                },
              ),
              const SizedBox(height: xxTinierSpacing),
              AttachDocumentWidget(
                  titleName: DatabaseUtil.getText('upload_docs'),
                  onUploadDocument: (uploadDocList) {
                    saveDocumentMap['fileList'] = uploadDocList;
                  },
                  imagePickerBloc: ImagePickerBloc())
            ],
          ),
        ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(xxTinierSpacing),
            child: MultiBlocListener(
              listeners: [
                BlocListener<UploadImageBloc, UploadImageState>(
                  listener: (context, state) {
                    if (state is UploadingImage) {
                      GenericLoadingPopUp.show(
                          context, StringConstants.kUploadFiles);
                    } else if (state is ImageUploaded) {
                      GenericLoadingPopUp.dismiss(context);
                      saveDocumentMap['fileName'] = state.images
                          .toString()
                          .replaceAll('[', '')
                          .replaceAll(']', '')
                          .replaceAll(' ', '');
                      if (saveDocumentMap['comments'] != null ||
                          saveDocumentMap['comments'] != '') {
                        context.read<TicketsBloc>().add(SaveTicketDocument(
                            saveDocumentMap: saveDocumentMap));
                      }
                    } else if (state is ImageCouldNotUpload) {
                      GenericLoadingPopUp.dismiss(context);
                      showCustomSnackBar(context, state.errorMessage, '');
                    }
                  },
                ),
                BlocListener<TicketsBloc, TicketsStates>(
                  listener: (context, state) {
                    if (state is TicketDocumentSaving) {
                      ProgressBar.show(context);
                    } else if (state is TicketDocumentSaved) {
                      ProgressBar.dismiss(context);
                      Navigator.pop(context);
                      context.read<TicketsBloc>().add(FetchTicketDetails(
                          ticketId: context.read<TicketsBloc>().ticketId,
                          ticketTabIndex: 0));
                    } else if (state is TicketDocumentNotSaved) {
                      ProgressBar.dismiss(context);
                      showCustomSnackBar(context, state.errorMessage, '');
                    }
                  },
                ),
              ],
              child: PrimaryButton(
                  onPressed: () {
                    if (saveDocumentMap['fileList'] != null &&
                        saveDocumentMap['fileList'].isNotEmpty) {
                      context.read<UploadImageBloc>().add(UploadImage(
                          images: saveDocumentMap['fileList'],
                          imageLength: context
                              .read<ImagePickerBloc>()
                              .lengthOfImageList));
                    } else {
                      context.read<TicketsBloc>().add(
                          SaveTicketDocument(saveDocumentMap: saveDocumentMap));
                    }
                  },
                  textValue: DatabaseUtil.getText('Submit')),
            )));
  }
}
