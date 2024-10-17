import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/expansion_tile_border.dart';

class InstructionReceivedExpansionTile extends StatefulWidget {
  const InstructionReceivedExpansionTile({
    super.key,
    required this.instructionList,
    required this.editSwitchingScheduleMap,
    this.editName,
    this.editValue,
  });

  final List instructionList;
  final Map editSwitchingScheduleMap;
  final String? editName;
  final String? editValue;

  @override
  State<InstructionReceivedExpansionTile> createState() =>
      InstructionReceivedExpansionTileState();
}

class InstructionReceivedExpansionTileState
    extends State<InstructionReceivedExpansionTile> {
  String selectedValue = '';

  @override
  void initState() {
    selectedValue = widget.editName ?? '';
    widget.editSwitchingScheduleMap['instructionreceivedby'] = widget.editValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: AppColor.transparent),
        child: ExpansionTile(
            shape: ExpansionTileBorder().buildOutlineInputBorder(),
            collapsedBackgroundColor: AppColor.white,
            backgroundColor: AppColor.white,
            collapsedShape: ExpansionTileBorder().buildOutlineInputBorder(),
            key: GlobalKey(),
            title: Text(selectedValue),
            children: [
              SizedBox(
                height: kPermitEditSwitchingExpansionTileHeight,
                child: MediaQuery(
                    data: MediaQuery.of(context).removePadding(removeTop: true),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.instructionList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              contentPadding:
                                  const EdgeInsets.only(left: xxTinierSpacing),
                              title: Text(
                                  widget.instructionList[index].userFullName),
                              onTap: () {
                                setState(() {
                                  selectedValue = widget
                                      .instructionList[index].userFullName;
                                  widget.editSwitchingScheduleMap[
                                          'instructionreceivedby'] =
                                      widget.instructionList[index].userId;
                                });
                              });
                        })),
              )
            ]));
  }
}
