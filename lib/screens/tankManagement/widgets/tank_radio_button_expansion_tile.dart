import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/tankManagement/fetch_tank_checklist_question_model.dart';
import '../../../../configs/app_color.dart';
import '../../../../utils/database_utils.dart';
import '../../../../widgets/expansion_tile_border.dart';
import '../../../configs/app_spacing.dart';

typedef RadioButtonCallBack = Function(String radioId, String radioValue);

class TankRadioButtonExpansionTile extends StatefulWidget {
  final List<TankQuestionList> answerModelList;
  final int index;
  final RadioButtonCallBack onRadioButtonChecked;
  final String editValue;

  const TankRadioButtonExpansionTile(
      {super.key,
      required this.answerModelList,
      required this.index,
      required this.onRadioButtonChecked,
      required this.editValue});

  @override
  State<TankRadioButtonExpansionTile> createState() =>
      _TankRadioButtonExpansionTileState();
}

class _TankRadioButtonExpansionTileState
    extends State<TankRadioButtonExpansionTile> {
  String radioValue = '';

  @override
  void initState() {
    radioValue = widget.editValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: AppColor.transparent),
        child: ExpansionTile(
            collapsedShape: ExpansionTileBorder().buildOutlineInputBorder(),
            collapsedBackgroundColor: AppColor.white,
            backgroundColor: AppColor.white,
            shape: ExpansionTileBorder().buildOutlineInputBorder(),
            maintainState: true,
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
                  itemCount:
                      widget.answerModelList[widget.index].queoptions!.length,
                  itemBuilder: (BuildContext context, int listIndex) {
                    return RadioListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: xxxTinierSpacing),
                        dense: true,
                        activeColor: AppColor.deepBlue,
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: Text(widget.answerModelList[widget.index]
                            .queoptions![listIndex]["queoptiontext"]),
                        value: widget.answerModelList[widget.index]
                            .queoptions![listIndex]["queoptionid"]
                            .toString(),
                        groupValue: radioValue,
                        onChanged: (value) {
                          setState(() {
                            value = widget.answerModelList[widget.index]
                                .queoptions![listIndex]["queoptionid"]
                                .toString();
                            radioValue = widget.answerModelList[widget.index]
                                .queoptions![listIndex]["queoptiontext"];
                            widget.onRadioButtonChecked(
                                value.toString(), radioValue);
                          });
                        });
                  })
            ]));
  }
}
