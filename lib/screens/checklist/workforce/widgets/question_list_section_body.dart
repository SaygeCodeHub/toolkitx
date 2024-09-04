import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/tickets2/add_ticket2_screen.dart';

import '../../../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../../../blocs/imagePickerBloc/image_picker_event.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_dimensions.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../data/models/checklist/workforce/workforce_questions_list_model.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../utils/database_utils.dart';
import '../../../../widgets/custom_card.dart';
import '../../../../widgets/secondary_button.dart';
import '../../../todo/todo_assigned_to_me_and_by_me_list_screen.dart';
import '../add_image_and_comments_screen.dart';
import 'question_list_title_section.dart';

class QuestionListSectionBody extends StatelessWidget {
  final List<Questionlist> questionList;
  final List<dynamic> answerList;

  const QuestionListSectionBody(
      {super.key, required this.questionList, required this.answerList});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: topBottomPadding),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: questionList.length,
        itemBuilder: (context, index) {
          Map tableData = (questionList[index].type == 8 &&
                  questionList[index].optioncomment != null)
              ? jsonDecode(answerList[index]["answer"])
              : {};
          return CustomCard(
              child: Padding(
            padding: const EdgeInsets.all(kCardPadding),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              QuestionListTitleSection(
                  questionList: questionList[index], index: index),
              const SizedBox(height: xxxTinierSpacing),
              Visibility(
                visible: questionList[index].moreinfo != null,
                child: Text('${questionList[index].moreinfo}',
                    maxLines: 2,
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        color: AppColor.grey, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(height: xxxTinierSpacing),
              (questionList[index].type != 8)
                  ? Text(
                      (answerList[index]["answer"].toString() == 'null' ||
                              answerList[index]["answer"].toString() == "")
                          ? ''
                          : '${answerList[index]["answer"]}',
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
                                decoration: BoxDecoration(border: Border.all()),
                                child: DataTable(
                                    border: TableBorder.all(),
                                    columns: [
                                      for (int i = 0;
                                          i <
                                              questionList[index]
                                                  .matrixcols!
                                                  .length;
                                          i++)
                                        DataColumn(
                                            label: Text(questionList[index]
                                                .matrixcols![i]))
                                    ],
                                    rows: [
                                      for (int j = 0;
                                          j <
                                              questionList[index]
                                                  .matrixrowcount;
                                          j++)
                                        DataRow(cells: [
                                          for (int k = 0;
                                              k <
                                                  questionList[index]
                                                      .matrixcols!
                                                      .length;
                                              k++)
                                            DataCell(Text(
                                                (tableData == {} &&
                                                        questionList[index]
                                                                .type ==
                                                            8)
                                                    ? ""
                                                    : (tableData["data"] ==
                                                                null ||
                                                            tableData["data"]
                                                                    .toString() ==
                                                                '')
                                                        ? ''
                                                        : tableData["data"][j]
                                                            [k],
                                                overflow:
                                                    TextOverflow.ellipsis))
                                        ])
                                    ]))
                          ])),
              const SizedBox(height: tiniestSpacing),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                    child: SecondaryButton(
                        onPressed: () {
                          context
                              .read<ImagePickerBloc>()
                              .pickedImagesList
                              .clear();
                          context
                              .read<ImagePickerBloc>()
                              .add(PickImageInitial());
                          Navigator.pushNamed(
                              context, AddImageAndCommentScreen.routeName,
                              arguments:
                                  questionList[index].queresponseid.toString());
                        },
                        textValue: StringConstants.kAddComment)),
                const SizedBox(width: tiniestSpacing),
                Expanded(
                  child: SecondaryButton(
                      onPressed: () {
                        Navigator.pushNamed(context,
                            TodoAssignedByMeAndToMeListScreen.routeName);
                      },
                      textValue: StringConstants.kAddTodo),
                ),
                const SizedBox(width: tiniestSpacing),
                Expanded(
                  child: SecondaryButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AddTicket2Screen.routeName,
                          arguments: questionList[index].queresponseid);
                    },
                    textValue: DatabaseUtil.getText('ticket_addticket'),
                  ),
                ),
              ]),
            ]),
          ));
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: xxTinySpacing);
        });
  }
}
