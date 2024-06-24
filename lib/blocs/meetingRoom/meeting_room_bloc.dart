import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/%20meetingRoom/book_meeting_room_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_meeting_building_floor_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_meeting_details_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_meeting_master_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_monthly_schedule_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_my_meetings_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_search_for_rooms_model.dart';
import 'package:toolkit/repositories/meetingRoom/meeting_room_repository.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/ meetingRoom/fetch_meeting_all_rooms_model.dart';
import '../../data/models/ meetingRoom/fetch_room_availability_model.dart';
import '../../di/app_module.dart';

part 'meeting_room_event.dart';

part 'meeting_room_state.dart';

class MeetingRoomBloc extends Bloc<MeetingRoomEvent, MeetingRoomState> {
  final MeetingRoomRepository _meetingRoomRepository =
      getIt<MeetingRoomRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  MeetingRoomState get initialState => MeetingRoomInitial();

  MeetingRoomBloc() : super(MeetingRoomInitial()) {
    on<FetchMyMeetingRoom>(_fetchMyMeetingRoom);
    on<FetchMeetingDetails>(_fetchMeetingDetails);
    on<FetchMeetingMaster>(_fetchMeetingMaster);
    on<FetchMeetingBuildingFloor>(_fetchMeetingBuildingFloor);
    on<FetchSearchForRooms>(_fetchSearchForRooms);
    on<SelectRepeatValue>(_selectRepeatValue);
    on<BookMeetingRoom>(_bookMeetingRoom);
    on<FetchMonthlySchedule>(_fetchMonthlySchedule);
    on<FetchMeetingAllRooms>(_fetchMeetingAllRooms);
    on<FetchRoomAvailability>(_fetchRoomAvailability);
  }

