import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/widgets/date_picker.dart';
import 'package:toolkit/screens/incident/widgets/time_picker.dart';
import 'package:toolkit/screens/meetingRoom/widgets/meeting_building_expansion_tile.dart';
import 'package:toolkit/screens/meetingRoom/widgets/meeting_facility_expansion_tile.dart';
import 'package:toolkit/screens/meetingRoom/widgets/meeting_floor_widget.dart';
import 'package:toolkit/screens/meetingRoom/widgets/meeting_min_capacity_expansion_tile.dart';
import 'package:toolkit/utils/database_utils.dart';

class SearchRoomsBody extends StatelessWidget {
  const SearchRoomsBody({
    super.key,
    required this.searchRoomMap,
    required this.buildingList,
    required this.facilityList,
  });

  final Map searchRoomMap;
  final List buildingList;
  final List facilityList;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(DatabaseUtil.getText('Date'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        DatePickerTextField(
            editDate: DateFormat("dd MMM yyyy").format(DateTime.now()),
            onDateChanged: (date) {
              searchRoomMap['date'] = date;
            }),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('startTimePlaceHolder'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        TimePickerTextField(
            editTime: searchRoomMap['st'],
            onTimeChanged: (time) {
              searchRoomMap['st'] = time;
            }),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('endTimePlaceHolder'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        TimePickerTextField(
            editTime: searchRoomMap['et'],
            onTimeChanged: (time) {
              searchRoomMap['et'] = time;
            }),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('Building'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        MeetingBuildingExpansionTile(
          buildingList: buildingList,
          searchRoomMap: searchRoomMap,
        ),
        const SizedBox(height: xxxSmallestSpacing),
        MeetingFloorWidget(searchRoomMap: searchRoomMap),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('mincapacity'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        MeetingMinCapacityExpansionTile(searchRoomMap: searchRoomMap),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('facility'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        MeetingFacilityExpansionTile(
            facilityList: facilityList, searchRoomMap: searchRoomMap)
      ]),
    );
  }
}
