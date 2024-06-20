import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/widgets/date_picker.dart';
import 'package:toolkit/screens/incident/widgets/time_picker.dart';
import 'package:toolkit/screens/meetingRoom/view_available_rooms_screen.dart';
import 'package:toolkit/screens/meetingRoom/widgets/meeting_building_expansion_tile.dart';
import 'package:toolkit/screens/meetingRoom/widgets/meeting_facility_expansion_tile.dart';
import 'package:toolkit/screens/meetingRoom/widgets/meeting_floor_widget.dart';
import 'package:toolkit/screens/meetingRoom/widgets/meeting_min_capacity_expansion_tile.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../blocs/meetingRoom/meeting_room_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_no_records_text.dart';

class SearchRoomsScreen extends StatelessWidget {
  static const routeName = 'SearchRoomsScreen';

  const SearchRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map searchRoomMap = {};
    searchRoomMap['date'] = DateFormat('dd.MM.yyyy').format(DateTime.now());
    context.read<MeetingRoomBloc>().add(FetchMeetingMaster());
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kSearchRoom),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing,
            bottom: xxTinierSpacing),
        child: BlocBuilder<MeetingRoomBloc, MeetingRoomState>(
          buildWhen: (previousState, currentState) =>
              currentState is MeetingMasterFetching ||
              currentState is MeetingMasterFetched ||
              currentState is MeetingMasterNotFetched,
          builder: (context, state) {
            if (state is MeetingMasterFetching) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MeetingMasterFetched) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DatabaseUtil.getText('Date'),
                          style: Theme.of(context).textTheme.xSmall.copyWith(
                              color: AppColor.black,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: tiniestSpacing),
                      DatePickerTextField(
                          editDate:
                              DateFormat("dd MMM yyyy").format(DateTime.now()),
                          onDateChanged: (date) {
                            searchRoomMap['date'] = date;
                          }),
                      const SizedBox(height: xxxSmallestSpacing),
                      Text(DatabaseUtil.getText('startTimePlaceHolder'),
                          style: Theme.of(context).textTheme.xSmall.copyWith(
                              color: AppColor.black,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: tiniestSpacing),
                      TimePickerTextField(onTimeChanged: (time) {
                        searchRoomMap['starttime'] = time;
                      }),
                      const SizedBox(height: xxxSmallestSpacing),
                      Text(DatabaseUtil.getText('endTimePlaceHolder'),
                          style: Theme.of(context).textTheme.xSmall.copyWith(
                              color: AppColor.black,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: tiniestSpacing),
                      TimePickerTextField(onTimeChanged: (time) {
                        searchRoomMap['endtime'] = time;
                      }),
                      const SizedBox(height: xxxSmallestSpacing),
                      Text(DatabaseUtil.getText('Building'),
                          style: Theme.of(context).textTheme.xSmall.copyWith(
                              color: AppColor.black,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: tiniestSpacing),
                      MeetingBuildingExpansionTile(
                        buildingList: state.fetchMeetingMasterModel.data[1],
                        searchRoomMap: searchRoomMap,
                      ),
                      const SizedBox(height: xxxSmallestSpacing),
                      MeetingFloorWidget(searchRoomMap: searchRoomMap),
                      const SizedBox(height: xxxSmallestSpacing),
                      Text(DatabaseUtil.getText('mincapacity'),
                          style: Theme.of(context).textTheme.xSmall.copyWith(
                              color: AppColor.black,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: tiniestSpacing),
                      MeetingMinCapacityExpansionTile(
                          searchRoomMap: searchRoomMap),
                      const SizedBox(height: xxxSmallestSpacing),
                      Text(DatabaseUtil.getText('facility'),
                          style: Theme.of(context).textTheme.xSmall.copyWith(
                              color: AppColor.black,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: tiniestSpacing),
                      MeetingFacilityExpansionTile(
                          facilityList: state.fetchMeetingMasterModel.data[3],
                          searchRoomMap: searchRoomMap)
                    ]),
              );
            } else if (state is MeetingMasterNotFetched) {
              return const Center(
                child: NoRecordsText(text: StringConstants.kNoRecordsFound),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: PrimaryButton(
            onPressed: () {
              Navigator.pushNamed(context, ViewAvailableRoomsScreen.routeName,
                  arguments: searchRoomMap);
            },
            textValue: DatabaseUtil.getText('searchforRoom')),
      ),
    );
  }
}
