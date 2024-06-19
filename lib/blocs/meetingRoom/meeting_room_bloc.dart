import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_meeting_building_floor_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_meeting_details_screen.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_meeting_master_model.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_my_meetings_model.dart';
import 'package:toolkit/repositories/meetingRoom/meeting_room_repository.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
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
  }

  Future<FutureOr<void>> _fetchMyMeetingRoom(FetchMyMeetingRoom event,
      Emitter<MeetingRoomState> emit) async {
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

  Future<FutureOr<void>> _fetchMeetingDetails(FetchMeetingDetails event,
      Emitter<MeetingRoomState> emit) async {
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

  Future<FutureOr<void>> _fetchMeetingMaster(FetchMeetingMaster event,
      Emitter<MeetingRoomState> emit) async {
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
      FetchMeetingBuildingFloorModel fetchMeetingBuildingFloorModel = await _meetingRoomRepository
          .fetchMeetingBuildingFloor(hashCode, event.buildingId);
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
}
