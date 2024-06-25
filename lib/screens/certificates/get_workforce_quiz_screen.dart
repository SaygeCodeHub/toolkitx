import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/certificates/widgets/certificate_quiz_report_widget.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../blocs/certificates/startCourseCertificates/start_course_certificate_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import 'get_quiz_questions_screen.dart';

class GetWorkforceScreen extends StatelessWidget {
  static const routeName = 'GetWorkforceScreen';

  const GetWorkforceScreen({super.key, required this.workforceQuizMap});

  final Map workforceQuizMap;

  @override
  Widget build(BuildContext context) {
    context
        .read<StartCourseCertificateBloc>()
        .add(GetWorkforceQuiz(quizId: workforceQuizMap["quizId"]));
    return Scaffold(
      appBar: const GenericAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: BlocConsumer<StartCourseCertificateBloc,
            StartCourseCertificateState>(
          listener: (context, state) {
            if (state is CertificateQuizStarting) {
              ProgressBar.show(context);
            } else if (state is CertificateQuizStarted) {
              ProgressBar.dismiss(context);
              workforceQuizMap["userquizid"] = state.startQuizModel.message;
              Navigator.pushNamed(context, QuizQuestionsScreen.routeName,
                  arguments: workforceQuizMap);
            } else if (state is CertificateQuizNotStarted) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.getError, '');
            }
          },
          buildWhen: (previousState, currentState) =>
              currentState is WorkforceQuizFetching ||
              currentState is WorkforceQuizFetched ||
              currentState is WorkforceQuizError,
          builder: (context, state) {
            if (state is WorkforceQuizFetching) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WorkforceQuizFetched) {
              var data = state.getWorkforceQuizModel.data;
              workforceQuizMap["questioncount"] = data.questioncount;
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.certificatename,
                        style: Theme.of(context).textTheme.small.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColor.black)),
                    const SizedBox(height: tinierSpacing),
                    Text("${data.quizname}  ->  ${data.coursename}",
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColor.mediumBlack)),
                    const SizedBox(height: xxxSmallestSpacing),
                    Visibility(
                      visible: data.error.isNotEmpty,
                      child: Text(data.error,
                          style: Theme.of(context).textTheme.xSmall.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColor.errorRed)),
                    ),
                    Visibility(
                      visible: data.showstartquiz == '1',
                      child: PrimaryButton(
                          onPressed: () {
                            context.read<StartCourseCertificateBloc>().add(
                                StartCertificateQuiz(
                                    quizId: workforceQuizMap["quizId"]));
                          },
                          textValue: StringConstants.kStartQuiz),
                    ),
                    Visibility(
                      visible: (data.isquizrunning == '1'),
                      child: PrimaryButton(
                          onPressed: () {
                            context.read<StartCourseCertificateBloc>().add(
                                StartCertificateQuiz(
                                    quizId: workforceQuizMap["quizId"]));
                          },
                          textValue: "Continue quiz"),
                    ),
                    Visibility(
                      visible: data.showquizreport == '1',
                      child: CertificateQuizReportWidget(
                          workforceQuizData: state.getWorkforceQuizModel.data,
                          quizId: state.getWorkforceQuizModel.data.userquizid),
                    ),
                    const SizedBox(height: xxTinySpacing),
                  ],
                ),
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
