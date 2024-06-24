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
  final int buildingId;

  FetchMeetingBuildingFloor({required this.buildingId});
}

class FetchSearchForRooms extends MeetingRoomEvent {
  final Map searchForRoomsMap;

  FetchSearchForRooms({required this.searchForRoomsMap});
}

class SelectRepeatValue extends MeetingRoomEvent {
  final String repeat;

  SelectRepeatValue({required this.repeat});
}

class BookMeetingRoom extends MeetingRoomEvent {
  final Map bookMeetingMap;

  BookMeetingRoom({required this.bookMeetingMap});
}

class FetchMonthlySchedule extends MeetingRoomEvent {
  final String date;

  FetchMonthlySchedule({required this.date});
}
