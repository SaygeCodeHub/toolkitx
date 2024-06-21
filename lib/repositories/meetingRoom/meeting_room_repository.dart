import 'package:toolkit/data/models/%20meetingRoom/fetch_meeting_building_floor_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_meeting_details_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_meeting_master_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_my_meetings_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_search_for_rooms_model.dart';

abstract class MeetingRoomRepository {
  Future<FetchMyMeetingsModel> fetchMyMeetings(
      String hashCode, String userId, String date);

  Future<FetchMeetingDetailsModel> fetchMeetingDetails(
      String hashCode, String userId, String bookingId);

  Future<FetchMeetingMasterModel> fetchMeetingMaster(String hashCode);

  Future<FetchMeetingBuildingFloorModel> fetchMeetingBuildingFloor(
      String hashCode, int buildingId);

  Future<FetchSearchForRoomsModel> fetchSearchForRooms(String hashCode,
      String date, String startTime, String endTime, String filter);
}
