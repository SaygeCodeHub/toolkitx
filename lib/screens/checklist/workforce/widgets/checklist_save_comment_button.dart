import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/checklist/workforce/comments/workforce_checklist_comments_bloc.dart';
import '../../../../blocs/checklist/workforce/comments/workforce_checklist_comments_events.dart';
import '../../../../blocs/checklist/workforce/comments/workforce_checklist_comments_states.dart';
import '../../../../blocs/checklist/workforce/getQuestionsList/workforce_checklist_get_questions_list_bloc.dart';
import '../../../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../../../blocs/uploadImage/upload_image_bloc.dart';
import '../../../../blocs/uploadImage/upload_image_event.dart';
import '../../../../blocs/uploadImage/upload_image_state.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../../widgets/generic_loading_popup.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/progress_bar.dart';
import '../workforce_questions_list_screen.dart';

class ChecklistSaveCommentButton extends StatelessWidget {
  const ChecklistSaveCommentButton({
    super.key,
    required this.saveQuestionCommentsMap,
  });

  final Map saveQuestionCommentsMap;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<WorkForceCheckListCommentBloc,
            WorkForceCheckListCommentStates>(
          listener: (context, state) {
            if (state is CheckListSavingComment) {
              ProgressBar.show(context);
            } else if (state is CheckListCommentSaved) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                  context, WorkForceQuestionsScreen.routeName,
                  arguments: context
                      .read<WorkForceQuestionsListBloc>()
                      .allDataForChecklistMap);
            } else if (state is CheckListCommentNotSaved) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.message, StringConstants.kOk);
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
                context.read<WorkForceCheckListCommentBloc>().add(
                    CheckListSaveComment(
                        saveQuestionCommentMap: saveQuestionCommentsMap));
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
              context.read<WorkForceCheckListCommentBloc>().add(
                  CheckListSaveComment(
                      saveQuestionCommentMap: saveQuestionCommentsMap));
            }
          },
          textValue: StringConstants.kSave),
    );
  }
}
