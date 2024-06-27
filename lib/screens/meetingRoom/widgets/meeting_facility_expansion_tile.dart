import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/expansion_tile_border.dart';

class MeetingFacilityExpansionTile extends StatefulWidget {
  const MeetingFacilityExpansionTile({
    super.key,
    required this.facilityList,
    required this.searchRoomMap,
  });

  final List facilityList;
  final Map searchRoomMap;

  @override
  State<MeetingFacilityExpansionTile> createState() =>
      MeetingFacilityExpansionTileState();
}

class MeetingFacilityExpansionTileState
    extends State<MeetingFacilityExpansionTile> {
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
                        itemCount: widget.facilityList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              contentPadding:
                                  const EdgeInsets.only(left: xxTinierSpacing),
                              title: Text(widget.facilityList[index].facility),
                              onTap: () {
                                setState(() {
                                  selectedValue =
                                      widget.facilityList[index].facility;
                                  widget.searchRoomMap["facility"] =
                                      widget.facilityList[index].id;
                                });
                              });
                        })),
              )
            ]));
  }
}
