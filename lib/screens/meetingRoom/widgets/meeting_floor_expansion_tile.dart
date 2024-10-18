import 'package:flutter/material.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_meeting_building_floor_model.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/expansion_tile_border.dart';

class MeetingFloorExpansionTile extends StatefulWidget {
  const MeetingFloorExpansionTile({
    super.key,
    required this.floorList,
    required this.searchRoomMap,
  });

  final List<BuildingFloorDatum> floorList;
  final Map searchRoomMap;

  @override
  State<MeetingFloorExpansionTile> createState() =>
      MeetingFloorExpansionTileState();
}

class MeetingFloorExpansionTileState extends State<MeetingFloorExpansionTile> {
  String selectedValue = '';
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
                height: kMeetingExpansionTilesHeight,
                child: MediaQuery(
                    data: MediaQuery.of(context).removePadding(removeTop: true),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.floorList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              contentPadding:
                                  const EdgeInsets.only(left: xxTinierSpacing),
                              title: Text(widget.floorList[index].floor),
                              onTap: () {
                                setState(() {
                                  selectedValue = widget.floorList[index].floor;
                                  widget.searchRoomMap["floorid"] =
                                      widget.floorList[index].id;
                                });
                              });
                        })),
              )
            ]));
  }
}
