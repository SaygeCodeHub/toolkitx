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

  MeetingDetailsFetched({required this.fetchMeetingDetailsModel});
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
