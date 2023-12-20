import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/loto/widgets/start_loto_screen.dart';

import '../../../blocs/loto/loto_details/loto_details_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';
import '../../checklist/workforce/widgets/upload_image_section.dart';
import 'answer_option_expansion_tile.dart';

class StartLotoBody extends StatelessWidget {
  const StartLotoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: leftRightMargin),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Text(DatabaseUtil.getText("LOTOREMOVEMESSAGEFORUSERS"),
                  textAlign: TextAlign.justify),
              const SizedBox(height: xxLargeSpacing),
              BlocBuilder<LotoDetailsBloc, LotoDetailsState>(
                  buildWhen: (previousState, currentState) =>
                      currentState is LotoChecklistQuestionsFetching ||
                      currentState is LotoChecklistQuestionsFetched ||
                      currentState is LotoChecklistQuestionsNotFetched,
                  builder: (context, state) {
                    if (state is LotoChecklistQuestionsFetching) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is LotoChecklistQuestionsFetched) {
                      var questionList = state
                          .fetchLotoChecklistQuestionsModel.data!.questionlist;
                      return ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.fetchLotoChecklistQuestionsModel
                              .data!.questionlist!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            StartLotoScreen.saveLotoChecklistMap["questionid"] =
                                questionList![index].id;
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(questionList[index].title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .small
                                          .copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.black)),
                                  const SizedBox(height: xxTinierSpacing),
                                  state.fetchLotoChecklistQuestionsModel.data!
                                              .questionlist![index].type !=
                                          6
                                      ? AnswerOptionExpansionTile(
                                          queOptionList: state
                                              .fetchLotoChecklistQuestionsModel
                                              .data!
                                              .questionlist![index]
                                              .queoptions,
                                          startLotoMap:
                                              StartLotoScreen.startLotoMap,
                                          questionId: state
                                              .fetchLotoChecklistQuestionsModel
                                              .data!
                                              .questionlist![index]
                                              .id,
                                        )
                                      : UploadImageMenu(
                                          isFromCertificate: true,
                                          onUploadImageResponse:
                                              (List imageList) {
                                            context
                                                .read<LotoDetailsBloc>()
                                                .answerList
                                                .add({
                                              "questionid": state
                                                  .fetchLotoChecklistQuestionsModel
                                                  .data!
                                                  .questionlist![index]
                                                  .id,
                                              "answer": imageList
                                                  .toString()
                                                  .replaceAll("[", "")
                                                  .replaceAll("]", "")
                                            });
                                          },
                                        ),
                                ]);
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          });
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
            ],
          ),
        ));
  }
}