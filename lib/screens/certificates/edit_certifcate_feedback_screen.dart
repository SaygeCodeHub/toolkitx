import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/certificates/widgets/feedback_answer_expansion_tile.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../blocs/certificates/feedbackCertificates/feedback_certificate_bloc.dart';
import '../../blocs/certificates/feedbackCertificates/feedback_certificate_event.dart';
import '../../blocs/certificates/feedbackCertificates/feedback_certificate_state.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';

class EditCertificateFeedbackScreen extends StatelessWidget {
  const EditCertificateFeedbackScreen({super.key, required this.getDetailsMap});

  static const routeName = 'EditCertificateFeedbackScreen';
  final Map getDetailsMap;
  static List feedbackAnswerList = [];

  @override
  Widget build(BuildContext context) {
    feedbackAnswerList.clear();
    context
        .read<FeedbackCertificateBloc>()
        .add(FetchFeedbackCertificate(certificateId: getDetailsMap["id"]));
    return Scaffold(
      appBar: GenericAppBar(title: getDetailsMap['title']),
      body: Padding(
        padding: const EdgeInsets.only(top: xxTinierSpacing),
        child: SafeArea(
          child:
              BlocConsumer<FeedbackCertificateBloc, FeedbackCertificateState>(
                  listener: (context, state) {
            if (state is CertificateFeedbackSaving) {
              ProgressBar.show(context);
            } else if (state is CertificateFeedbackSaved) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
            } else if (state is CertificateFeedbackNotSaved) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.getError, '');
            }
          }, builder: (context, state) {
            if (state is FeedbackCertificateFetching) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FeedbackCertificateFetched) {
              return ListView.separated(
                itemCount: state.feedbackCertificateModel.data.questions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      "${index + 1}. ${state.feedbackCertificateModel.data.questions[index].questiontext}",
                      style: Theme.of(context).textTheme.small.copyWith(
                          fontWeight: FontWeight.w500, color: AppColor.black),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: tiniestSpacing),
                      child: FeedbackAnswerExpansionTile(
                        onFeedbackAnswerChecked: (questionId, answer) {
                          final existingIndex = feedbackAnswerList.indexWhere(
                              (element) =>
                                  element["questionid"] ==
                                  state.feedbackCertificateModel.data
                                      .questions[index].id);

                          if (existingIndex >= 0) {
                            feedbackAnswerList[existingIndex]["answer"] =
                                answer;
                          } else {
                            feedbackAnswerList.add({
                              "questionid": state.feedbackCertificateModel.data
                                  .questions[index].id,
                              "answer": answer
                            });
                          }
                        },
                        editValue: state.feedbackCertificateModel.data
                            .questions[index].answer,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: tinierSpacing);
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: PrimaryButton(
            onPressed: () {
              context.read<FeedbackCertificateBloc>().add(
                  SaveCertificateFeedback(
                      feedbackAnswerList: feedbackAnswerList,
                      certificateId: getDetailsMap["id"]));
            },
            textValue: StringConstants.kSave),
      ),
    );
  }
}
