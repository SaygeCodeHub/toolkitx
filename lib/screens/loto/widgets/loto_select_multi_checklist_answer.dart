import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../configs/app_color.dart';
import '../../../data/models/loto/fetch_loto_checklist_questions_model.dart';

typedef CreatedForListCallBack = Function(List id);

class LotoSelectMultiChecklistAnswer extends StatefulWidget {
  const LotoSelectMultiChecklistAnswer(
      {super.key, required this.queoptions, required this.onCreatedForChanged});

  final List<QueOption> queoptions;
  final CreatedForListCallBack onCreatedForChanged;

  @override
  State<LotoSelectMultiChecklistAnswer> createState() =>
      _LotoSelectMultiChecklistAnswerState();
}

class _LotoSelectMultiChecklistAnswerState
    extends State<LotoSelectMultiChecklistAnswer> {
  List selectedAnswerList = [];

  void _checkboxChange(isSelected, answerId) {
    if (isSelected) {
      selectedAnswerList.add(answerId);
      widget.onCreatedForChanged(selectedAnswerList);
    } else {
      selectedAnswerList.remove(answerId);
      widget.onCreatedForChanged(selectedAnswerList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.queoptions.length,
        itemBuilder: (BuildContext context, int index) {
          return CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              activeColor: AppColor.deepBlue,
              controlAffinity: ListTileControlAffinity.trailing,
              title: Text(widget.queoptions[index].queoptiontext,
                  style: Theme.of(context).textTheme.small.copyWith(
                      fontWeight: FontWeight.w400, color: AppColor.black)),
              value: selectedAnswerList
                  .contains(widget.queoptions[index].queoptionid),
              onChanged: (isChecked) {
                setState(() {
                  isChecked = isChecked!;
                  _checkboxChange(
                      isChecked, widget.queoptions[index].queoptionid);
                });
              });
        },
      ),
    );
  }
}
