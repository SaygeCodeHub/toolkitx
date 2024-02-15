import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/loto/loto_details/loto_details_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../configs/app_color.dart';
import '../../../data/models/loto/fetch_loto_checklist_questions_model.dart';

typedef CreatedForListCallBack = Function(List id);

class LotoSelectMultiChecklistAnswer extends StatelessWidget {
  const LotoSelectMultiChecklistAnswer(
      {super.key,
      required this.queoptions,
      required this.selectedAnswerList,
      required this.onCreatedForChanged});

  final List selectedAnswerList;
  final List<QueOption> queoptions;
  final CreatedForListCallBack onCreatedForChanged;

  void _checkboxChange(isSelected, answerId) {
    if (isSelected) {
      selectedAnswerList.add(answerId);
      onCreatedForChanged(selectedAnswerList);
    } else {
      selectedAnswerList.remove(answerId);
      onCreatedForChanged(selectedAnswerList);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    context
        .read<LotoDetailsBloc>()
        .add(SelectLotoChecklistMultiAnswer(isChecked: isChecked));
    return BlocBuilder<LotoDetailsBloc, LotoDetailsState>(
      buildWhen: (previousState, currentState) =>
          currentState is LotoMultiCheckListAnswerSelected,
      builder: (context, state) {
        if (state is LotoMultiCheckListAnswerSelected) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: queoptions.length,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    activeColor: AppColor.deepBlue,
                    controlAffinity: ListTileControlAffinity.trailing,
                    title: Text(queoptions[index].queoptiontext,
                        style: Theme.of(context).textTheme.small.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColor.black)),
                    value: selectedAnswerList
                        .contains(queoptions[index].queoptionid),
                    onChanged: (isChecked) {
                      _checkboxChange(isChecked, queoptions[index].queoptionid);
                      context.read<LotoDetailsBloc>().add(
                          SelectLotoChecklistMultiAnswer(
                              isChecked: isChecked!));
                    });
              },
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
