import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/imagePickerBloc/image_picker_bloc.dart';
import 'package:toolkit/blocs/imagePickerBloc/image_picker_event.dart';
import 'package:toolkit/blocs/tankManagement/tank_management_bloc.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/tankManagement/fetch_tank_checklist_question_model.dart';
import 'package:toolkit/screens/tankManagement/widgets/tank_add_image_comment_screen.dart';
import 'package:toolkit/screens/tankManagement/widgets/tank_submit_edit_answer_button.dart';
import 'package:toolkit/utils/tank_checklist_question_util.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/secondary_button.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_card.dart';

class SubmitTankChecklistScreen extends StatelessWidget {
  static const routeName = 'SubmitTankChecklistScreen';
  final Map tankChecklistMap;

  const SubmitTankChecklistScreen({super.key, required this.tankChecklistMap});

  @override
  Widget build(BuildContext context) {
    context
        .read<TankManagementBloc>()
        .add(TankCheckListFetchQuestions(tankChecklistMap: tankChecklistMap));
    context.read<ImagePickerBloc>().pickedImagesList.clear();
    context.read<ImagePickerBloc>().add(PickImageInitial());
    return Scaffold(
      appBar: GenericAppBar(title: tankChecklistMap['title']),
      body: BlocBuilder<TankManagementBloc, TankManagementState>(
          buildWhen: (previousState, currentState) =>
              currentState is TankChecklistQuestionsListFetching ||
              currentState is TankChecklistQuestionsListFetched ||
              currentState is TankCheckListQuestionsListNotFetched,
          builder: (context, state) {
            if (state is TankChecklistQuestionsListFetching) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TankChecklistQuestionsListFetched) {
              tankChecklistMap['checklistId'] =
                  state.fetchTankChecklistQuestionModel.data!.checklistid;
              List<TankQuestionList> answerListModule =
                  state.fetchTankChecklistQuestionModel.data!.questionlist!;
              return Padding(
                  padding: const EdgeInsets.only(
                      left: leftRightMargin,
                      right: leftRightMargin,
                      top: topBottomPadding),
                  child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(children: [
                        ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.fetchTankChecklistQuestionModel
                                .data!.questionlist!.length,
                            itemBuilder: (context, index) {
                              var questionList = state
                                  .fetchTankChecklistQuestionModel
                                  .data!
                                  .questionlist!;
                              return CustomCard(
                                  child: Padding(
                                      padding:
                                          const EdgeInsets.all(kCardPadding),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                  text:
                                                      '${index + 1}] ${questionList[index].title}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .medium,
                                                  children: [
                                                    (questionList[index]
                                                                .ismandatory ==
                                                            1)
                                                        ? TextSpan(
                                                            text: ' *',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .medium)
                                                        : const TextSpan()
                                                  ]),
                                            ),
                                            const SizedBox(
                                                height: tiniestSpacing),
                                            Visibility(
                                              visible: questionList[index]
                                                      .moreinfo !=
                                                  null,
                                              child: Text(
                                                  '${questionList[index].moreinfo}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .xSmall
                                                      .copyWith(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          color: AppColor.grey,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                            ),
                                            const SizedBox(
                                                height: xxTinierSpacing),
                                            TankChecklistQuestionUtil()
                                                .fetchSwitchCaseWidget(
                                                    questionList[index].type,
                                                    index,
                                                    answerListModule,
                                                    state.answerList,
                                                    context),
                                            const SizedBox(
                                                height: tiniestSpacing),
                                            Visibility(
                                                visible:
                                                    questionList[index].title ==
                                                        "Abdampftemperatur",
                                                child: Text(
                                                    '${DatabaseUtil.getText('RangeMessage')} ${questionList[index].minval} ${DatabaseUtil.getText('to')} ${questionList[index].maxval}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .xSmall
                                                        .copyWith(
                                                            color: AppColor
                                                                .errorRed,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400))),
                                            const SizedBox(
                                                height: tiniestSpacing),
                                            SecondaryButton(
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      TankAddImageCommentScreen
                                                          .routeName,
                                                      arguments:
                                                          questionList[index]
                                                              .queresponseid
                                                              .toString());
                                                },
                                                textValue:
                                                    StringConstants.kAddImages)
                                          ])));
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(height: xxTinySpacing);
                            }),
                        const SizedBox(height: xxxSmallerSpacing),
                      ])));
            } else if (state is TankCheckListQuestionsListNotFetched) {
              return const Center(child: Text(StringConstants.kNoRecordsFound));
            }
            return const SizedBox();
          }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: TankSubmitEditAnswerButton(
            answerList: context.read<TankManagementBloc>().answerList,
            tankChecklistDataMap: tankChecklistMap),
      ),
    );
  }
}
