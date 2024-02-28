import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/certificates/widgets/finish_button_body.dart';
import 'package:toolkit/screens/certificates/widgets/get_quiz_questions_body.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../blocs/certificates/startCourseCertificates/start_course_certificate_bloc.dart';
import '../../configs/app_spacing.dart';

class QuizQuestionsScreen extends StatelessWidget {
  static const routeName = 'QuizQuestionsScreen';

  QuizQuestionsScreen({super.key, required this.quizMap});

  final Map quizMap;
  static int pageNo = 1;
  final Map questionAnswerMap = {};

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context.read<StartCourseCertificateBloc>().add(GetQuizQuestions(
        workforcequizId: quizMap["userquizid"], pageNo: pageNo));
    return Scaffold(
      appBar: const GenericAppBar(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(tinySpacing),
        child: FinishButtonBody(questionAnswerMap: questionAnswerMap),
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
            if (state is QuizQuestionAnswerSaved) {
              showCustomSnackBar(context, StringConstants.kAnswerSaved, "");
            } else if (state is QuizQuestionAnswerError) {
              showCustomSnackBar(context, StringConstants.kAnswerNotSaved, "");
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
              questionAnswerMap['questionid'] =
                  state.getQuizQuestionsModel.data.questionid;
              questionAnswerMap['idm'] = quizMap["topicId"];
              questionAnswerMap['workforcequizid'] = quizMap["userquizid"];
              questionAnswerMap["certificateId"] = quizMap["certificateId"];
              questionAnswerMap["quizId"] = quizMap["quizId"];
              return Column(
                children: [
                  GetQuizQuestionsBody(
                      data: state.getQuizQuestionsModel.data,
                      answerId: state.answerId,
                      getQuizQuestionsModel: state.getQuizQuestionsModel,
                      questionAnswerMap: questionAnswerMap),
                  const SizedBox(height: mediumSpacing),
                  Row(
                    children: [
                      Expanded(
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
                      Expanded(
                          child: PrimaryButton(
                              onPressed: pageNo.toString() !=
                                      quizMap["questioncount"]
                                  ? () {
                                      pageNo++;
                                      context
                                          .read<StartCourseCertificateBloc>()
                                          .add(SaveQuizQuestionAnswer(
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
                              textValue: StringConstants.kSaveAndNext))
                    ],
                  ),
                  const SizedBox(height: tinierSpacing),
                  Row(
                    children: [
                      Expanded(
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
                      Expanded(
                          child: PrimaryButton(
                              onPressed: () {
                                context.read<StartCourseCertificateBloc>().add(
                                    SaveQuizQuestionAnswer(
                                        questionAnswerMap: questionAnswerMap));
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
