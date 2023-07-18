import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../di/app_module.dart';
import '../../data/models/leavesAndHolidays/fetch_leaves_details_model.dart';
import '../../data/models/leavesAndHolidays/fetch_leaves_summary_model.dart';
import '../../repositories/leavesAndHolidays/leaves_and_holidays_repository.dart';
import 'leaves_and_holidays_events.dart';
import 'leaves_and_holidays_states.dart';

class LeavesAndHolidaysBloc
    extends Bloc<LeavesAndHolidaysEvent, LeavesAndHolidaysStates> {
  final LeavesAndHolidaysRepository _leavesAndHolidaysRepository =
      getIt<LeavesAndHolidaysRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  LeavesAndHolidaysStates get initialState => LeavesAndSummaryInitial();

  LeavesAndHolidaysBloc() : super(LeavesAndSummaryInitial()) {
    on<FetchLeavesSummary>(_fetchLeavesSummary);
    on<FetchLeavesDetails>(_fetchLeavesDetails);
  }

  FutureOr _fetchLeavesSummary(
      FetchLeavesSummary event, Emitter<LeavesAndHolidaysStates> emit) async {
    emit(FetchingLeavesSummary());
    try {
      final String? userId = await _customerCache.getUserId(CacheKeys.userId);
      final String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchLeavesSummaryModel fetchLeavesSummaryModel =
          await _leavesAndHolidaysRepository.fetchLeavesSummary(
              userId!, hashCode!);
      emit(LeavesSummaryFetched(
          fetchLeavesSummaryModel: fetchLeavesSummaryModel));
    } catch (e) {
      emit(LeavesSummaryNotFetched(summaryNotFetched: e.toString()));
    }
  }

  FutureOr _fetchLeavesDetails(
      FetchLeavesDetails event, Emitter<LeavesAndHolidaysStates> emit) async {
    emit(FetchingLeavesDetails());
    try {
      final String? userId = await _customerCache.getUserId(CacheKeys.userId);
      final String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchLeavesDetailsModel fetchLeavesDetailsModel =
          await _leavesAndHolidaysRepository.fetchLeavesDetails(
              userId!, hashCode!, event.page);
      emit(LeavesDetailsFetched(
          fetchLeavesDetailsModel: fetchLeavesDetailsModel));
    } catch (e) {
      emit(LeavesDetailsNotFetched(detailsNotFetched: e.toString()));
    }
  }
}
