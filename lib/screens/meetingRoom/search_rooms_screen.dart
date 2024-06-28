import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/screens/meetingRoom/view_available_rooms_screen.dart';
import 'package:toolkit/screens/meetingRoom/widgets/search_rooms_body.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../blocs/meetingRoom/meeting_room_bloc.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/generic_app_bar.dart';

class SearchRoomsScreen extends StatelessWidget {
  static const routeName = 'SearchRoomsScreen';
  static Map searchRoomMap = {};
  static bool isFromViewAvailable = false;
  const SearchRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _initialDateTime();
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
                    return SearchRoomsBody(
                      searchRoomMap: searchRoomMap,
                      buildingList: state.fetchMeetingMasterModel.data[1],
                      facilityList: state.fetchMeetingMasterModel.data[3],
                    );
                  } else if (state is MeetingMasterNotFetched) {
                    return const Center(
                      child: Text(StringConstants.kNoRecordsFound),
                    );
                  }
                  return const SizedBox.shrink();
                })),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(xxTinierSpacing),
            child: BlocListener<MeetingRoomBloc, MeetingRoomState>(
              listener: (context, state) {
                if (state is SearchForRoomsFetching) {
                  ProgressBar.show(context);
                } else if (state is SearchForRoomsFetched) {
                  ProgressBar.dismiss(context);
                  Navigator.pushNamed(
                      context, ViewAvailableRoomsScreen.routeName,
                      arguments: state.fetchSearchForRoomsModel.data);
                }
                if (state is SearchForRoomsNotFetched) {
                  ProgressBar.dismiss(context);
                  showCustomSnackBar(context, state.errorMessage, '');
                }
              },
              child: PrimaryButton(
                  onPressed: () {
                    context.read<MeetingRoomBloc>().add(
                        FetchSearchForRooms(searchForRoomsMap: searchRoomMap));
                  },
                  textValue: DatabaseUtil.getText('searchforRoom')),
            )));
  }

  void _initialDateTime() {
    const nineAm = TimeOfDay(hour: 9, minute: 0);
    const tenAm = TimeOfDay(hour: 10, minute: 0);
    final now = DateTime.now();
    searchRoomMap['date'] = DateFormat('dd.MM.yyyy').format(now);
    final startTime =
        DateTime(now.year, now.month, now.day, nineAm.hour, nineAm.minute);
    searchRoomMap['st'] = DateFormat.Hm().format(startTime);
    final endTime =
        DateTime(now.year, now.month, now.day, tenAm.hour, tenAm.minute);
    searchRoomMap['et'] = DateFormat.Hm().format(endTime);
  }
}
