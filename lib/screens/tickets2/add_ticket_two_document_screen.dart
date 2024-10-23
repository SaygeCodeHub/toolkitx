import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../blocs/tickets2/tickets2_bloc.dart';
import '../../blocs/tickets2/tickets2_event.dart';
import '../../blocs/tickets2/tickets2_state.dart';
import '../../blocs/uploadImage/upload_image_bloc.dart';
import '../../blocs/uploadImage/upload_image_event.dart';
import '../../blocs/uploadImage/upload_image_state.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_loading_popup.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/progress_bar.dart';
import '../checklist/workforce/widgets/upload_image_section.dart';

class AddTicketTwoDocumentScreen extends StatelessWidget {
  AddTicketTwoDocumentScreen({super.key});

  static const routeName = 'AddTicketTwoDocumentScreen';

  final Map saveDocumentMap = {};

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
              TextField(
                  onChanged: (value) {
                    saveDocumentMap['comments'] = value;
                  },
                  cursorColor: AppColor.black,
                  decoration: InputDecoration(
                      counterText: '',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(color: AppColor.grey),
                      contentPadding: const EdgeInsets.all(xxTinierSpacing),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: AppColor.lightGrey)),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.lightGrey),
                      ),
                      filled: true,
                      fillColor: AppColor.white)),
              const SizedBox(height: xxTinierSpacing),
              UploadImageMenu(
                imagePickerBloc: ImagePickerBloc(),
                isUpload: true,
                onUploadImageResponse: (List uploadImageList) {
                  saveDocumentMap['fileList'] = uploadImageList;
                },
              ),
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
                      context.read<Tickets2Bloc>().add(SaveTicket2Document(
                          saveDocumentMap: saveDocumentMap));
                    } else if (state is ImageCouldNotUpload) {
                      GenericLoadingPopUp.dismiss(context);
                      showCustomSnackBar(context, state.errorMessage, '');
                    }
                  },
                ),
                BlocListener<Tickets2Bloc, Tickets2States>(
                  listener: (context, state) {
                    if (state is Ticket2DocumentSaving) {
                      ProgressBar.show(context);
                    } else if (state is Ticket2DocumentSaved) {
                      ProgressBar.dismiss(context);
                      Navigator.pop(context);
                      context.read<Tickets2Bloc>().add(FetchTicket2Details(
                          ticketId: context.read<Tickets2Bloc>().ticket2Id,
                          ticketTabIndex: 0));
                    } else if (state is Ticket2DocumentNotSaved) {
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
                      showCustomSnackBar(
                          context, StringConstants.kPleaseAttachDocument, '');
                    }
                  },
                  textValue: DatabaseUtil.getText('Submit')),
            )));
  }
}
