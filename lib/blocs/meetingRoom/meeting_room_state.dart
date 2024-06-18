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
