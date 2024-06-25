import 'package:toolkit/data/models/%20meetingRoom/book_meeting_room_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_meeting_all_rooms_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_meeting_building_floor_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_meeting_details_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_meeting_master_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_monthly_schedule_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_my_meetings_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_room_availability_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_search_for_rooms_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/update_booking_details_model.dart';
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

  @override
  Future<FetchSearchForRoomsModel> fetchSearchForRooms(String hashCode,
      String date, String startTime, String endTime, String filter) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}meeting/SearchForRooms?hashcode=$hashCode&date=$date&startime=$startTime&endtime=$endTime&filter=$filter");
    return FetchSearchForRoomsModel.fromJson(response);
  }

  @override
  Future<BookMeetingRoomModel> bookMeetingRoom(Map bookMeetingMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}meeting/BookMeetingRoom", bookMeetingMap);
    return BookMeetingRoomModel.fromJson(response);
  }

  @override
  Future<FetchMonthlyScheduleModel> fetchMonthlySchedule(
      String hashCode, String userId, String date) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}meeting/GetMonthlySchedule?hashcode=$hashCode&userid=$userId&date=$date");
    return FetchMonthlyScheduleModel.fromJson(response);
  }

  @override
  Future<FetchMeetingAllRoomsModel> fetchMeetingAllRooms(
      String hashCode, String date) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}meeting/GetAllRooms?hashcode=$hashCode&date=$date");
    return FetchMeetingAllRoomsModel.fromJson(response);
  }

  @override
  Future<FetchRoomAvailabilityModel> fetchRoomAvailability(
      String hashCode, String date, String roomId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}meeting/GetRoomAvailability?hashcode=$hashCode&date=$date&roomid=$roomId");
    return FetchRoomAvailabilityModel.fromJson(response);
  }

  @override
  Future<UpdateBookingDetailsModel> updateBookingDetails(
      Map editDetailsMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}meeting/UpdateBooking", editDetailsMap);
    return UpdateBookingDetailsModel.fromJson(response);
  }
}
