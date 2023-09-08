import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/certificates/startCourseCertificates/start_course_certificate_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/certificates/get_topic_certificate_body.dart';

import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';

class GetTopicCertificateScreen extends StatelessWidget {
  static const routeName = 'GetTopicCertificateScreen';
  const GetTopicCertificateScreen({super.key, required this.courseId});
  final String courseId;

  @override
  Widget build(BuildContext context) {
    context
        .read<StartCourseCertificateBloc>()
        .add(GetTopicCertificate(courseId: courseId));
    return Scaffold(
      appBar: AppBar(),
      body:
          BlocBuilder<StartCourseCertificateBloc, StartCourseCertificateState>(
        buildWhen: (previousState, currentState) =>
          currentState is FetchingGetTopicCertificate ||
              currentState is GetTopicCertificateFetched ||
              currentState is GetTopicCertificateError,
        builder: (context, state) {
          if (state is FetchingGetTopicCertificate) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetTopicCertificateFetched) {
            return Padding(
              padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(state.getTopicCertificateModel.data.certificatename,
                          style: Theme.of(context).textTheme.medium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColor.black)),
                      const SizedBox(
                        height: tiniestSpacing,
                      ),
                      Text(state.getTopicCertificateModel.data.coursename,
                          style: Theme.of(context).textTheme.xSmall.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColor.mediumBlack)),
                      const SizedBox(
                        height: tiniestSpacing,
                      ),
                      Text(
                          state.getTopicCertificateModel.data.coursedescription,
                          style: Theme.of(context).textTheme.xxSmall.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColor.grey))
                    ],
                  ),
                  const SizedBox(
                    height: smallestSpacing,
                  ),
                  GetTopicCertificateBody(
                    data: state.getTopicCertificateModel.data,
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
