import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../../configs/app_color.dart';
import '../../../../data/models/checklist/workforce/workforce_questions_list_model.dart';
import '../../../../widgets/expansion_tile_border.dart';

typedef DropDownCallBack = Function(String dropDownId, String dropDownString);

class DropDownExpansionTile extends StatefulWidget {
  final String value;
  final DropDownCallBack onValueChanged;
  final List<Questionlist> answerModelList;
  final int index;

  const DropDownExpansionTile(
      {super.key,
      required this.onValueChanged,
      required this.answerModelList,
      required this.value,
      required this.index});

  @override
  State<DropDownExpansionTile> createState() => _DropDownExpansionTileState();
}

class _DropDownExpansionTileState extends State<DropDownExpansionTile> {
  String dropDown = '';
  String dropDownId = '';

  @override
  void initState() {
    dropDown = widget.value;
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
            key: GlobalKey(),
            title: Text((dropDown == "")
                ? DatabaseUtil.getText('select_item')
                : dropDown),
            children: [
              MediaQuery(
                  data: MediaQuery.of(context).removePadding(removeTop: true),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget
                          .answerModelList[widget.index].queoptions!.length,
                      itemBuilder: (context, listIndex) {
                        return ListTile(
                            contentPadding:
                                const EdgeInsets.only(left: tiniestSpacing),
                            title: Text(widget.answerModelList[widget.index]
                                .queoptions![listIndex]["queoptiontext"]),
                            onTap: () {
                              setState(() {
                                dropDown = widget.answerModelList[widget.index]
                                    .queoptions![listIndex]["queoptiontext"]
                                    .toString();
                                dropDownId = widget
                                    .answerModelList[widget.index]
                                    .queoptions![listIndex]["queoptionid"]
                                    .toString();
                                widget.onValueChanged(
                                    dropDownId.toString(), dropDown);
                              });
                            });
                      }))
            ]));
  }
}
