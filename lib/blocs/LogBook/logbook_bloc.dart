import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/LogBook/fetch_log_book_details_model.dart';
import '../../data/models/LogBook/fetch_logbook_list_model.dart';
import '../../di/app_module.dart';
import '../../repositories/LogBook/logbook_repository.dart';
import 'logbook_events.dart';
import 'logbook_states.dart';

class LogbookBloc extends Bloc<LogbookEvents, LogbookStates> {
  final LogbookRepository _logbookRepository = getIt<LogbookRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  LogbookBloc() : super(LogbookInitial()) {
    on<FetchLogbookList>(_fetchLogbookList);
    on<FetchLogBookDetails>(_fetchLogbookDetails);
  }

  FutureOr<void> _fetchLogbookList(
      FetchLogbookList event, Emitter<LogbookStates> emit) async {
    emit(FetchingLogbookList());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      String? privateKey = await _customerCache.getApiKey(CacheKeys.apiKey);
      String? filter = "";
      FetchLogBookListModel fetchLogBookListModel = await _logbookRepository
          .fetchLogbookList(userId!, hashCode!, filter, event.pageNo);
      emit(LogbookListFetched(
          fetchLogBookListModel: fetchLogBookListModel,
          privateApiKey: privateKey!));
    } catch (e) {
      emit(LogbookFetchError());
    }
  }

  FutureOr<void> _fetchLogbookDetails(
      FetchLogBookDetails event, Emitter<LogbookStates> emit) async {
    emit(FetchingLogBookDetails());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchLogBookDetailsModel fetchLogBookDetailsModel =
          await _logbookRepository.fetchLogBookDetails(event.logId, hashCode!);
      emit(LogBookDetailsFetched(
          fetchLogBookDetailsModel: fetchLogBookDetailsModel));
    } catch (e) {
      emit(LogBookDetailsNotFetched(detailsNotFetched: e.toString()));
    }
  }
}
