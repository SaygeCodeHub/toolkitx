import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../../blocs/checklist/workforce/editAnswer/workforce_checklist_edit_answer_bloc.dart';
import '../../../../blocs/checklist/workforce/editAnswer/workforce_checklist_edit_answer_events.dart';
import '../../../../blocs/checklist/workforce/editAnswer/workforce_checklist_edit_answer_states.dart';
import '../../../../configs/app_color.dart';
import '../../../../data/models/checklist/workforce/workforce_questions_list_model.dart';
import '../../../../utils/database_utils.dart';

typedef RadioButtonCallBack = Function(String radioId, String radioValue);

class RadioButtonExpansionTile extends StatelessWidget {
  final List<Questionlist> answerModelList;
  final int index;
  final RadioButtonCallBack onRadioButtonChecked;
  final String editValue;

  const RadioButtonExpansionTile(
      {Key? key,
      required this.answerModelList,
      required this.index,
      required this.onRadioButtonChecked,
      required this.editValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String radioValue = editValue;
    return BlocBuilder<WorkForceCheckListEditAnswerBloc,
            WorkForceCheckListEditAnswerStates>(
        buildWhen: (previousState, currentState) =>
            currentState is CheckListAnswersEdited,
        builder: (context, state) {
          if (state is CheckListAnswersEdited) {
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    collapsedBackgroundColor: AppColor.offWhite,
                    maintainState: true,
                    iconColor: AppColor.deepBlue,
                    textColor: AppColor.black,
                    key: GlobalKey(),
                    title: Text(
                        (radioValue == '')
                            ? DatabaseUtil.getText('select_item')
                            : radioValue,
                        style: Theme.of(context).textTheme.xSmall),
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: answerModelList[index].queoptions!.length,
                          itemBuilder: (BuildContext context, int listIndex) {
                            return RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                activeColor: AppColor.deepBlue,
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                title: Text(answerModelList[index]
                                    .queoptions![listIndex]["queoptiontext"]),
                                value: answerModelList[index]
                                    .queoptions![listIndex]["queoptionid"]
                                    .toString(),
                                groupValue: state.radioValue,
                                onChanged: (value) {
                                  value = answerModelList[index]
                                      .queoptions![listIndex]["queoptionid"]
                                      .toString();
                                  radioValue = answerModelList[index]
                                      .queoptions![listIndex]["queoptiontext"];
                                  onRadioButtonChecked(value, radioValue);
                                  context
                                      .read<WorkForceCheckListEditAnswerBloc>()
                                      .add(CheckListEditAnswerEvent(
                                          multiSelectIdList: [],
                                          radioValue: value,
                                          multiSelectItem: '',
                                          multiSelectName: '',
                                          multiSelectNameList: []));
                                });
                          })
                    ]));
          } else {
            return const SizedBox();
          }
        });
  }
}
