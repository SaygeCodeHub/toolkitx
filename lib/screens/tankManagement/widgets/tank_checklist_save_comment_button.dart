import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/tankManagement/tank_management_bloc.dart';
import '../../../../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../../../../blocs/uploadImage/upload_image_bloc.dart';
import '../../../../../blocs/uploadImage/upload_image_event.dart';
import '../../../../../blocs/uploadImage/upload_image_state.dart';
import '../../../../../utils/constants/string_constants.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../../../../widgets/generic_loading_popup.dart';
import '../../../../../widgets/primary_button.dart';
import '../../../../../widgets/progress_bar.dart';

class TankChecklistSaveCommentButton extends StatelessWidget {
  const TankChecklistSaveCommentButton({
    super.key,
    required this.saveQuestionCommentsMap,
  });

  final Map saveQuestionCommentsMap;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TankManagementBloc, TankManagementState>(
          listener: (context, state) {
            if (state is TankQuestionCommentsSaving) {
              ProgressBar.show(context);
            } else if (state is TankQuestionCommentsSaved) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
            } else if (state is TankQuestionCommentsNotSaved) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.errorMessage, '');
            }
          },
        ),
        BlocListener<UploadImageBloc, UploadImageState>(
          listener: (context, state) {
            if (state is UploadingImage) {
              GenericLoadingPopUp.show(context, StringConstants.kUploadFiles);
            } else if (state is ImageUploaded) {
              GenericLoadingPopUp.dismiss(context);
              saveQuestionCommentsMap['filenames'] = state.images
                  .toString()
                  .replaceAll('[', '')
                  .replaceAll(']', '')
                  .replaceAll(' ', '');
              if (saveQuestionCommentsMap['comments'] != null ||
                  saveQuestionCommentsMap['comments'] != '') {
                context.read<TankManagementBloc>().add(
                    SaveTankQuestionsComments(
                        tankCommentsMap: saveQuestionCommentsMap));
              }
            } else if (state is ImageCouldNotUpload) {
              GenericLoadingPopUp.dismiss(context);
              showCustomSnackBar(context, state.errorMessage, '');
            }
          },
        ),
      ],
      child: PrimaryButton(
          onPressed: () {
            if (saveQuestionCommentsMap["pickedImage"] != null &&
                saveQuestionCommentsMap["pickedImage"].isNotEmpty) {
              context.read<UploadImageBloc>().add(UploadImage(
                  images: saveQuestionCommentsMap["pickedImage"],
                  imageLength:
                      context.read<ImagePickerBloc>().lengthOfImageList));
            } else {
              context.read<TankManagementBloc>().add(
                  SaveTankQuestionsComments(
                      tankCommentsMap: saveQuestionCommentsMap));
            }
          },
          textValue: StringConstants.kSave),
    );
  }
}
