part of 'meeting_room_bloc.dart';

abstract class MeetingRoomEvent {}

class FetchMyMeetingRoom extends MeetingRoomEvent {
  final String date;

  FetchMyMeetingRoom({required this.date});
}

class FetchMeetingDetails extends MeetingRoomEvent {
  final String bookingId;

  FetchMeetingDetails({required this.bookingId});
}

class FetchMeetingMaster extends MeetingRoomEvent {}

class FetchMeetingBuildingFloor extends MeetingRoomEvent {
  final String buildingId;

  FetchMeetingBuildingFloor({required this.buildingId});
}
