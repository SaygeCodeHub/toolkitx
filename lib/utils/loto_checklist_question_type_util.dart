import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/loto/widgets/loto_select_multi_checklist_answer.dart';
import 'package:toolkit/screens/loto/widgets/type_three_expansion_tile.dart';
import '../configs/app_color.dart';
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

  Widget fetchSwitchCaseWidget(
      type, questionId, queoptions, answerList, context, index, startLotoMap) {
    switch (type) {
      case 1:
        return TextFieldWidget(
            maxLines: 1,
            maxLength: 250,
            textInputAction: TextInputAction.done,
            onTextFieldChanged: (String textValue) {
              answerList[index]['questionid'] = questionId;
              answerList[index]['answer'] = textValue;
            });
      case 2:
        return TextFieldWidget(
            maxLines: 4,
            maxLength: 250,
            textInputAction: TextInputAction.done,
            onTextFieldChanged: (String textValue) {
              answerList[index]['questionid'] = questionId;
              answerList[index]['answer'] = textValue;
            });
      case 3:
        return TypeThreeExpansionTile(
          queOptionList: queoptions,
          startLotoMap: StartLotoScreen.startLotoMap,
          questionId: questionId,
          answerList: answerList,
        );
      case 4:
        return AnswerOptionExpansionTile(
          queOptionList: queoptions,
          startLotoMap: StartLotoScreen.startLotoMap,
          questionId: questionId,
          answerList: answerList,
        );
      case 5:
        return LotoSelectMultiChecklistAnswer(
          queoptions: queoptions,
          onCreatedForChanged: (List<dynamic> id) {
            answerList[index]['questionid'] = questionId;
            answerList[index]['answer'] = id
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", "")
                .replaceAll(' ', '');
          },
        );
      case 6:
        return UploadImageMenu(
          isFromCertificate: true,
          onUploadImageResponse: (List<dynamic> imageList) {
            startLotoMap['pickedImage'] = imageList;
            startLotoMap['questionid'] = questionId;
          },
        );
      case 7:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldWidget(
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.done,
                onTextFieldChanged: (String textValue) {
                  answerList[index]['questionid'] = questionId;
                  answerList[index]['answer'] = textValue;
                }),
            const SizedBox(height: tiniestSpacing),
            Text(StringConstants.kPleaseEnterYourAnswer50Bis200,
                style: Theme.of(context).textTheme.xxSmall.copyWith(
                    fontWeight: FontWeight.w400, color: AppColor.errorRed)),
          ],
        );
      case 8:
        return const SizedBox.shrink();
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
                          answerList[index]['questionid'] = questionId;
                          answerList[index]['answer'] = jsonEncode(value);
                        }))
              ])
        ]);
      case 10:
        return DatePickerTextField(
          hintText: StringConstants.kSelectDate,
          onDateChanged: (String date) {
            answerList[index]['questionid'] = questionId;
            answerList[index]['answer'] = date;
          },
        );
      case 11:
        return TimePickerTextField(
            hintText: StringConstants.kSelectTime,
            onTimeChanged: (String time) {
              answerList[index]['questionid'] = questionId;
              answerList[index]['answer'] = time;
            });
      default:
        return Container();
    }
  }
}
