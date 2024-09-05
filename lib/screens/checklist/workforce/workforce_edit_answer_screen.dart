import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/editAnswer/workforce_checklist_edit_answer_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/editAnswer/workforce_checklist_edit_answer_events.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/workforce/widgets/checklist_app_bar.dart';
import 'package:toolkit/screens/checklist/workforce/widgets/submit_edit_answer_button.dart';
import 'package:toolkit/widgets/secondary_button.dart';
import '../../../blocs/checklist/workforce/editAnswer/workforce_checklist_edit_answer_states.dart';
import '../../../blocs/checklist/workforce/getQuestionsList/workforce_checklist_get_questions_list_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';

import '../../../utils/database_utils.dart';
import '../../../utils/workforce_checklist_edit_answer_util.dart';
import '../../../widgets/custom_card.dart';
import '../../tickets2/add_ticket2_screen.dart';
import '../../todo/todo_assigned_to_me_and_by_me_list_screen.dart';
import 'add_image_and_comments_screen.dart';

class EditAnswerListScreen extends StatelessWidget {
  static const routeName = 'EditAnswerListScreen';
  final Map checklistDataMap;

  const EditAnswerListScreen({Key? key, required this.checklistDataMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<WorkForceCheckListEditAnswerBloc>().add(
        CheckListPopulateAnswerData(
            questionList:
                context.read<WorkForceQuestionsListBloc>().questionList!,
            multiSelect: '',
            dropDownValue: '',
            answerList: context.read<WorkForceQuestionsListBloc>().answerList,
            allChecklistDataMap: context
                .read<WorkForceQuestionsListBloc>()
                .allDataForChecklistMap));
    return Scaffold(
        appBar: ChecklistAppBar(
          title: BlocBuilder<WorkForceCheckListEditAnswerBloc,
                  WorkForceCheckListEditAnswerStates>(
              buildWhen: (previousState, currentState) =>
                  currentState is SavedCheckListQuestions,
              builder: (context, state) {
                if (state is SavedCheckListQuestions) {
                  return Text(state.allChecklistDataMap["name"]);
                } else {
                  return const SizedBox();
                }
              }),
        ),
        body: BlocBuilder<WorkForceCheckListEditAnswerBloc,
                WorkForceCheckListEditAnswerStates>(
            buildWhen: (previousState, currentState) =>
                currentState is SavedCheckListQuestions,
            builder: (context, state) {
              if (state is SavedCheckListQuestions) {
                return Padding(
                    padding: const EdgeInsets.only(
                        left: leftRightMargin,
                        right: leftRightMargin,
                        top: topBottomPadding),
                    child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(children: [
                          ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.answerModelList.length,
                              itemBuilder: (context, index) {
                                return CustomCard(
                                    child: Padding(
                                        padding:
                                            const EdgeInsets.all(kCardPadding),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                    text:
                                                        '${index + 1}] ${state.answerModelList[index].title}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .medium,
                                                    children: [
                                                      (state
                                                                  .answerModelList[
                                                                      index]
                                                                  .ismandatory ==
                                                              1)
                                                          ? TextSpan(
                                                              text: ' *',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .medium)
                                                          : const TextSpan()
                                                    ]),
                                              ),
                                              const SizedBox(
                                                  height: tiniestSpacing),
                                              Visibility(
                                                visible: state
                                                        .answerModelList[index]
                                                        .moreinfo !=
                                                    null,
                                                child: Text(
                                                    '${state.answerModelList[index].moreinfo}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .xSmall
                                                        .copyWith(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            color:
                                                                AppColor.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                              ),
                                              const SizedBox(
                                                  height: xxTinierSpacing),
                                              EditAnswerUtil()
                                                  .fetchSwitchCaseWidget(
                                                      state
                                                          .answerModelList[
                                                              index]
                                                          .type,
                                                      index,
                                                      state.answerModelList,
                                                      state.answersList,
                                                      context),
                                              const SizedBox(
                                                  height: tiniestSpacing),
                                              Visibility(
                                                visible: state
                                                        .answerModelList[index]
                                                        .title ==
                                                    "Abdampftemperatur",
                                                child: Text(
                                                    '${DatabaseUtil.getText('RangeMessage')} ${state.answerModelList[index].minval} ${DatabaseUtil.getText('to')} ${state.answerModelList[index].maxval}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .xSmall
                                                        .copyWith(
                                                            color: AppColor
                                                                .errorRed,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400)),
                                              ),
                                              const SizedBox(
                                                  height: tiniestSpacing),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: SecondaryButton(
                                                          onPressed: () {
                                                            Navigator.pushNamed(
                                                                context,
                                                                AddImageAndCommentScreen
                                                                    .routeName,
                                                                arguments: state
                                                                    .answerModelList[
                                                                        index]
                                                                    .queresponseid
                                                                    .toString());
                                                          },
                                                          textValue:
                                                              StringConstants
                                                                  .kAddComment),
                                                    ),
                                                    const SizedBox(
                                                        width: tiniestSpacing),
                                                    Expanded(
                                                        child: SecondaryButton(
                                                            onPressed: () {
                                                              Navigator.pushNamed(
                                                                  context,
                                                                  TodoAssignedByMeAndToMeListScreen
                                                                      .routeName);
                                                            },
                                                            textValue:
                                                                StringConstants
                                                                    .kAddTodo)),
                                                    const SizedBox(
                                                        width: tiniestSpacing),
                                                    Expanded(
                                                      child: SecondaryButton(
                                                        onPressed: () {
                                                          Navigator.pushNamed(
                                                              context,
                                                              AddTicket2Screen
                                                                  .routeName,
                                                              arguments: state
                                                                  .answerModelList[
                                                                      index]
                                                                  .queresponseid
                                                                  .toString());
                                                        },
                                                        textValue: DatabaseUtil
                                                            .getText(
                                                                'ticket_addticket'),
                                                      ),
                                                    ),
                                                  ])
                                            ])));
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(height: xxTinySpacing);
                              }),
                          const SizedBox(height: xxxSmallerSpacing),
                          SubmitEditAnswerButton(
                              answerList: state.answersList,
                              checklistDataMap: checklistDataMap),
                          const SizedBox(height: xxTiniestSpacing)
                        ])));
              } else {
                return const SizedBox();
              }
            }));
  }
}
