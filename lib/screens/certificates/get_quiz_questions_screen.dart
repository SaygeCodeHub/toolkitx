
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/certificates/get_quiz_questions_body.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../blocs/certificates/startCourseCertificates/start_course_certificate_bloc.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';

class QuizQuestionsScreen extends StatelessWidget {
  static const routeName = 'QuizQuestionsScreen';

  const QuizQuestionsScreen({super.key, required this.quizMap});

  final Map quizMap;
  static int pageNo = 1;

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context.read<StartCourseCertificateBloc>().add(GetQuizQuestions(
        workforcequizId: quizMap["userquizid"], pageNo: pageNo));
    return Scaffold(
      appBar: const GenericAppBar(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(tinySpacing),
        child: PrimaryButton(
            onPressed: () {}, textValue: StringConstants.kFinishQuiz),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: leftRightMargin,
          right: leftRightMargin,
          top: xxTinierSpacing,
        ),
        child: BlocConsumer<StartCourseCertificateBloc,
            StartCourseCertificateState>(
          listener: (context, state) {
            if (state is QuestionAnswerSaved) {
              showCustomSnackBar(context, StringConstants.kAnswerSaved, "");
            }
          },
          buildWhen: (previousState, currentState) =>
          currentState is QuizQuestionsFetching ||
              currentState is QuizQuestionsFetched ||
              currentState is QuizQuestionsError,
          builder: (context, state) {
            if (state is QuizQuestionsFetching) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is QuizQuestionsFetched) {
              Map questionAnswerMap = {
                "idm": quizMap["userquizid"],
                "workforcequizid": quizMap["userquizid"],
                "answer": state.getQuizQuestionsModel.data
                    .optionlist[0].id,
                "questionid": state
                    .getQuizQuestionsModel.data.questionid
              };
              return Column(
                children: [
                  GetQuizQuestionsBody(
                    data: state.getQuizQuestionsModel.data,
                    answerId: state.answerId,
                    getQuizQuestionsModel: state.getQuizQuestionsModel,
                  ),
                  const SizedBox(height: mediumSpacing),
                  Row(
                    children: [
                      SizedBox(
                          width: xxSizedBoxWidth,
                          child: PrimaryButton(
                              onPressed: pageNo.toString() !=
                                  quizMap["questioncount"]
                                  ? () {
                                pageNo++;
                                context
                                    .read<StartCourseCertificateBloc>()
                                    .add(GetQuizQuestions(
                                    pageNo: pageNo,
                                    workforcequizId:
                                    quizMap["userquizid"]));
                              }
                                  : null,
                              textValue: StringConstants.kNext)),
                      const SizedBox(width: tinierSpacing),
                      SizedBox(
                          width: xSizedBoxWidth,
                          child: PrimaryButton(
                              onPressed: pageNo.toString() !=
                                  quizMap["questioncount"]
                                  ? () {
                                pageNo++;
                                context
                                    .read<StartCourseCertificateBloc>()
                                    .add(QuestionAnswerEvent(
                                    questionAnswerMap:
                                    questionAnswerMap));
                                context
                                    .read<StartCourseCertificateBloc>()
                                    .add(GetQuizQuestions(
                                    pageNo: pageNo,
                                    workforcequizId:
                                    quizMap["userquizid"]));

                              }
                                  : null,
                              textValue: StringConstants.kSaveAndNext)),
                    ],
                  ),
                  const SizedBox(height: tinierSpacing),
                  Row(
                    children: [
                      SizedBox(
                          width: xxSizedBoxWidth,
                          child: PrimaryButton(
                              onPressed: pageNo.toString() !=
                                  quizMap["questioncount"]
                                  ? () {
                                pageNo++;
                                context
                                    .read<StartCourseCertificateBloc>()
                                    .add(GetQuizQuestions(
                                    pageNo: pageNo,
                                    workforcequizId:
                                    quizMap["userquizid"]));
                              }
                                  : null,
                              textValue: StringConstants.kSkip)),
                      const SizedBox(width: tinierSpacing),
                      SizedBox(
                          width: xSizedBoxWidth,
                          child: PrimaryButton(
                              onPressed: () {
                                context
                                    .read<StartCourseCertificateBloc>()
                                    .add(QuestionAnswerEvent(
                                    questionAnswerMap:
                                    questionAnswerMap));
                              },
                              textValue: StringConstants.kSaveAnswer)),
                    ],
                  ),
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
