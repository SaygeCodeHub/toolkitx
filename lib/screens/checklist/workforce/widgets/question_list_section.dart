import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/workforce/widgets/question_list_title_section.dart';
import '../../../../blocs/checklist/workforce/getQuestionsList/workforce_cheklist_get_questions_list_states.dart';
import '../../../../blocs/checklist/workforce/getQuestionsList/workforce_checklist_get_questions_list_bloc.dart';
import '../../../../blocs/checklist/workforce/getQuestionsList/workforce_checklist_get_questions_list_events.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/custom_card.dart';
import '../../../../widgets/error_section.dart';
import '../../../../widgets/secondary_button.dart';
import '../add_image_and_comments_screen.dart';

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
        return ListView.separated(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomPadding),
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.getQuestionListModel.data!.questionlist!.length,
            itemBuilder: (context, index) {
              Map tableData =
                  (state.getQuestionListModel.data!.questionlist![index].type ==
                              8 &&
                          state.getQuestionListModel.data!.questionlist![index]
                                  .optioncomment !=
                              null)
                      ? jsonDecode(state.answerList[index]["answer"])
                      : {};
              return CustomCard(
                  child: Padding(
                padding: const EdgeInsets.all(kCardPadding),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          QuestionListTitleSection(
                              questionList: state.getQuestionListModel.data!
                                  .questionlist![index]),
                          Visibility(
                            visible: state.getQuestionListModel.data!
                                    .questionlist![index].moreinfo !=
                                null,
                            child: Text(
                                '${state.getQuestionListModel.data!.questionlist![index].moreinfo}',
                                style: Theme.of(context)
                                    .textTheme
                                    .xSmall
                                    .copyWith(
                                        color: AppColor.grey,
                                        fontWeight: FontWeight.w500)),
                          )
                        ],
                      ),
                      const SizedBox(height: xxxTinierSpacing),
                      (state.getQuestionListModel.data!.questionlist![index]
                                  .type !=
                              8)
                          ? Text(
                              (state.answerList[index]["answer"].toString() ==
                                          'null' ||
                                      state.answerList[index]["answer"]
                                              .toString() ==
                                          "")
                                  ? ''
                                  : '${state.answerList[index]["answer"]}',
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(color: AppColor.black))
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        decoration:
                                            BoxDecoration(border: Border.all()),
                                        child: DataTable(
                                            border: TableBorder.all(),
                                            columns: [
                                              for (int i = 0;
                                                  i <
                                                      state
                                                          .getQuestionListModel
                                                          .data!
                                                          .questionlist![index]
                                                          .matrixcols!
                                                          .length;
                                                  i++)
                                                DataColumn(
                                                    label: Text(state
                                                        .getQuestionListModel
                                                        .data!
                                                        .questionlist![index]
                                                        .matrixcols![i]))
                                            ],
                                            rows: [
                                              for (int j = 0;
                                                  j <
                                                      state
                                                          .getQuestionListModel
                                                          .data!
                                                          .questionlist![index]
                                                          .matrixrowcount;
                                                  j++)
                                                DataRow(cells: [
                                                  for (int k = 0;
                                                      k <
                                                          state
                                                              .getQuestionListModel
                                                              .data!
                                                              .questionlist![
                                                                  index]
                                                              .matrixcols!
                                                              .length;
                                                      k++)
                                                    DataCell(Text(
                                                        (tableData == {} &&
                                                                state
                                                                        .getQuestionListModel
                                                                        .data!
                                                                        .questionlist![
                                                                            index]
                                                                        .type ==
                                                                    8)
                                                            ? ""
                                                            : (tableData["data"] ==
                                                                        null ||
                                                                    tableData["data"]
                                                                            .toString() ==
                                                                        '')
                                                                ? ''
                                                                : tableData[
                                                                        "data"]
                                                                    [j][k],
                                                        overflow: TextOverflow
                                                            .ellipsis))
                                                ])
                                            ]))
                                  ])),
                      const SizedBox(height: tiniestSpacing),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: SecondaryButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context,
                                          AddImageAndCommentScreen.routeName,
                                          arguments: state
                                              .getQuestionListModel
                                              .data!
                                              .questionlist![index]
                                              .queresponseid
                                              .toString());
                                    },
                                    textValue: StringConstants.kAddImages)),
                            const SizedBox(width: tiniestSpacing),
                            Expanded(
                              child: SecondaryButton(
                                  onPressed: () {},
                                  textValue: StringConstants.kAddTodo),
                            )
                          ]),
                    ]),
              ));
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: xxTinySpacing);
            });
      } else if (state is CheckListQuestionsListNotFetched) {
        return GenericReloadButton(
            onPressed: () {
              context.read<WorkForceQuestionsListBloc>().add(
                  WorkForceCheckListFetchQuestions(
                      checklistData: state.allChecklistDataMap));
            },
            textValue: StringConstants.kReload);
      } else {
        return const SizedBox();
      }
    });
  }
}
