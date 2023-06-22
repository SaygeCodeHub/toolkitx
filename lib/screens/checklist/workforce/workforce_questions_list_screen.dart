import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/checklist/workforce/widgets/checklist_app_bar.dart';
import 'package:toolkit/screens/checklist/workforce/widgets/question_list_section.dart';
import 'package:toolkit/screens/checklist/workforce/workforce_pup_up_menu_screen.dart';

import '../../../blocs/checklist/workforce/getQuestionsList/workforce_cheklist_get_questions_list_states.dart';
import '../../../blocs/checklist/workforce/getQuestionsList/workforce_checklist_get_questions_list_bloc.dart';
import '../../../blocs/checklist/workforce/getQuestionsList/workforce_checklist_get_questions_list_events.dart';

class WorkForceQuestionsScreen extends StatelessWidget {
  static const routeName = 'WorkForceQuestionsScreen';
  final Map checklistDataMap;

  const WorkForceQuestionsScreen({Key? key, required this.checklistDataMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<WorkForceQuestionsListBloc>()
        .add(WorkForceCheckListFetchQuestions(checklistData: checklistDataMap));
    return Scaffold(
        appBar: ChecklistAppBar(
            title: BlocBuilder<WorkForceQuestionsListBloc,
                WorkForceCheckListQuestionsStates>(builder: (context, state) {
              if (state is QuestionsListFetched) {
                state.allChecklistDataMap["name"] =
                    state.getQuestionListModel.data!.name.toString();
                return Text(state.getQuestionListModel.data!.name.toString());
              } else {
                return const SizedBox();
              }
            }),
            actions: [
              BlocBuilder<WorkForceQuestionsListBloc,
                  WorkForceCheckListQuestionsStates>(builder: (context, state) {
                if (state is QuestionsListFetched) {
                  return Visibility(
                      // visible: state.allChecklistDataMap["isRejected"] == "0" &&
                      //     checklistDataMap["isDraft"] != 0,
                      child: WorkForcePopUpMenu(
                          checklistDataMap: checklistDataMap));
                } else {
                  return const SizedBox();
                }
              })
            ]),
        body: const QuestionsListSection());
  }
}
