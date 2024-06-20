import 'package:toolkit/data/models/%20meetingRoom/fetch_meeting_building_floor_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_meeting_details_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_meeting_master_model.dart';
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

  @override
  Future<FetchMeetingDetailsModel> fetchMeetingDetails(
      String hashCode, String userId, String bookingId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}meeting/GetMeeting?hashcode=$hashCode&userid=$userId&bookingid=$bookingId");
    return FetchMeetingDetailsModel.fromJson(response);
  }

  @override
  Future<FetchMeetingMasterModel> fetchMeetingMaster(String hashCode) async {
    final response = await DioClient()
        .get("${ApiConstants.baseUrl}meeting/GetMaster?hashcode=$hashCode");
    return FetchMeetingMasterModel.fromJson(response);
  }

  @override
  Future<FetchMeetingBuildingFloorModel> fetchMeetingBuildingFloor(
      String hashCode, int buildingId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}meeting/GetBuilidingFloors?hashcode=$hashCode&buildingid=$buildingId");
    return FetchMeetingBuildingFloorModel.fromJson(response);
  }
}
