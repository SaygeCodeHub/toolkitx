part of 'meeting_room_bloc.dart';

abstract class MeetingRoomState {}

class MeetingRoomInitial extends MeetingRoomState {}

class MyMeetingRoomFetching extends MeetingRoomState {}

class MyMeetingRoomFetched extends MeetingRoomState {
  final FetchMyMeetingsModel fetchMyMeetingsModel;

  MyMeetingRoomFetched({required this.fetchMyMeetingsModel});
}

class MyMeetingRoomNotFetched extends MeetingRoomState {
  final String errorMessage;

  MyMeetingRoomNotFetched({required this.errorMessage});
}

class MeetingDetailsFetching extends MeetingRoomState {}

class MeetingDetailsFetched extends MeetingRoomState {
  final FetchMeetingDetailsModel fetchMeetingDetailsModel;
  final bool showPopUpMenu;
  final List meetingPopUpMenuList;

  MeetingDetailsFetched(
      {required this.fetchMeetingDetailsModel,
      required this.meetingPopUpMenuList,
      required this.showPopUpMenu});
}

class MeetingDetailsNotFetched extends MeetingRoomState {
  final String errorMessage;

  MeetingDetailsNotFetched({required this.errorMessage});
}

class MeetingMasterFetching extends MeetingRoomState {}

class MeetingMasterFetched extends MeetingRoomState {
  final FetchMeetingMasterModel fetchMeetingMasterModel;

  MeetingMasterFetched({required this.fetchMeetingMasterModel});
}

class MeetingMasterNotFetched extends MeetingRoomState {
  final String errorMessage;

  MeetingMasterNotFetched({required this.errorMessage});
}

class MeetingBuildingFloorFetching extends MeetingRoomState {}

class MeetingBuildingFloorFetched extends MeetingRoomState {
  final FetchMeetingBuildingFloorModel fetchMeetingBuildingFloorModel;

  MeetingBuildingFloorFetched({required this.fetchMeetingBuildingFloorModel});
}

class MeetingBuildingFloorNotFetched extends MeetingRoomState {
  final String errorMessage;

  MeetingBuildingFloorNotFetched({required this.errorMessage});
}

class SearchForRoomsFetching extends MeetingRoomState {}

class SearchForRoomsFetched extends MeetingRoomState {
  final FetchSearchForRoomsModel fetchSearchForRoomsModel;

  SearchForRoomsFetched({required this.fetchSearchForRoomsModel});
}

class SearchForRoomsNotFetched extends MeetingRoomState {
  final String errorMessage;

  SearchForRoomsNotFetched({required this.errorMessage});
}

class RepeatValueSelected extends MeetingRoomState {
  final String repeat;

  RepeatValueSelected({required this.repeat});
}

class MeetingRoomBooking extends MeetingRoomState {}

class MeetingRoomBooked extends MeetingRoomState {}

class MeetingRoomNotBooked extends MeetingRoomState {
  final String errorMessage;

  MeetingRoomNotBooked({required this.errorMessage});
}

class MonthlyScheduleFetching extends MeetingRoomState {}

class MonthlyScheduleFetched extends MeetingRoomState {
  final FetchMonthlyScheduleModel fetchMonthlyScheduleModel;

  MonthlyScheduleFetched({required this.fetchMonthlyScheduleModel});
}

class MonthlyScheduleNotFetched extends MeetingRoomState {
  final String errorMessage;

  MonthlyScheduleNotFetched({required this.errorMessage});
}

class MeetingAllRoomsFetching extends MeetingRoomState {}

class MeetingAllRoomsFetched extends MeetingRoomState {
  final FetchMeetingAllRoomsModel fetchMeetingAllRoomsModel;

  MeetingAllRoomsFetched({required this.fetchMeetingAllRoomsModel});
}

class MeetingAllRoomsNotFetched extends MeetingRoomState {
  final String errorMessage;

  MeetingAllRoomsNotFetched({required this.errorMessage});
}

class RoomAvailabilityFetching extends MeetingRoomState {}

class RoomAvailabilityFetched extends MeetingRoomState {
  final FetchRoomAvailabilityModel fetchRoomAvailabilityModel;

  RoomAvailabilityFetched({required this.fetchRoomAvailabilityModel});
}

class RoomAvailabilityNotFetched extends MeetingRoomState {
  final String errorMessage;

  RoomAvailabilityNotFetched({required this.errorMessage});
}

class BookingDetailsUpdating extends MeetingRoomState {}

class BookingDetailsUpdated extends MeetingRoomState {}

class BookingDetailsNotUpdated extends MeetingRoomState {
  final String errorMessage;

  BookingDetailsNotUpdated({required this.errorMessage});
}
