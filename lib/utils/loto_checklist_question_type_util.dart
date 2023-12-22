import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../configs/app_dimensions.dart';
import '../configs/app_spacing.dart';
import '../screens/checklist/workforce/widgets/upload_image_section.dart';
import '../screens/incident/widgets/date_picker.dart';
import '../screens/incident/widgets/time_picker.dart';
import '../screens/loto/widgets/answer_option_expansion_tile.dart';
import '../screens/loto/widgets/start_loto_screen.dart';
import '../widgets/generic_text_field.dart';
import 'constants/string_constants.dart';

class LotoChecklistQuestionTypeUtil {
  Map value = {};
  var valueOfA = 0.0;

  Widget fetchSwitchCaseWidget(type, questionId, queoptions, answerList, context) {
    switch (type) {
      case 1:
        return TextFieldWidget(
            maxLines: 1,
            maxLength: 250,
            textInputAction: TextInputAction.done,
            onTextFieldChanged: (String textValue) {
              answerList
                  .add({"questionid": questionId, "answer": textValue});
            });
      case 2:
        return TextFieldWidget(
            maxLines: 4,
            maxLength: 250,
            textInputAction: TextInputAction.done,
            onTextFieldChanged: (String textValue) {
              answerList
                  .add({"questionid": questionId, "answer": textValue});
            });
      case 3:
      // return DropDownExpansionTile(
      //   onValueChanged: (String dropDownId, String dropDownString) {
      //     answerList[index]["answer"] = dropDownId;
      //   },
      //   answerModelList: answerModelList,
      //   index: index,
      //   value: (answerModelList[index].optiontext.toString() == "null" ||
      //           answerModelList[index].optiontext.toString() == "")
      //       ? ''
      //       : answerModelList[index].optiontext,
      // );
      case 4:
        return AnswerOptionExpansionTile(
          queOptionList: queoptions,
          startLotoMap: StartLotoScreen.startLotoMap,
          questionId: questionId,
        );
      case 5:
      // return BlocBuilder<WorkForceCheckListEditAnswerBloc,
      //         WorkForceCheckListEditAnswerStates>(
      //     buildWhen: (previousState, currentState) =>
      //         currentState is CheckListAnswersEdited,
      //     builder: (context, state) {
      //       if (state is CheckListAnswersEdited) {
      //         answerList[index]["answer"] = state.multiSelectId
      //             .toString()
      //             .replaceAll("[", "")
      //             .replaceAll("]", "");
      //         return MultiSelectExpansionTile(
      //             answerModelList: answerModelList,
      //             index: index,
      //             selectedIdList: state.multiSelectId,
      //             selectedNamesList: state.multiSelectNames,
      //             editValue: (answerModelList[index].optiontext.toString() ==
      //                         "null" ||
      //                     answerModelList[index].optiontext.toString() == "")
      //                 ? ''
      //                 : answerModelList[index].optiontext);
      //       } else {
      //         return const SizedBox();
      //       }
      //     });
      case 6:
        return UploadImageMenu(
          isFromCertificate: true,
          onUploadImageResponse: (List<dynamic> imageList) {
            answerList.add({
              "questionid": questionId,
              "answer":
                  imageList.toString().replaceAll("[", "").replaceAll("]", "")
            });
          },
        );
      case 7:
        return TextFieldWidget(
            textInputType: TextInputType.number,
            textInputAction: TextInputAction.done,
            onTextFieldChanged: (String textValue) {
              answerList
                  .add({"questionid": questionId, "answer": textValue});
            });
      case 8:
      // return tableControl(index, answerModelList, answerList, context);
      case 9:
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(StringConstants.kValueA,
                    style: Theme.of(context).textTheme.xSmall),
                const SizedBox(width: tiniestSpacing),
                SizedBox(
                    width: kTimeSpanFieldWidth,
                    height: xxSmallSpacing,
                    child: TextFieldWidget(
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.number,
                        maxLength: 8,
                        onTextFieldChanged: (String textField) {
                          valueOfA = double.parse(textField).toDouble();
                        }))
              ]),
          const SizedBox(height: tinySpacing),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(StringConstants.kValueB,
                    style: Theme.of(context).textTheme.xSmall),
                const SizedBox(width: tiniestSpacing),
                SizedBox(
                    width: kTimeSpanFieldWidth,
                    height: xxSmallSpacing,
                    child: TextFieldWidget(
                        textInputType: TextInputType.number,
                        maxLength: 8,
                        onTextFieldChanged: (String textField) {
                          value = {
                            "valueA": valueOfA,
                            "valueB": double.parse(textField).toDouble(),
                          };
                          answerList.add({
                            "questionid": questionId,
                            "answer": jsonEncode(value)
                          });
                        }))
              ])
        ]);
      case 10:
        return DatePickerTextField(
          hintText: StringConstants.kSelectDate,
          onDateChanged: (String date) {
            answerList
                .add({"questionid": questionId, "answer": date});
          },
        );
      case 11:
        return TimePickerTextField(
            hintText: StringConstants.kSelectTime,
            onTimeChanged: (String time) {
              answerList
                  .add({"questionid": questionId, "answer": time});
            });
      default:
        return Container();
    }
  }
}

Widget tableControl(index, answerModelList, answerList, context) {
  Map tableData = jsonDecode(answerList[index]["answer"]);
  return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            decoration: BoxDecoration(border: Border.all()),
            child: DataTable(
                border: TableBorder.all(),
                columnSpacing: xxxSmallestSpacing,
                columns: [
                  for (int i = 0;
                      i < answerModelList[index].matrixcols.length;
                      i++)
                    DataColumn(
                        label: Text(answerModelList[index].matrixcols[i]))
                ],
                rows: [
                  for (int j = 0;
                      j < answerModelList[index].matrixrowcount;
                      j++)
                    DataRow(cells: [
                      for (int k = 0;
                          k < answerModelList[index].matrixcols.length;
                          k++)
                        DataCell(SizedBox(
                            height: xMediumSpacing,
                            width: kDataCellWidth,
                            child: TextFieldWidget(
                                value: (tableData.toString() == "{}" &&
                                        answerModelList[index].type == 8)
                                    ? ""
                                    : tableData["data"][j][k],
                                onTextFieldChanged: (String textField) {
                                  tableData["data"][j][k] = textField;
                                  answerList[index]["answer"] =
                                      jsonEncode(tableData);
                                })))
                    ])
                ]))
      ]));
}
