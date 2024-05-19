import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../blocs/certificates/startCourseCertificates/start_course_certificate_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import 'get_topics_certificate_screen.dart';

class GetCourseCertificateScreen extends StatelessWidget {
  static const routeName = 'StartCourseCertificateScreen';

  final String certificateId;

  const GetCourseCertificateScreen({super.key, required this.certificateId});

  @override
  Widget build(BuildContext context) {
    context
        .read<StartCourseCertificateBloc>()
        .add(GetCourseCertificate(certificateId: certificateId));
    return Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<StartCourseCertificateBloc,
                StartCourseCertificateState>(
            buildWhen: (previousState, currentState) =>
                currentState is FetchingGetCourseCertificate ||
                currentState is GetCourseCertificateFetched ||
                currentState is GetCourseCertificateError,
            builder: (context, state) {
              if (state is FetchingGetCourseCertificate) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetCourseCertificateFetched) {
                return Padding(
                    padding: const EdgeInsets.only(
                        left: leftRightMargin,
                        right: leftRightMargin,
                        top: xxTinierSpacing),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              state.getCourseCertificateModel.data[0]
                                  .certificatename,
                              style: Theme.of(context)
                                  .textTheme
                                  .medium
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.black)),
                          const SizedBox(height: xxxTinySpacing),
                          Text(StringConstants.kYouHaveCoursesToComplete,
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.grey)),
                          const SizedBox(height: tinySpacing),
                          ListView.separated(
                              shrinkWrap: true,
                              itemCount:
                                  state.getCourseCertificateModel.data.length,
                              itemBuilder: (context, index) {
                                var data = state.getCourseCertificateModel.data;
                                return Card(
                                    elevation: kSmallElevation,
                                    child: ListTile(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context,
                                              GetTopicCertificateScreen
                                                  .routeName,
                                              arguments: data[index].id);
                                        },
                                        contentPadding:
                                            const EdgeInsets.all(kCardPadding),
                                        title: Text(data[index].name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .small
                                                .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        AppColor.mediumBlack)),
                                        subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                  height: xxxTinierSpacing),
                                              Text(data[index].description,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .xSmall
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              AppColor.grey)),
                                              const SizedBox(
                                                  height: tinySpacing),
                                              Text(
                                                  "${data[index].topiccount} ${StringConstants.kTopic} - ${data[index].quizcount} ${StringConstants.kQuiz}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .xSmall
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: AppColor.grey))
                                            ]),
                                        trailing: Container(
                                            width: kDotContianerSize,
                                            height: kDotContianerSize,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(
                                                            kImageHeight)),
                                                color: data[index]
                                                            .completedstatus ==
                                                        '2'
                                                    ? AppColor.green
                                                    : data[index]
                                                                .completedstatus ==
                                                            '1'
                                                        ? AppColor.orange
                                                        : null))));
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: xxTinierSpacing);
                              })
                        ]));
              } else {
                return const SizedBox.shrink();
              }
            }));
  }
}
