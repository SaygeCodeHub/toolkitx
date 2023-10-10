import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/safetyNotice/safety_notice_events.dart';
import 'package:toolkit/blocs/safetyNotice/safety_notice_states.dart';
import '../../../../di/app_module.dart';
import '../../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/safetyNotice/fetch_safety_notices_model.dart';
import '../../repositories/safetyNotice/safety_notice_repository.dart';

class SafetyNoticeBloc extends Bloc<SafetyNoticeEvent, SafetyNoticeStates> {
  final SafetyNoticeRepository _safetyNoticeRepository =
      getIt<SafetyNoticeRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  bool safetyNoticeListReachedMax = false;
  List<Notice> noticesDatum = [];

  SafetyNoticeStates get initialState => SafetyNoticeInitialState();

  SafetyNoticeBloc() : super(SafetyNoticeInitialState()) {
    on<FetchSafetyNotices>(_fetchSafetyNotices);
  }

  FutureOr<void> _fetchSafetyNotices(
      FetchSafetyNotices event, Emitter<SafetyNoticeStates> emit) async {
    emit(FetchingSafetyNotices());
    try {
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchSafetyNoticesModel fetchSafetyNoticesModel =
          await _safetyNoticeRepository.fetchSafetyNotices(
              event.pageNo, userId!, hashCode!, '{}');
      safetyNoticeListReachedMax = fetchSafetyNoticesModel.data.notices.isEmpty;
      noticesDatum.addAll(fetchSafetyNoticesModel.data.notices);
      emit(SafetyNoticesFetched(noticesDatum: noticesDatum));
    } catch (e) {
      e.toString();
    }
  }
}
