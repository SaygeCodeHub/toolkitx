import 'package:toolkit/data/models/%20meetingRoom/book_meeting_room_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/delete_booking_details_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_meeting_all_rooms_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_meeting_building_floor_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_meeting_details_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_meeting_master_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_monthly_schedule_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_my_meetings_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_room_availability_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_search_for_rooms_model.dart';

import '../../data/models/ meetingRoom/update_booking_details_model.dart';

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

  Future<BookMeetingRoomModel> bookMeetingRoom(Map bookMeetingMap);

  Future<FetchMonthlyScheduleModel> fetchMonthlySchedule(
      String hashCode, String userId, String date);

  Future<FetchMeetingAllRoomsModel> fetchMeetingAllRooms(
      String hashCode, String date);

  Future<FetchRoomAvailabilityModel> fetchRoomAvailability(
      String hashCode, String date, String roomId);

  Future<UpdateBookingDetailsModel> updateBookingDetails(Map editDetailsMap);

  Future<DeleteBookingDetailsModel> deleteBookingDetails(Map deleteDetailsMap);
}