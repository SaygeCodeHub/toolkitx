import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/imagePickerBloc/image_picker_bloc.dart';
import 'package:toolkit/blocs/uploadImage/upload_image_bloc.dart';
import 'package:toolkit/blocs/uploadImage/upload_image_event.dart';
import 'package:toolkit/blocs/uploadImage/upload_image_state.dart';
import '../../../blocs/safetyNotice/safety_notice_bloc.dart';
import '../../../blocs/safetyNotice/safety_notice_events.dart';
import '../../../blocs/safetyNotice/safety_notice_states.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_loading_popup.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/progress_bar.dart';
import '../add_and_edit_safety_notice_screen.dart';
import '../safety_notice_screen.dart';

class SafetyNoticeAddAndEditBottomAppBar extends StatelessWidget {
  final Map manageSafetyNoticeMap;
  static bool compareLength = false;

  const SafetyNoticeAddAndEditBottomAppBar(
      {Key? key, required this.manageSafetyNoticeMap})
      : super(key: key);

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
            textValue: DatabaseUtil.getText('buttonBack'),
          )),
          const SizedBox(width: xxTinierSpacing),
          MultiBlocListener(
            listeners: [
              BlocListener<UploadImageBloc, UploadImageState>(
                  listener: (context, state) {
                if (state is UploadingImage) {
                  GenericLoadingPopUp.show(
                      context, StringConstants.kUploadFiles);
                } else if (state is ImageUploaded) {
                  if (AddAndEditSafetyNoticeScreen.isFromEditOption == true) {
                    compareLength = true;
                    manageSafetyNoticeMap['file_name'] = state.images
                        .toString()
                        .replaceAll('[', '')
                        .replaceAll(']', '')
                        .replaceAll(' ', '');
                    context.read<SafetyNoticeBloc>().add(UpdateSafetyNotice(
                        updateSafetyNoticeMap: manageSafetyNoticeMap));
                  } else {
                    compareLength = true;
                    manageSafetyNoticeMap['file_name'] = state.images
                        .toString()
                        .replaceAll('[', '')
                        .replaceAll(']', '')
                        .replaceAll(' ', '');
                    context.read<SafetyNoticeBloc>().add(AddSafetyNotice(
                        addSafetyNoticeMap: manageSafetyNoticeMap));
                  }
                } else if (state is ImageCouldNotUpload) {
                  showCustomSnackBar(context, state.errorMessage, '');
                }
              }),
              BlocListener<SafetyNoticeBloc, SafetyNoticeStates>(
                  listener: (context, state) {
                if (state is AddingSafetyNotice) {
                  ProgressBar.show(context);
                } else if (state is SafetyNoticeAdded) {
                  ProgressBar.dismiss(context);
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(
                      context, SafetyNoticeScreen.routeName,
                      arguments: false);
                } else if (state is SafetyNoticeNotAdded) {
                  ProgressBar.dismiss(context);
                  showCustomSnackBar(context, state.errorMessage, '');
                }
                if (state is SavingSafetyNoticeFiles) {
                  GenericLoadingPopUp.show(
                      context, StringConstants.kUploadFiles);
                } else if (state is SafetyNoticeFilesSaved) {
                  GenericLoadingPopUp.dismiss(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(
                      context, SafetyNoticeScreen.routeName,
                      arguments: false);
                } else if (state is SafetyNoticeFilesNotSaved) {
                  GenericLoadingPopUp.dismiss(context);
                  showCustomSnackBar(context, state.filesNotSaved, '');
                }
                if (state is UpdatingSafetyNotice) {
                  ProgressBar.show(context);
                } else if (state is SafetyNoticeUpdated) {
                  ProgressBar.dismiss(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(
                      context, SafetyNoticeScreen.routeName,
                      arguments: false);
                } else if (state is SafetyNoticeCouldNotUpdate) {
                  ProgressBar.dismiss(context);
                  showCustomSnackBar(context, state.noticeNotUpdated, '');
                }
              }),
            ],
            child: Expanded(
                child: PrimaryButton(
                    onPressed: () {
                      if (context
                                  .read<ImagePickerBloc>()
                                  .pickedImagesList
                                  .length !=
                              context
                                  .read<ImagePickerBloc>()
                                  .lengthOfImageList &&
                          manageSafetyNoticeMap['file_name'] != null &&
                          manageSafetyNoticeMap['file_name'] != '') {
                        context.read<UploadImageBloc>().add(UploadImage(
                            images: manageSafetyNoticeMap['file_name'],
                            imageLength: context
                                .read<ImagePickerBloc>()
                                .lengthOfImageList));
                      } else {
                        if (AddAndEditSafetyNoticeScreen.isFromEditOption ==
                            true) {
                          compareLength = false;
                          context.read<SafetyNoticeBloc>().add(
                              UpdateSafetyNotice(
                                  updateSafetyNoticeMap:
                                      manageSafetyNoticeMap));
                        } else {
                          compareLength = false;
                          context.read<SafetyNoticeBloc>().add(AddSafetyNotice(
                              addSafetyNoticeMap: manageSafetyNoticeMap));
                        }
                      }
                    },
                    textValue: DatabaseUtil.getText('Save'))),
          ),
        ],
      ),
    );
  }
}
