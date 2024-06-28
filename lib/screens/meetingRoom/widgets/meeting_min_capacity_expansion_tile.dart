import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/expansion_tile_border.dart';

class MeetingMinCapacityExpansionTile extends StatefulWidget {
  const MeetingMinCapacityExpansionTile({
    super.key,
    required this.searchRoomMap,
  });

  final Map searchRoomMap;

  @override
  State<MeetingMinCapacityExpansionTile> createState() =>
      MeetingMinCapacityExpansionTileState();
}

class MeetingMinCapacityExpansionTileState
    extends State<MeetingMinCapacityExpansionTile> {
  String selectedValue = '';
  List<String> minCapacity =
      List<String>.generate(50, (index) => (index + 1).toString());

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
                        itemCount: minCapacity.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              contentPadding:
                                  const EdgeInsets.only(left: xxTinierSpacing),
                              title: Text(minCapacity[index]),
                              onTap: () {
                                setState(() {
                                  selectedValue = minCapacity[index];
                                  widget.searchRoomMap["capacity"] =
                                      minCapacity[index];
                                });
                              });
                        })),
              )
            ]));
  }
}
