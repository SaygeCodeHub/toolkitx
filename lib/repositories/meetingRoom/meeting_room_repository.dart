import 'package:toolkit/data/models/%20meetingRoom/fetch_my_meetings_model.dart';

abstract class MeetingRoomRepository {
  Future<FetchMyMeetingsModel> fetchMyMeetings(
      String hashCode, String userId, String date);
}
