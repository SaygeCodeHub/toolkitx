import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/tankManagement/widgets/tank_view_response_body.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../../../blocs/checklist/workforce/getQuestionsList/workforce_cheklist_get_questions_list_states.dart';
import '../../../../blocs/checklist/workforce/getQuestionsList/workforce_checklist_get_questions_list_bloc.dart';
import '../../../../blocs/checklist/workforce/getQuestionsList/workforce_checklist_get_questions_list_events.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/error_section.dart';

class TankViewResponseScreen extends StatelessWidget {
  static const routeName = 'TankViewResponseScreen';

  const TankViewResponseScreen({super.key, required this.tankChecklistMap});

  final Map tankChecklistMap;

  @override
  Widget build(BuildContext context) {
    context
        .read<WorkForceQuestionsListBloc>()
        .add(WorkForceCheckListFetchQuestions(checklistData: tankChecklistMap));
    return Scaffold(
      appBar: GenericAppBar(title: tankChecklistMap['title']),
      body: BlocBuilder<WorkForceQuestionsListBloc,
          WorkForceCheckListQuestionsStates>(builder: (context, state) {
        if (state is CheckListFetchingQuestionsList) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is QuestionsListFetched) {
          return TankViewResponseBody(
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
          return Center(child: Text(state.errorMessage));
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
