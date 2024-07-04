import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/expansion_tile_border.dart';

class ControlEngineerExpansionTile extends StatefulWidget {
  const ControlEngineerExpansionTile({
    super.key,
    required this.controlEngineerList,
    required this.editSwitchingScheduleMap,
    this.editValue,
  });

  final List controlEngineerList;
  final Map editSwitchingScheduleMap;
  final String? editValue;

  @override
  State<ControlEngineerExpansionTile> createState() =>
      ControlEngineerExpansionTileState();
}

class ControlEngineerExpansionTileState
    extends State<ControlEngineerExpansionTile> {
  String selectedValue = '';

  @override
  void initState() {
    selectedValue = widget.editValue ?? '';
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
                        itemCount: widget.controlEngineerList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              contentPadding:
                                  const EdgeInsets.only(left: xxTinierSpacing),
                              title: Text(widget
                                  .controlEngineerList[index].userFullName),
                              onTap: () {
                                setState(() {
                                  selectedValue = widget
                                      .controlEngineerList[index].userFullName;
                                  widget.editSwitchingScheduleMap[
                                          'controlengineer'] =
                                      widget.controlEngineerList[index].userId;
                                });
                              });
                        })),
              )
            ]));
  }
}
