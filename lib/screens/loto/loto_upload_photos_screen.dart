import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../blocs/loto/loto_details/loto_details_bloc.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_states.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/progress_bar.dart';
import '../checklist/workforce/widgets/upload_image_section.dart';

class LotoUploadPhotosScreen extends StatelessWidget {
  static const routeName = 'LotoUploadPhotosScreen';
  final Map lotoUploadPhotosMap = {};

  LotoUploadPhotosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PickAndUploadImageBloc>().isInitialUpload = true;
    context.read<PickAndUploadImageBloc>().add(UploadInitial());
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
                child: BlocListener<LotoDetailsBloc, LotoDetailsState>(
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
                        showCustomSnackBar(
                            context, StringConstants.kSomethingWentWrong, '');
                      }
                    },
                    child: PrimaryButton(
                        onPressed: () {
                          context.read<LotoDetailsBloc>().add(LotoUploadPhotos(
                              filename: lotoUploadPhotosMap["filename"]));
                        },
                        textValue: DatabaseUtil.getText("Submit"))))
          ]),
        ),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: tinySpacing),
            child: Column(children: [
              BlocBuilder<PickAndUploadImageBloc, PickAndUploadImageStates>(
                  buildWhen: (previousState, currentState) =>
                      currentState is ImagePickerLoaded,
                  builder: (context, state) {
                    if (state is ImagePickerLoaded) {
                      return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(StringConstants.kUploadPhoto,
                                style: Theme.of(context)
                                    .textTheme
                                    .small
                                    .copyWith(
                                        color: AppColor.black,
                                        fontWeight: FontWeight.w500)),
                            Text(
                                '${(context.read<PickAndUploadImageBloc>().isInitialUpload == true) ? 0 : state.incrementNumber}/6',
                                style: Theme.of(context)
                                    .textTheme
                                    .small
                                    .copyWith(
                                        color: AppColor.black,
                                        fontWeight: FontWeight.w500)),
                          ]);
                    } else {
                      return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(StringConstants.kUploadPhoto,
                                style: Theme.of(context)
                                    .textTheme
                                    .small
                                    .copyWith(
                                        color: AppColor.black,
                                        fontWeight: FontWeight.w500)),
                            Text('0/6',
                                style: Theme.of(context)
                                    .textTheme
                                    .small
                                    .copyWith(
                                        color: AppColor.black,
                                        fontWeight: FontWeight.w500)),
                          ]);
                    }
                  }),
              const SizedBox(height: tinySpacing),
              UploadImageMenu(
                isUpload: true,
                onUploadImageResponse: (List uploadLotoPhotosList) {
                  lotoUploadPhotosMap["filename"] = uploadLotoPhotosList
                      .toString()
                      .replaceAll("[", "")
                      .replaceAll("]", "");
                },
              )
            ])));
  }
}
