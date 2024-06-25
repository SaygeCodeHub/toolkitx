import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../../data/models/checklist/workforce/workforce_questions_list_model.dart';

class QuestionListTitleSection extends StatelessWidget {
  final Questionlist questionList;
  final int index;

  const QuestionListTitleSection(
      {Key? key, required this.questionList, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        maxLines: 5,
        text: TextSpan(
            text: '${index + 1}] ${questionList.title}?',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(fontWeight: FontWeight.w600),
            children: [
              (questionList.ismandatory == 1)
                  ? TextSpan(
                      text: ' *',
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600))
                  : const TextSpan()
            ]));
  }
}
