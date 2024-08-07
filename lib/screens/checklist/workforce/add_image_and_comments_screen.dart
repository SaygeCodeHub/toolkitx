import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/imagePickerBloc/image_picker_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/workforce/widgets/checklist_save_comment_button.dart';
import 'package:toolkit/screens/checklist/workforce/widgets/upload_image_section.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/error_section.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../../blocs/checklist/workforce/comments/workforce_checklist_comments_bloc.dart';
import '../../../blocs/checklist/workforce/comments/workforce_checklist_comments_events.dart';
import '../../../blocs/checklist/workforce/comments/workforce_checklist_comments_states.dart';
import '../../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../../configs/app_color.dart';
import '../../../widgets/generic_text_field.dart';

class AddImageAndCommentScreen extends StatelessWidget {
  static const routeName = 'AddImageAndCommentScreen';
  final String questionResponseId;

  AddImageAndCommentScreen({Key? key, required this.questionResponseId})
      : super(key: key);
  final Map saveQuestionCommentsMap = {};

  @override
  Widget build(BuildContext context) {
    context
        .read<WorkForceCheckListCommentBloc>()
        .add(CheckListFetchComment(questionResponseId: questionResponseId));
    context.read<PickAndUploadImageBloc>().add(UploadInitial());
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kAddCommentImage),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomPadding),
            child: BlocBuilder<WorkForceCheckListCommentBloc,
                    WorkForceCheckListCommentStates>(
                buildWhen: (previousState, currentState) =>
                    currentState is CheckListFetchingComment ||
                    currentState is CheckListCommentFetched ||
                    currentState is CheckListCommentNotFetched,
                builder: (context, state) {
                  if (state is CheckListFetchingComment) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CheckListCommentFetched) {
                    saveQuestionCommentsMap["comments"] =
                        state.getQuestionCommentsModel.data!.additionalcomment;
                    return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(state.getQuestionCommentsModel.data!.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .small
                                      .copyWith(
                                          color: AppColor.deepBlue,
                                          fontWeight: FontWeight.w500)),
                              const SizedBox(height: xxTinierSpacing),
                              Text(
                                  state
                                      .getQuestionCommentsModel.data!.optiontext
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .small
                                      .copyWith(
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w500)),
                              const SizedBox(height: xxTinierSpacing),
                              Text(StringConstants.kComments,
                                  style: Theme.of(context)
                                      .textTheme
                                      .small
                                      .copyWith(
                                          color: AppColor.deepBlue,
                                          fontWeight: FontWeight.w500)),
                              const SizedBox(height: xxTinierSpacing),
                              TextFieldWidget(
                                  textInputAction: TextInputAction.done,
                                  value: saveQuestionCommentsMap["comments"],
                                  maxLines: 6,
                                  maxLength: 250,
                                  onTextFieldChanged: (String textValue) {
                                    saveQuestionCommentsMap["comments"] =
                                        textValue;
                                  }),
                              const SizedBox(height: xxTinierSpacing),
                              Text(StringConstants.kFiles,
                                  style: Theme.of(context)
                                      .textTheme
                                      .small
                                      .copyWith(
                                          color: AppColor.deepBlue,
                                          fontWeight: FontWeight.w500)),
                              const SizedBox(height: xxTinierSpacing),
                              Text(state.getQuestionCommentsModel.data!.files!,
                                  style: Theme.of(context).textTheme.xSmall),
                              const SizedBox(height: xxTinierSpacing),
                              Text(StringConstants.kUploadPhoto,
                                  style: Theme.of(context)
                                      .textTheme
                                      .small
                                      .copyWith(
                                          color: AppColor.deepBlue,
                                          fontWeight: FontWeight.w500)),
                              const SizedBox(height: xxTinierSpacing),
                              UploadImageMenu(
                                imagePickerBloc: ImagePickerBloc(),
                                onUploadImageResponse: (List uploadImageList) {
                                  saveQuestionCommentsMap["pickedImage"] =
                                      uploadImageList;
                                },
                              ),
                              const SizedBox(height: xxTinySpacing),
                              ChecklistSaveCommentButton(
                                  saveQuestionCommentsMap:
                                      saveQuestionCommentsMap),
                            ]));
                  } else if (state is CheckListCommentNotFetched) {
                    return GenericReloadButton(
                        onPressed: () {
                          context.read<WorkForceCheckListCommentBloc>().add(
                              CheckListFetchComment(
                                  questionResponseId: state.quesResponseId));
                        },
                        textValue: StringConstants.kReload);
                  } else {
                    return const SizedBox();
                  }
                })));
  }
}
