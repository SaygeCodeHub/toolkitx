import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../blocs/checklist/workforce/getQuestionsList/workforce_checklist_get_questions_list_bloc.dart';
import '../../../../blocs/checklist/workforce/getQuestionsList/workforce_checklist_get_questions_list_events.dart';
import '../../../../blocs/checklist/workforce/submitAnswer/workforce_checklist_submit_answer_bloc.dart';
import '../../../../blocs/checklist/workforce/submitAnswer/workforce_checklist_submit_answer_event.dart';
import '../../../../blocs/checklist/workforce/submitAnswer/workforce_checklist_submit_answer_states.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/android_pop_up.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/progress_bar.dart';
import '../workforce_questions_list_screen.dart';

class SubmitEditAnswerButton extends StatelessWidget {
  final List answerList;
  final Map checklistDataMap;

  const SubmitEditAnswerButton(
      {Key? key, required this.answerList, required this.checklistDataMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SubmitAnswerBloc, SubmitAnswerStates>(
        listener: (context, state) {
          if (state is SubmittingAnswer) {
            ProgressBar.show(context);
          } else if (state is AnswerSubmitted) {
            ProgressBar.dismiss(context);
            Navigator.pop(context);
            Navigator.pushReplacementNamed(
                context, WorkForceQuestionsScreen.routeName,
                arguments: checklistDataMap);
            context.read<WorkForceQuestionsListBloc>().add(
                WorkForceCheckListFetchQuestions(
                    checklistData: checklistDataMap));
          } else if (state is AnswerNotSubmitted) {
            ProgressBar.dismiss(context);
            showCustomSnackBar(context, state.message, '');
          }
        },
        child: Row(children: [
          Expanded(
            child: PrimaryButton(
                onPressed: () {
                  showDialog(
                      barrierColor: AppColor.transparent,
                      context: context,
                      builder: (context) {
                        return AndroidPopUp(
                            titleValue: StringConstants.kChecklist,
                            contentValue: StringConstants.kChecklistNotEditable,
                            onPrimaryButton: () {
                              context.read<SubmitAnswerBloc>().add(
                                  SubmitAnswers(
                                      editQuestionsList: answerList,
                                      isDraft: false,
                                      allChecklistDataMap: checklistDataMap));
                              Navigator.pop(context);
                            });
                      });
                },
                textValue: StringConstants.kSubmit),
          ),
          const SizedBox(width: xxTinySpacing),
          Expanded(
              child: PrimaryButton(
                  onPressed: () {
                    context.read<SubmitAnswerBloc>().add(SubmitAnswers(
                        editQuestionsList: answerList,
                        isDraft: true,
                        allChecklistDataMap: checklistDataMap));
                  },
                  textValue: StringConstants.kSaveDraft))
        ]));
  }
}
