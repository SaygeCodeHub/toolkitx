import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
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
}