  Future<FutureOr<void>> _fetchMyMeetingRoom(
      FetchMyMeetingRoom event, Emitter<MeetingRoomState> emit) async {
    emit(MyMeetingRoomFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      FetchMyMeetingsModel fetchMyMeetingsModel = await _meetingRoomRepository
          .fetchMyMeetings(hashCode, userId, event.date);

      if (fetchMyMeetingsModel.status == 200) {
        emit(MyMeetingRoomFetched(fetchMyMeetingsModel: fetchMyMeetingsModel));
      } else {
        emit(MyMeetingRoomNotFetched(
            errorMessage: fetchMyMeetingsModel.message));
      }
    } catch (e) {
      emit(MyMeetingRoomNotFetched(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchMeetingDetails(
      FetchMeetingDetails event, Emitter<MeetingRoomState> emit) async {
    emit(MeetingDetailsFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      FetchMeetingDetailsModel fetchMeetingDetailsModel =
          await _meetingRoomRepository.fetchMeetingDetails(
              hashCode, userId, event.bookingId);
      if (fetchMeetingDetailsModel.status == 200) {
        emit(MeetingDetailsFetched(
            fetchMeetingDetailsModel: fetchMeetingDetailsModel));
      } else {
        emit(MeetingDetailsNotFetched(
            errorMessage: fetchMeetingDetailsModel.message));
      }
    } catch (e) {
      emit(MeetingDetailsNotFetched(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchMeetingMaster(
      FetchMeetingMaster event, Emitter<MeetingRoomState> emit) async {
    emit(MeetingMasterFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      FetchMeetingMasterModel fetchMeetingMasterModel =
          await _meetingRoomRepository.fetchMeetingMaster(hashCode);
      if (fetchMeetingMasterModel.status == 200) {
        emit(MeetingMasterFetched(
            fetchMeetingMasterModel: fetchMeetingMasterModel));
      } else {
        emit(MeetingMasterNotFetched(
            errorMessage: fetchMeetingMasterModel.message));
      }
    } catch (e) {
      emit(MeetingMasterNotFetched(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchMeetingBuildingFloor(
      FetchMeetingBuildingFloor event, Emitter<MeetingRoomState> emit) async {
    emit(MeetingBuildingFloorFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      FetchMeetingBuildingFloorModel fetchMeetingBuildingFloorModel =
          await _meetingRoomRepository.fetchMeetingBuildingFloor(
              hashCode, event.buildingId);
      if (fetchMeetingBuildingFloorModel.status == 200) {
        emit(MeetingBuildingFloorFetched(
            fetchMeetingBuildingFloorModel: fetchMeetingBuildingFloorModel));
      } else {
        emit(MeetingBuildingFloorNotFetched(
            errorMessage: fetchMeetingBuildingFloorModel.message));
      }
    } catch (e) {
      emit(MeetingBuildingFloorNotFetched(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchSearchForRooms(
      FetchSearchForRooms event, Emitter<MeetingRoomState> emit) async {
    emit(SearchForRoomsFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      Map filterMap = {
        "buildingid": event.searchForRoomsMap['buildingid'] ?? '',
        "floorid": event.searchForRoomsMap['floorid'] ?? '',
        "capacity": event.searchForRoomsMap['capacity'] ?? '',
        "facility": event.searchForRoomsMap['facility'] ?? ''
      };
      FetchSearchForRoomsModel fetchSearchForRoomsModel =
          await _meetingRoomRepository.fetchSearchForRooms(
              hashCode,
              event.searchForRoomsMap['date'] ?? '',
              event.searchForRoomsMap['st'] ?? '',
              event.searchForRoomsMap['et'] ?? '',
              jsonEncode(filterMap));
      if (fetchSearchForRoomsModel.status == 200) {
        emit(SearchForRoomsFetched(
            fetchSearchForRoomsModel: fetchSearchForRoomsModel));
      } else {
        emit(SearchForRoomsNotFetched(
            errorMessage: fetchSearchForRoomsModel.message));
      }
    } catch (e) {
      emit(SearchForRoomsNotFetched(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _selectRepeatValue(
      SelectRepeatValue event, Emitter<MeetingRoomState> emit) {
    emit(RepeatValueSelected(repeat: event.repeat));
  }

  Future<FutureOr<void>> _bookMeetingRoom(
      BookMeetingRoom event, Emitter<MeetingRoomState> emit) async {
    emit(MeetingRoomBooking());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      Map bookMeetingMap = {
        "idm": "",
        "roomid": event.bookMeetingMap['roomid'],
        "startdate": event.bookMeetingMap['startdate'],
        "enddate": event.bookMeetingMap['enddate'],
        "repeat": event.bookMeetingMap['repeat'],
        "endson": event.bookMeetingMap['endson'],
        "shortagenda": event.bookMeetingMap['shortagenda'],
        "longagenda": event.bookMeetingMap['longagenda'],
        "userid": userId,
        "participant": event.bookMeetingMap['participant'],
        "externalusers": event.bookMeetingMap['externalusers'] ?? '',
        "hashcode": hashCode
      };
      BookMeetingRoomModel bookMeetingRoomModel =
          await _meetingRoomRepository.bookMeetingRoom(bookMeetingMap);
      if (bookMeetingRoomModel.status == 200) {
        emit(MeetingRoomBooked());
      } else {
        emit(MeetingRoomNotBooked(errorMessage: bookMeetingRoomModel.message));
      }
    } catch (e) {
      emit(MeetingRoomNotBooked(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchMonthlySchedule(
      FetchMonthlySchedule event, Emitter<MeetingRoomState> emit) async {
    emit(MonthlyScheduleFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      FetchMonthlyScheduleModel fetchMonthlyScheduleModel =
          await _meetingRoomRepository.fetchMonthlySchedule(
              hashCode, userId, event.date);
      if (fetchMonthlyScheduleModel.status == 200) {
        emit(MonthlyScheduleFetched(
            fetchMonthlyScheduleModel: fetchMonthlyScheduleModel));
      } else {
        emit(MonthlyScheduleNotFetched(
            errorMessage: fetchMonthlyScheduleModel.message));
      }
    } catch (e) {
      emit(MonthlyScheduleNotFetched(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchMeetingAllRooms(
      FetchMeetingAllRooms event, Emitter<MeetingRoomState> emit) async {
    emit(MeetingAllRoomsFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      FetchMeetingAllRoomsModel fetchMeetingAllRoomsModel =
          await _meetingRoomRepository.fetchMeetingAllRooms(
              hashCode, event.date);

      if (fetchMeetingAllRoomsModel.status == 200) {
        emit(MeetingAllRoomsFetched(
            fetchMeetingAllRoomsModel: fetchMeetingAllRoomsModel));
      } else {
        emit(MeetingAllRoomsNotFetched(
            errorMessage: fetchMeetingAllRoomsModel.message));
      }
    } catch (e) {
      emit(MeetingAllRoomsNotFetched(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchRoomAvailability(
      FetchRoomAvailability event, Emitter<MeetingRoomState> emit) async {
    emit(RoomAvailabilityFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      FetchRoomAvailabilityModel fetchRoomAvailabilityModel =
          await _meetingRoomRepository.fetchRoomAvailability(
              hashCode, event.date, event.roomId);

      if (fetchRoomAvailabilityModel.status == 200) {
        emit(RoomAvailabilityFetched(
            fetchRoomAvailabilityModel: fetchRoomAvailabilityModel));
      } else {
        emit(RoomAvailabilityNotFetched(
            errorMessage: fetchRoomAvailabilityModel.message));
      }
    } catch (e) {
      emit(RoomAvailabilityNotFetched(errorMessage: e.toString()));
    }
  }
}
