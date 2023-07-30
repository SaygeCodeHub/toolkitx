import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../../blocs/checklist/workforce/editAnswer/workforce_checklist_edit_answer_bloc.dart';
import '../../../../blocs/checklist/workforce/editAnswer/workforce_checklist_edit_answer_events.dart';
import '../../../../blocs/checklist/workforce/editAnswer/workforce_checklist_edit_answer_states.dart';
import '../../../../configs/app_color.dart';
import '../../../../data/models/checklist/workforce/workforce_questions_list_model.dart';

typedef DropDownCallBack = Function(String dropDownId, String dropDownString);

class DropDownExpansionTile extends StatelessWidget {
  final String value;
  final DropDownCallBack onValueChanged;
  final List<Questionlist> answerModelList;
  final int index;

  const DropDownExpansionTile(
      {Key? key,
      required this.onValueChanged,
      required this.answerModelList,
      required this.value,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dropDown = value;
    String dropDownId = '';
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
                    key: GlobalKey(),
                    collapsedBackgroundColor: AppColor.offWhite,
                    title: Text((dropDown == "")
                        ? DatabaseUtil.getText('select_item')
                        : dropDown),
                    children: [
                      MediaQuery(
                          data: MediaQuery.of(context)
                              .removePadding(removeTop: true),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  answerModelList[index].queoptions!.length,
                              itemBuilder: (context, listIndex) {
                                return ListTile(
                                    contentPadding: const EdgeInsets.only(
                                        left: tiniestSpacing),
                                    title: Text(answerModelList[index]
                                            .queoptions![listIndex]
                                        ["queoptiontext"]),
                                    onTap: () {
                                      dropDown = answerModelList[index]
                                          .queoptions![listIndex]
                                              ["queoptiontext"]
                                          .toString();
                                      dropDownId = answerModelList[index]
                                          .queoptions![listIndex]["queoptionid"]
                                          .toString();
                                      onValueChanged(
                                          dropDownId.toString(), dropDown);
                                      context
                                          .read<
                                              WorkForceCheckListEditAnswerBloc>()
                                          .add(CheckListEditAnswerEvent(
                                              dropDownValue: dropDown,
                                              multiSelectIdList: [],
                                              multiSelectItem: '',
                                              multiSelectName: '',
                                              multiSelectNameList: []));
                                    });
                              }))
                    ]));
          } else {
            return const SizedBox();
          }
        });
  }
}
