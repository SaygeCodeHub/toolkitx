import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/certificates/feedbackCertificates/feedback_certificate_event.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/certificates/feedbackCertificates/feedback_certificate_bloc.dart';
import '../../blocs/certificates/feedbackCertificates/feedback_certificate_state.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_card.dart';

class FeedbackCertificateScreen extends StatelessWidget {
  static const routeName = 'FeedbackCertificateScreen';
  const FeedbackCertificateScreen({super.key, required this.getdetailsMap});
  final Map getdetailsMap;

  @override
  Widget build(BuildContext context) {
    context.read<FeedbackCertificateBloc>().add(FetchFeedbackCertificate(certificateId: getdetailsMap["id"]));
    return Scaffold(
      appBar: GenericAppBar(title: getdetailsMap["title"],),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: SafeArea(
          child: BlocBuilder<FeedbackCertificateBloc, FeedbackCertificateState>(
            builder: (context, state){
              if(state is FeedbackCertificateFetching){
                return const Center(child: CircularProgressIndicator(),);
              } else if(state is FeedbackCertificateFetched){
              return ListView.separated(
                itemCount: state.feedbackCertificateModel.data.questions.length, itemBuilder: (context, index) {
                return CustomCard(
                    child: ListTile(
                      onTap: () {},
                      title: Text("${index+1}. ${state.feedbackCertificateModel.data.questions[index].questiontext}",
                        style: Theme
                            .of(context)
                            .textTheme
                            .small
                            .copyWith(
                            fontWeight:
                            FontWeight.w500,
                            color: AppColor.black),
                      ),
                      subtitle: Text(state.feedbackCertificateModel.data.questions[index].answer,
                        style: Theme
                            .of(context)
                            .textTheme
                            .xSmall
                            .copyWith(
                            fontWeight:
                            FontWeight.w500,
                            color: AppColor.grey),
                      ),
                    )
                );
              }, separatorBuilder: (context, index) {
                return const SizedBox(
                    height: tinierSpacing);
              },);
              } else{
                return const SizedBox.shrink();
              }
            }
          ),
        ),
      ),
    );
  }
}
