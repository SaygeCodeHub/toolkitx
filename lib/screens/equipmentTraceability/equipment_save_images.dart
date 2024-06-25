import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/equipmentTraceability/equipment_traceability_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/workforce/widgets/upload_image_section.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';
import '../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../blocs/uploadImage/upload_image_bloc.dart';
import '../../blocs/uploadImage/upload_image_event.dart';
import '../../blocs/uploadImage/upload_image_state.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_loading_popup.dart';
import '../../widgets/progress_bar.dart';

class EquipmentSaveImages extends StatelessWidget {
  EquipmentSaveImages({super.key});

  static const routeName = 'EquipmentSaveImages';
  final Map saveImagesMap = {};

  @override
  Widget build(BuildContext context) {
    context.read<PickAndUploadImageBloc>().isInitialUpload = true;
    context.read<PickAndUploadImageBloc>().add(UploadInitial());
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kUploadImages),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(leftRightMargin),
          child: MultiBlocListener(
            listeners: [
              BlocListener<EquipmentTraceabilityBloc,
                  EquipmentTraceabilityState>(
                listener: (context, state) {
                  if (state is EquipmentImageSaving) {
                    ProgressBar.show(context);
                  } else if (state is EquipmentImageSaved) {
                    ProgressBar.dismiss(context);
                    showCustomSnackBar(
                        context, StringConstants.kSavedSuccessfully, '');
                    Navigator.pop(context);
                  } else if (state is EquipmentImageNotSaved) {
                    ProgressBar.dismiss(context);
                    showCustomSnackBar(context, state.errorMessage, '');
                  }
                },
              ),
              BlocListener<UploadImageBloc, UploadImageState>(
                listener: (context, state) {
                  if (state is UploadingImage) {
                    GenericLoadingPopUp.show(
                        context, StringConstants.kUploadFiles);
                  } else if (state is ImageUploaded) {
                    GenericLoadingPopUp.dismiss(context);
                    saveImagesMap['filename'] = state.images
                        .toString()
                        .replaceAll('[', '')
                        .replaceAll(']', '')
                        .replaceAll(' ', '');
                    context
                        .read<EquipmentTraceabilityBloc>()
                        .add(EquipmentSaveImage(saveImagesMap: saveImagesMap));
                  } else if (state is ImageCouldNotUpload) {
                    GenericLoadingPopUp.dismiss(context);
                    showCustomSnackBar(context, state.errorMessage, '');
                  }
                },
              ),
            ],
            child: PrimaryButton(
              onPressed: () {
                if (saveImagesMap["pickedImage"] != null &&
                    saveImagesMap["pickedImage"].isNotEmpty) {
                  context.read<UploadImageBloc>().add(UploadImage(
                      images: saveImagesMap["pickedImage"],
                      imageLength:
                          context.read<ImagePickerBloc>().lengthOfImageList));
                }
              },
              textValue: StringConstants.kSubmit,
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(children: [
                  const SizedBox(height: tinySpacing),
                  UploadImageMenu(
                    isUpload: true,
                    onUploadImageResponse: (List uploadPhotosList) {
                      saveImagesMap["pickedImage"] = uploadPhotosList;
                    },
                  )
                ]),
                const SizedBox(height: xxTinierSpacing),
                Text(StringConstants.kNote,
                    style: Theme.of(context).textTheme.small.copyWith(
                        color: AppColor.black, fontWeight: FontWeight.w500)),
                const SizedBox(height: xxTinierSpacing),
                TextFieldWidget(
                  onTextFieldChanged: (textField) {
                    saveImagesMap['notes'] = textField;
                  },
                )
              ],
            )));
  }
}
