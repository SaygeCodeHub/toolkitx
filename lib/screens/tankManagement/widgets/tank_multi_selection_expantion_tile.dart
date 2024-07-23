import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/tankManagement/tank_management_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/tankManagement/fetch_tank_checklist_question_model.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../../configs/app_color.dart';
import '../../../../widgets/expansion_tile_border.dart';

typedef CheckBoxCallBack = Function(String checkboxId, String checkboxValue);

class TankMultiSelectExpansionTile extends StatelessWidget {
  final List<TankQuestionList> answerModelList;
  final int index;
  final List selectedIdList;
  final List selectedNamesList;
  final String editValue;

  const TankMultiSelectExpansionTile(
      {super.key,
      required this.answerModelList,
      required this.index,
      required this.selectedIdList,
      required this.selectedNamesList,
      required this.editValue});

  @override
  Widget build(BuildContext context) {
    String multiSelectNames =
        selectedNamesList.toString().replaceAll("[", "").replaceAll("]", "");
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: AppColor.transparent),
        child: ExpansionTile(
            collapsedShape: ExpansionTileBorder().buildOutlineInputBorder(),
            collapsedBackgroundColor: AppColor.white,
            backgroundColor: AppColor.white,
            shape: ExpansionTileBorder().buildOutlineInputBorder(),
            maintainState: true,
            title: Text(
                (multiSelectNames == "")
                    ? DatabaseUtil.getText('select_item')
                    : multiSelectNames,
                style: Theme.of(context).textTheme.xSmall),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: answerModelList[index].queoptions!.length,
                    itemBuilder: (BuildContext context, int listIndex) {
                      return CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          value: selectedIdList.contains(answerModelList[index]
                              .queoptions![listIndex]["queoptionid"]
                              .toString()),
                          title: Text(answerModelList[index]
                              .queoptions![listIndex]["queoptiontext"]),
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: (isChecked) {
                            context.read<TankManagementBloc>().add(
                                SelectTankChecklistAnswer(
                                    multiSelectIdList: selectedIdList,
                                    multiSelectItem: answerModelList[index]
                                        .queoptions![listIndex]["queoptionid"]
                                        .toString(),
                                    multiSelectName: answerModelList[index]
                                            .queoptions![listIndex]
                                        ["queoptiontext"],
                                    multiSelectNameList: selectedNamesList));
                          });
                    }),
              )
            ]));
  }
}
