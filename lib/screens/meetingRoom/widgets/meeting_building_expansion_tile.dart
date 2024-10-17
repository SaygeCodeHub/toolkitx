import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/meetingRoom/meeting_room_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/expansion_tile_border.dart';

class MeetingBuildingExpansionTile extends StatefulWidget {
  const MeetingBuildingExpansionTile({
    super.key,
    required this.buildingList,
    required this.searchRoomMap,
  });

  final List buildingList;
  final Map searchRoomMap;

  @override
  State<MeetingBuildingExpansionTile> createState() =>
      MeetingBuildingExpansionTileState();
}

class MeetingBuildingExpansionTileState
    extends State<MeetingBuildingExpansionTile> {
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
              MediaQuery(
                  data: MediaQuery.of(context).removePadding(removeTop: true),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.buildingList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            contentPadding:
                                const EdgeInsets.only(left: xxTinierSpacing),
                            title: Text(widget.buildingList[index].name),
                            onTap: () {
                              setState(() {
                                selectedValue = widget.buildingList[index].name;
                                widget.searchRoomMap["buildingid"] =
                                    widget.buildingList[index].id;
                                context.read<MeetingRoomBloc>().add(
                                    FetchMeetingBuildingFloor(
                                        buildingId: widget
                                            .searchRoomMap["buildingid"]));
                              });
                            });
                      }))
            ]));
  }
}
