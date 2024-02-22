import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/widgets/generic_no_records_text.dart';
import '../../../../blocs/checklist/workforce/getQuestionsList/workforce_cheklist_get_questions_list_states.dart';
import '../../../../blocs/checklist/workforce/getQuestionsList/workforce_checklist_get_questions_list_bloc.dart';
import '../../../../blocs/checklist/workforce/getQuestionsList/workforce_checklist_get_questions_list_events.dart';
import '../../../../utils/constants/string_constants.dart';

import '../../../../widgets/error_section.dart';
import 'question_list_section_body.dart';

class QuestionsListSection extends StatelessWidget {
  const QuestionsListSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkForceQuestionsListBloc,
        WorkForceCheckListQuestionsStates>(builder: (context, state) {
      if (state is CheckListFetchingQuestionsList) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is QuestionsListFetched) {
        return QuestionListSectionBody(
            questionList: state.getQuestionListModel.data!.questionlist!,
            answerList: state.answerList);
      } else if (state is CheckListQuestionsListNotFetched) {
        return GenericReloadButton(
            onPressed: () {
              context.read<WorkForceQuestionsListBloc>().add(
                  WorkForceCheckListFetchQuestions(
                      checklistData: state.allChecklistDataMap));
            },
            textValue: StringConstants.kReload);
      } else if (state is CheckListQuestionsListNotFetched) {
        return NoRecordsText(text: state.errorMessage);
      } else {
        return const SizedBox();
      }
    });
  }
}
