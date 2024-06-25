import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/checklist/workforce/workforce_questions_list_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/error_section.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../../blocs/checklist/workforce/rejectReason/workforce_checklist_reject_reason_bloc.dart';
import '../../../blocs/checklist/workforce/rejectReason/workforce_checklist_reject_reason_event.dart';
import '../../../blocs/checklist/workforce/rejectReason/workforce_checklist_reject_reason_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_text_field.dart';

class RejectReasonsScreen extends StatelessWidget {
  static const routeName = 'RejectReasonsScreen';
  final Map checklistDataMap;

  const RejectReasonsScreen({Key? key, required this.checklistDataMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String reasonValue = '';
    context
        .read<WorkForceCheckListSaveRejectBloc>()
        .add(CheckListFetchRejectReasons());
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('ChecklistReject')),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomPadding),
            child: BlocConsumer<WorkForceCheckListSaveRejectBloc,
                    WorkForceCheckListRejectReasonStates>(
                buildWhen: (previousState, currentState) =>
                    currentState is CheckListRejectReasonsFetched ||
                    currentState is CheckListFetchingRejectReasons ||
                    currentState is CheckListRejectReasonsError,
                listener: (context, state) {
                  if (state is SavingCheckListRejectReasons) {
                    ProgressBar.show(context);
                  } else if (state is CheckListRejectReasonsSaved) {
                    ProgressBar.dismiss(context);
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(
                        context, WorkForceQuestionsScreen.routeName,
                        arguments: checklistDataMap);
                  } else if (state is CheckListRejectReasonsNotSaved) {
                    ProgressBar.dismiss(context);
                    showCustomSnackBar(
                        context, state.message, StringConstants.kOk);
                  }
                },
                builder: (context, state) {
                  if (state is CheckListFetchingRejectReasons) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CheckListRejectReasonsFetched) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomCard(
                              child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state
                                      .getCheckListRejectReasonsModel
                                      .data!
                                      .length,
                                  itemBuilder: (context, index) {
                                    return RadioListTile(
                                        dense: true,
                                        activeColor: AppColor.deepBlue,
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                        title: Text(state
                                            .getCheckListRejectReasonsModel
                                            .data![index]
                                            .reasontext),
                                        value: state
                                            .getCheckListRejectReasonsModel
                                            .data![index]
                                            .reasontext,
                                        groupValue: state.reason,
                                        onChanged: (value) {
                                          value = state
                                              .getCheckListRejectReasonsModel
                                              .data![index]
                                              .reasontext;
                                          context
                                              .read<
                                                  WorkForceCheckListSaveRejectBloc>()
                                              .add(CheckListSelectRejectReasons(
                                                  getCheckListRejectReasonsModel:
                                                      state
                                                          .getCheckListRejectReasonsModel,
                                                  reason: value));
                                        });
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Divider(
                                        thickness: kDividerThickness,
                                        height: kDividerHeight);
                                  })),
                          const SizedBox(height: xxTinySpacing),
                          TextFieldWidget(
                            textInputAction: TextInputAction.done,
                            maxLines: 6,
                            hintText: StringConstants.kEnterReason,
                            onTextFieldChanged: (String textValue) {
                              reasonValue = textValue;
                            },
                          ),
                          const SizedBox(height: xxTinySpacing),
                          PrimaryButton(
                              onPressed: () {
                                context
                                    .read<WorkForceCheckListSaveRejectBloc>()
                                    .add(CheckListSaveRejectReasons(
                                        reason: (state.reason == "")
                                            ? reasonValue
                                            : state.reason,
                                        allCheckListDataMap: checklistDataMap));
                              },
                              textValue: StringConstants.kSave)
                        ]);
                  } else if (state is CheckListRejectReasonsError) {
                    return GenericReloadButton(
                        onPressed: () {
                          GenericReloadButton(
                              onPressed: () {
                                context
                                    .read<WorkForceCheckListSaveRejectBloc>()
                                    .add(CheckListFetchRejectReasons());
                              },
                              textValue: StringConstants.kReload);
                        },
                        textValue: StringConstants.kReload);
                  } else {
                    return const SizedBox();
                  }
                })));
  }
}
