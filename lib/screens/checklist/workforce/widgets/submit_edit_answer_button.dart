import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../blocs/checklist/workforce/submitAnswer/workforce_checklist_submit_answer_bloc.dart';
import '../../../../blocs/checklist/workforce/submitAnswer/workforce_checklist_submit_answer_event.dart';
import '../../../../blocs/checklist/workforce/submitAnswer/workforce_checklist_submit_answer_states.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/progress_bar.dart';
import '../workforce_list_screen.dart';
import 'submit_answer_signature_pad_section.dart';

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
                context, WorkForceListScreen.routeName);
          } else if (state is AnswerNotSubmitted) {
            ProgressBar.dismiss(context);
            showCustomSnackBar(context, state.message, '');
          }
        },
        child: Row(children: [
          SubmitAnswerSignaturePadSection(
              answerList: answerList, checklistDataMap: checklistDataMap),
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
