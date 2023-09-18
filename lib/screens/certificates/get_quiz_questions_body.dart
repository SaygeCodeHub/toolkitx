import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../blocs/certificates/startCourseCertificates/start_course_certificate_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/certificates/get_quiz_questions_model.dart';
import '../../widgets/custom_card.dart';

class GetQuizQuestionsBody extends StatelessWidget {
  const GetQuizQuestionsBody(
      {super.key,
      required this.data,
      required this.answerId,
      required this.getQuizQuestionsModel});
  final QuizData data;
  final String answerId;
  final GetQuizQuestionsModel getQuizQuestionsModel;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        width: kSizedBoxWidth,
        child: CustomCard(
            child: Padding(
                padding: const EdgeInsets.all(xxxTinierSpacing),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.title,
                          style: Theme.of(context).textTheme.xSmall.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColor.mediumBlack)),
                      const SizedBox(height: tiniestSpacing),
                      Text("${data.marks} ${StringConstants.kMarks}",
                          style: Theme.of(context).textTheme.xSmall.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColor.grey))
                    ]))),
      ),
      const SizedBox(height: tinySpacing),
      ListView.separated(
          itemCount: data.optionlist.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return CustomCard(
              child: RadioListTile(
                  dense: true,
                  activeColor: AppColor.deepBlue,
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Text(data.optionlist[index].description),
                  value: data.optionlist[index].id,
                  groupValue: answerId,
                  onChanged: (value) {
                    context.read<StartCourseCertificateBloc>().add(
                        SelectedQuizAnswerEvent(
                            answerId: data.optionlist[index].id,
                            getQuizQuestionsModel: getQuizQuestionsModel));
                  }),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: tiniestSpacing);
          }),
    ]);
  }
}
