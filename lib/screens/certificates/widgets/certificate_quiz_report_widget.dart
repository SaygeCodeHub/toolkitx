import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/certificates/startCourseCertificates/start_course_certificate_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/certificates/get_workforce_quiz_model.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../../configs/app_color.dart';

class CertificateQuizReportWidget extends StatelessWidget {
  const CertificateQuizReportWidget(
      {super.key, required this.workforceQuizData, required this.quizId});

  final WorkforceQuizData workforceQuizData;
  final String quizId;

  @override
  Widget build(BuildContext context) {
    context
        .read<StartCourseCertificateBloc>()
        .add(FetchCertificateQuizReport(workforceQuizId: quizId));
    return BlocConsumer<StartCourseCertificateBloc,
            StartCourseCertificateState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CertificateQuizReportFetching) {
            return Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3),
                child: const Center(child: CircularProgressIndicator()));
          } else if (state is CertificateQuizReportFetched) {
            var data = state.fetchQuizReportModel.data;
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                          '${workforceQuizData.questioncount} ${DatabaseUtil.getText('Questions')} :     ${workforceQuizData.totalmarks} ${DatabaseUtil.getText('Marks')} ',
                          style: Theme.of(context).textTheme.xSmall.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColor.mediumBlack))),
                  const SizedBox(height: xxTinierSpacing),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    workforceQuizData.passed != '1'
                        ? Text(StringConstants.kYouFailed,
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColor.errorRed))
                        : Text(StringConstants.kYouPassed,
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColor.green)),
                    const SizedBox(width: xxTinySpacing),
                    Text(
                        '${DatabaseUtil.getText('Score')} : ${workforceQuizData.score}',
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColor.mediumBlack))
                  ]),
                  const SizedBox(height: xxTinySpacing),
                  Visibility(
                      visible: workforceQuizData.isretake == '1',
                      child: PrimaryButton(
                          onPressed: () {},
                          textValue: DatabaseUtil.getText('retakebtn'))),
                  const SizedBox(height: xxTinySpacing),
                  ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return CustomCard(
                            child: Padding(
                                padding: const EdgeInsets.all(xxxTinierSpacing),
                                child: ListTile(
                                    title: data[index].answerstatus == '1'
                                        ? Text(DatabaseUtil.getText('Correct'),
                                            style: Theme.of(context)
                                                .textTheme
                                                .xSmall
                                                .copyWith(
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColor.deepBlue))
                                        : Text(
                                            DatabaseUtil.getText('Incorrect'),
                                            style: Theme.of(context)
                                                .textTheme
                                                .xSmall
                                                .copyWith(
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColor.deepBlue)),
                                    subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                              height: tiniestSpacing),
                                          Text(
                                              'Q${index + 1}: ${data[index].title}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .xSmall
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColor
                                                          .mediumBlack)),
                                          const Divider(color: AppColor.black),
                                          Text(data[index].workforceanswer,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .xSmall
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColor.black))
                                        ]))));
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: xxTinierSpacing);
                      })
                ]);
          } else if (state is CertificateQuizReportNotFetched) {
            return Center(child: Text(state.getError));
          }
          return const SizedBox.shrink();
        });
  }
}
