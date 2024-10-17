import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/expansion_tile_border.dart';

class MeetingParticipantExpansionTile extends StatefulWidget {
  const MeetingParticipantExpansionTile({
    super.key,
    required this.participantList,
    required this.bookRoomMap,
  });

  final List participantList;
  final Map bookRoomMap;

  @override
  State<MeetingParticipantExpansionTile> createState() =>
      MeetingParticipantExpansionTileState();
}

class MeetingParticipantExpansionTileState
    extends State<MeetingParticipantExpansionTile> {
  List selectedCreatedForIdList = [];
  List selectedCreatedForNameList = [];

  void _checkboxChange(isSelected, participantId, name) {
    if (isSelected) {
      selectedCreatedForIdList.add(participantId);
      selectedCreatedForNameList.add(name);
      widget.bookRoomMap['participant'] = selectedCreatedForIdList
          .toString()
          .replaceAll('[', '')
          .replaceAll(']', '')
          .replaceAll(' ', '')
          .replaceAll(',', ';');
    } else {
      selectedCreatedForIdList.remove(participantId);
      selectedCreatedForNameList.remove(name);
    }
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
            title: Text(selectedCreatedForNameList
                .toString()
                .replaceAll('[', '')
                .replaceAll(']', '')),
            children: [
              SizedBox(
                height: kParticipantExpansionTileHeight,
                child: MediaQuery(
                    data: MediaQuery.of(context).removePadding(removeTop: true),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.participantList.length,
                        itemBuilder: (context, index) {
                          return CheckboxListTile(
                              contentPadding:
                                  const EdgeInsets.only(left: xxTinierSpacing),
                              title: Text(widget.participantList[index].name),
                              value: selectedCreatedForIdList
                                  .contains(widget.participantList[index].id),
                              onChanged: (isChecked) {
                                setState(() {
                                  isChecked = isChecked!;
                                  _checkboxChange(
                                      isChecked,
                                      widget.participantList[index].id,
                                      widget.participantList[index].name);
                                });
                              });
                        })),
              )
            ]));
  }
}
