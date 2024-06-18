import 'package:toolkit/data/models/%20meetingRoom/fetch_my_meetings_model.dart';
import 'package:toolkit/repositories/meetingRoom/meeting_room_repository.dart';

import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';

class MeetingRoomRepositoryImpl extends MeetingRoomRepository {
  @override
  Future<FetchMyMeetingsModel> fetchMyMeetings(
      String hashCode, String userId, String date) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}meeting/GetMyMeetings?hashcode=$hashCode&userid=$userId&date=$date");
    return FetchMyMeetingsModel.fromJson(response);
  }
}
