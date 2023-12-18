import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/loto/loto_details/loto_details_bloc.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/loto/widgets/answer_option_expansion_tile.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../checklist/workforce/widgets/upload_image_section.dart';

class StartLotoScreen extends StatelessWidget {
  static const routeName = "StartLotoScreen";
  static Map startLotoMap = {};
  static Map saveLotoChecklistMap = {};

  const StartLotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PickAndUploadImageBloc>().isInitialUpload = true;
    context.read<PickAndUploadImageBloc>().add(UploadInitial());
    context.read<LotoDetailsBloc>().add(FetchLotoChecklistQuestions());
    context.read<LotoDetailsBloc>().answerList = [];
    startLotoMap = {};
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText("StartLotoButton")),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(leftRightMargin),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: xxxSizedBoxWidth,
                      child: PrimaryButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          textValue: DatabaseUtil.getText("buttonBack"))),
                  SizedBox(
                      width: xxSizedBoxWidth,
                      child: BlocConsumer<LotoDetailsBloc, LotoDetailsState>(
                          listener: (context, state) {
                            if (state is LotoStarting) {
                              ProgressBar.show(context);
                            } else if (state is LotoStarted) {
                              ProgressBar.dismiss(context);
                              showCustomSnackBar(
                                  context, StringConstants.kLotoStarted, '');
                            } else if (state is LotoNotStarted) {
                              ProgressBar.dismiss(context);
                              showCustomSnackBar(context, state.getError, '');
                            }
                          },
                          buildWhen: (previousState, currentState) =>
                              currentState is LotoChecklistQuestionsFetched,
                          builder: (context, state) {
                            if (state is LotoChecklistQuestionsFetched) {
                              return Visibility(
                                visible: state.fetchLotoChecklistQuestionsModel
                                        .data!.checklistArray!.length >
                                    1,
                                replacement: PrimaryButton(
                                    onPressed: () {
                                      saveLotoChecklistMap = {
                                        "checklistid": state
                                            .fetchLotoChecklistQuestionsModel
                                            .data!
                                            .checklistid
                                      };
                                      context.read<LotoDetailsBloc>().add(
                                          SaveLotoChecklist(
                                              saveLotoChecklistMap:
                                                  saveLotoChecklistMap));
                                    },
                                    textValue:
                                        DatabaseUtil.getText("nextButtonText")),
                                child: PrimaryButton(
                                    onPressed: () {
                                      context.read<LotoDetailsBloc>().add(
                                          StartLotoEvent(
                                              checklistId: state
                                                  .fetchLotoChecklistQuestionsModel
                                                  .data!
                                                  .checklistid));
                                    },
                                    textValue: DatabaseUtil.getText(
                                        "StartLotoButton")),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          }))
                ])),
        body: Padding(
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
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is LotoChecklistQuestionsFetched) {
                          var questionList = state
                              .fetchLotoChecklistQuestionsModel
                              .data!
                              .questionlist;
                          return ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemCount: state.fetchLotoChecklistQuestionsModel
                                  .data!.questionlist!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                saveLotoChecklistMap["questionid"] =
                                    questionList![index].id;
                                return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              startLotoMap: startLotoMap,
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
            )));
  }
}
