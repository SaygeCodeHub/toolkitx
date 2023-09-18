import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../blocs/certificates/startCourseCertificates/start_course_certificate_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';

class GetWorkforceScreen extends StatelessWidget {
  static const routeName = 'GetWorkforceScreen';
  const GetWorkforceScreen({super.key, required this.quizId});
  final String quizId;

  @override
  Widget build(BuildContext context) {
    context
        .read<StartCourseCertificateBloc>()
        .add(GetWorkforceQuiz(quizId: quizId));
    return Scaffold(
      appBar: const GenericAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
          left: leftRightMargin,
          right: leftRightMargin,
          top: xxTinierSpacing,
        ),
        child: BlocBuilder<StartCourseCertificateBloc,
            StartCourseCertificateState>(
          buildWhen: (previousState, currentState) =>
              currentState is WorkforceQuizFetching ||
              currentState is WorkforceQuizFetched ||
              currentState is WorkforceQuizError,
          builder: (context, state) {
            if (state is WorkforceQuizFetching) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WorkforceQuizFetched) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(state.getWorkforceQuizModel.data.certificatename,
                      style: Theme.of(context).textTheme.small.copyWith(
                          fontWeight: FontWeight.w600, color: AppColor.black)),
                  const SizedBox(height: tinierSpacing),
                  Text(state.getWorkforceQuizModel.data.quizname,
                      style: Theme.of(context).textTheme.xSmall.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColor.mediumBlack)),
                  const SizedBox(height: tinierSpacing),
                  Text(state.getWorkforceQuizModel.data.coursename,
                      style: Theme.of(context).textTheme.xSmall.copyWith(
                          fontWeight: FontWeight.w600, color: AppColor.grey)),
                  const SizedBox(height: xxxSmallestSpacing),
                  PrimaryButton(onPressed: () {}, textValue: 'Start quiz')
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