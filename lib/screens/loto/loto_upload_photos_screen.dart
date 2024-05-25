import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../blocs/loto/loto_details/loto_details_bloc.dart';
import '../../blocs/uploadImage/upload_image_bloc.dart';
import '../../blocs/uploadImage/upload_image_event.dart';
import '../../blocs/uploadImage/upload_image_state.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_loading_popup.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/progress_bar.dart';
import '../checklist/workforce/widgets/upload_image_section.dart';

class LotoUploadPhotosScreen extends StatelessWidget {
  static const routeName = 'LotoUploadPhotosScreen';
  final Map lotoUploadPhotosMap = {};

  LotoUploadPhotosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('UploadPhotos')),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(leftRightMargin),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
              height: kErrorButtonHeight,
              width: xxxSizedBoxWidth,
              child: PrimaryButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  textValue: DatabaseUtil.getText("buttonBack")),
            ),
            SizedBox(
                height: kErrorButtonHeight,
                width: xxSizedBoxWidth,
                child: MultiBlocListener(
                  listeners: [
                    BlocListener<LotoDetailsBloc, LotoDetailsState>(
                      listener: (context, state) {
                        if (state is LotoPhotosUploading) {
                          ProgressBar.show(context);
                        } else if (state is LotoPhotosUploaded) {
                          ProgressBar.dismiss(context);
                          showCustomSnackBar(
                              context, StringConstants.kPhotosUploaded, '');
                          Navigator.pop(context);
                        } else if (state is LotoPhotosNotUploaded) {
                          ProgressBar.dismiss(context);
                          showCustomSnackBar(context, state.getError, '');
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
                          lotoUploadPhotosMap['ImageString'] = state.images
                              .toString()
                              .replaceAll('[', '')
                              .replaceAll(']', '')
                              .replaceAll(' ', '');
                          context.read<LotoDetailsBloc>().add(LotoUploadPhotos(
                              filename: lotoUploadPhotosMap["ImageString"]));
                        } else if (state is ImageCouldNotUpload) {
                          GenericLoadingPopUp.dismiss(context);
                          showCustomSnackBar(context, state.errorMessage, '');
                        }
                      },
                    ),
                  ],
                  child: PrimaryButton(
                      onPressed: () {
                        if (lotoUploadPhotosMap['filename'] != null &&
                            lotoUploadPhotosMap['filename'].isNotEmpty) {
                          context.read<UploadImageBloc>().add(UploadImage(
                              images: lotoUploadPhotosMap['filename'],
                              imageLength: context
                                  .read<ImagePickerBloc>()
                                  .lengthOfImageList));
                        }
                      },
                      textValue: DatabaseUtil.getText("Submit")),
                ))
          ]),
        ),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: tinySpacing),
            child: Column(children: [
              const SizedBox(height: tinySpacing),
              UploadImageMenu(
                isUpload: true,
                onUploadImageResponse: (List uploadLotoPhotosList) {
                  lotoUploadPhotosMap["filename"] = uploadLotoPhotosList;
                },
              )
            ])));
  }
}
