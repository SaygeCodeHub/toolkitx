import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/certificates/startCourseCertificates/start_course_certificate_bloc.dart';
import 'package:toolkit/widgets/android_pop_up.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../../utils/constants/string_constants.dart';
import '../../../widgets/primary_button.dart';

class FinishButtonBody extends StatelessWidget {
  FinishButtonBody({
    super.key,
    required this.questionAnswerMap,
  });

  final Map finishQuizMap = {};
  final Map questionAnswerMap;

  @override
  Widget build(BuildContext context) {
    return BlocListener<StartCourseCertificateBloc,
        StartCourseCertificateState>(
      listener: (context, state) {
        if (state is CertificateQuizSubmitting) {
          ProgressBar.show(context);
        } else if (state is CertificateQuizSubmitted) {
          ProgressBar.dismiss(context);
          showCustomSnackBar(context, StringConstants.kQuizSubmitted, "");
          Navigator.pop(context);
          context.read<StartCourseCertificateBloc>().add(GetTopicCertificate(
              courseId: context.read<StartCourseCertificateBloc>().courseId));
        } else if (state is CertificateQuizSubmitError) {
          ProgressBar.dismiss(context);
          showCustomSnackBar(context, StringConstants.kQuizSubmittingError, "");
        }
      },
      child: PrimaryButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AndroidPopUp(
                titleValue: StringConstants.kSubmitQuiz,
                contentValue: StringConstants.kSureToSubmitTheQuiz,
                onPrimaryButton: () {
                  Map finishQuizMap = {
                    'idm': questionAnswerMap['idm'],
                    "workforcequizid": questionAnswerMap['workforcequizid'],
                    "answer": questionAnswerMap['answer'],
                    "questionid": questionAnswerMap["questionid"],
                    "quizid": questionAnswerMap["quizId"],
                    "certificateid": questionAnswerMap["certificateId"]
                  };
                  context
                      .read<StartCourseCertificateBloc>()
                      .add(SubmitCertificateQuiz(finishQuizMap: finishQuizMap));
                  Navigator.pop(context);
                },
              ),
            );
          },
          textValue: StringConstants.kFinishQuiz),
    );
  }
}
