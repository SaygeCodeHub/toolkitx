part of 'meeting_room_bloc.dart';

abstract class MeetingRoomEvent {}

class FetchMyMeetingRoom extends MeetingRoomEvent {
  final String date;

  FetchMyMeetingRoom({required this.date});
}
