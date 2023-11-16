import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../../blocs/assets/assets_bloc.dart';
import '../../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../../blocs/pickAndUploadImage/pick_and_upload_image_states.dart';
import '../../../configs/app_color.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/primary_button.dart';
import '../../checklist/workforce/widgets/upload_image_section.dart';

class AssetsAddCommentScreen extends StatelessWidget {
  static const routeName = "AssetsSaveCommentScreen";
  static Map addAssetCommentMap = {};

  const AssetsAddCommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PickAndUploadImageBloc>().isInitialUpload = true;
    context.read<PickAndUploadImageBloc>().add(UploadInitial());
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText("AddComment")),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(tinierSpacing),
            child: BlocListener<AssetsBloc, AssetsState>(
                listener: (context, state) {
                  if (state is AssetsCommentsAdding) {
                    ProgressBar.show(context);
                  } else if (state is AssetsCommentsAdded) {
                    ProgressBar.dismiss(context);
                    showCustomSnackBar(
                        context, StringConstants.kCommentAdded, "");
                    Navigator.pop(context);
                  } else if (state is AssetsCommentsNotAdded) {
                    ProgressBar.dismiss(context);
                    showCustomSnackBar(context, state.errorMessage, "");
                  }
                },
                child: PrimaryButton(
                    onPressed: () {
                      context.read<AssetsBloc>().add(AddAssetsComments(
                          addAssetCommentMap: addAssetCommentMap));
                    },
                    textValue: StringConstants.kSave))),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing,
                bottom: leftRightMargin),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(StringConstants.kComment,
                  style: Theme.of(context).textTheme.xSmall.copyWith(
                      fontWeight: FontWeight.w500, color: AppColor.black)),
              const SizedBox(height: xxxTinierSpacing),
              TextFieldWidget(
                  onTextFieldChanged: (textField) {
                    addAssetCommentMap["comments"] = textField;
                  },
                  maxLines: 2),
              const SizedBox(height: tinierSpacing),
              Column(children: [
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
                      addAssetCommentMap["files"] = uploadLotoPhotosList
                          .toString()
                          .replaceAll("[", "")
                          .replaceAll("]", "");
                    })
              ])
            ])));
  }
}
