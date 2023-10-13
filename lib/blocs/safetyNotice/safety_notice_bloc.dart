import 'dart:async';
import 'dart:convert';

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
  Map safetNoticeFilterMap = {};

  SafetyNoticeStates get initialState => SafetyNoticeInitialState();

  SafetyNoticeBloc() : super(SafetyNoticeInitialState()) {
    on<FetchSafetyNotices>(_fetchSafetyNotices);
    on<SelectSafetyNoticeStatus>(_selectSafetyNoticeStatus);
    on<SafetyNoticeApplyFilter>(_safetyNoticeApplyFilter);
  }

  FutureOr<void> _fetchSafetyNotices(
      FetchSafetyNotices event, Emitter<SafetyNoticeStates> emit) async {
    emit(FetchingSafetyNotices());
    try {
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      if (event.isFromHomeScreen == true) {
        FetchSafetyNoticesModel fetchSafetyNoticesModel =
            await _safetyNoticeRepository.fetchSafetyNotices(
                event.pageNo, userId!, hashCode!, '{}');
        safetyNoticeListReachedMax =
            fetchSafetyNoticesModel.data.notices.isEmpty;
        noticesDatum.addAll(fetchSafetyNoticesModel.data.notices);
        emit(SafetyNoticesFetched(
            noticesDatum: noticesDatum,
            safetyNoticeFilterMap: safetNoticeFilterMap));
      } else {
        FetchSafetyNoticesModel fetchSafetyNoticesModel =
            await _safetyNoticeRepository.fetchSafetyNotices(event.pageNo,
                userId!, hashCode!, jsonEncode(safetNoticeFilterMap));
        safetyNoticeListReachedMax =
            fetchSafetyNoticesModel.data.notices.isEmpty;
        noticesDatum.addAll(fetchSafetyNoticesModel.data.notices);
        emit(SafetyNoticesFetched(
            noticesDatum: noticesDatum,
            safetyNoticeFilterMap: safetNoticeFilterMap));
      }
    } catch (e) {
      e.toString();
    }
  }

  _selectSafetyNoticeStatus(
      SelectSafetyNoticeStatus event, Emitter<SafetyNoticeStates> emit) {
    emit(SafetyNoticeStatusSelected(
        statusId: event.statusId, status: event.status));
  }

  _safetyNoticeApplyFilter(
      SafetyNoticeApplyFilter event, Emitter<SafetyNoticeStates> emit) {
    safetNoticeFilterMap = event.safetyNoticeFilterMap;
  }
}
