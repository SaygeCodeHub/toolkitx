import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/LogBook/fetch_log_book_details_model.dart';
import '../../data/models/LogBook/fetch_logbook_list_model.dart';
import '../../data/models/LogBook/fetch_logbook_master_model.dart';
import '../../data/models/LogBook/report_new_logbook_model.dart';
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
    on<FetchLogBookMaster>(_fetchLogBookMaster);
    on<SelectLogBookType>(_selectLogBookType);
    on<SelectLogBookActivity>(_selectLogBookActivity);
    on<SelectLogBookLocation>(_selectLogBookLocation);
    on<SelectLogBookPriority>(_selectLogBookPriority);
    on<SelectLogBookHandoverLog>(_selectLogBookHandover);
    on<ReportNewLogBook>(_reportNewLogbook);
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

  FutureOr<void> _fetchLogBookMaster(
      FetchLogBookMaster event, Emitter<LogbookStates> emit) async {
    emit(LogBookFetchingMaster());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      LogBookFetchMasterModel logBookFetchMasterModel =
          await _logbookRepository.fetchLogBookMaster(hashCode!);
      emit(LogBookMasterFetched(
          logBookFetchMasterModel: logBookFetchMasterModel));
    } catch (e) {
      emit(LogBookMasterNotFetched(masterNotFetched: e.toString()));
    }
  }

  _selectLogBookType(SelectLogBookType event, Emitter<LogbookStates> emit) {
    List typeList = List.from(event.typeNameList);
    if (event.typeName != '') {
      if (event.typeNameList.contains(event.typeName) != true) {
        typeList.add(event.typeName);
      } else {
        typeList.remove(event.typeName);
      }
    }
    emit(LogBookTypeSelected(typeName: event.typeName, typeNameList: typeList));
  }

  _selectLogBookActivity(
      SelectLogBookActivity event, Emitter<LogbookStates> emit) {
    emit(LogBookActivitySelected(activityName: event.activityName));
  }

  _selectLogBookLocation(
      SelectLogBookLocation event, Emitter<LogbookStates> emit) {
    emit(LogBookLocationSelected(
        locationId: event.locationId, locationName: event.locationName));
  }

  _selectLogBookPriority(
      SelectLogBookPriority event, Emitter<LogbookStates> emit) {
    Map priorityMap = {
      '1': DatabaseUtil.getText('Low'),
      '2': DatabaseUtil.getText('Medium'),
      '3': DatabaseUtil.getText('High')
    };
    emit(LogBookPrioritySelected(
        priorityName: event.priorityName, priorityMap: priorityMap));
  }

  _selectLogBookHandover(
      SelectLogBookHandoverLog event, Emitter<LogbookStates> emit) {
    Map handoverMap = {
      '1': DatabaseUtil.getText('Yes'),
      '2': DatabaseUtil.getText('No')
    };
    emit(LogBookHandoverSelected(
        handoverMap: handoverMap, handoverValue: event.handoverValue));
  }

  FutureOr _reportNewLogbook(
      ReportNewLogBook event, Emitter<LogbookStates> emit) async {
    emit(NewLogBookReporting());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      if (event.reportLogbook['eventdate'] == null ||
          event.reportLogbook['eventdate'].isEmpty) {
        emit(NewLogBookNotReported(
            logbookNotReported: StringConstants.kEventDateValidation));
      } else if (event.reportLogbook['eventtime'] == null ||
          event.reportLogbook['eventtime'].isEmpty) {
        emit(NewLogBookNotReported(
            logbookNotReported: StringConstants.kEventTimeValidation));
      } else if (event.reportLogbook['description'] == null ||
          event.reportLogbook['description'].isEmpty) {
        emit(NewLogBookNotReported(
            logbookNotReported: StringConstants.kDescriptionValidation));
      } else if (event.reportLogbook['loc'] == null ||
          event.reportLogbook['loc'].isEmpty) {
        emit(NewLogBookNotReported(
            logbookNotReported: DatabaseUtil.getText('LocationEmpty')));
      } else if (event.reportLogbook['priority'] == null ||
          event.reportLogbook['priority'].isEmpty) {
        emit(NewLogBookNotReported(
            logbookNotReported: DatabaseUtil.getText('PriorityEmpty')));
      } else {
        Map registerNewLogMap = {
          "eventdate": event.reportLogbook['eventdate'],
          "eventtime": event.reportLogbook['eventtime'],
          "description": event.reportLogbook['description'],
          "component": event.reportLogbook['component'] ?? '',
          "userid": userId,
          "priority": event.reportLogbook['priority'],
          "handover": event.reportLogbook['handover'] ?? '',
          "logbookid": event.reportLogbook['logbookid'],
          "activity": event.reportLogbook['activity'] ?? '',
          "flags": event.reportLogbook['flags'] ?? '',
          "loc": event.reportLogbook['loc'],
          "hashcode": hashCode
        };
        ReportNewLogBookModel reportNewLogBookModel =
            await _logbookRepository.reportNewLogbook(registerNewLogMap);
        if (reportNewLogBookModel.status == 200) {
          emit(
              NewLogBookReported(reportNewLogBookModel: reportNewLogBookModel));
        } else {
          emit(NewLogBookNotReported(
              logbookNotReported: reportNewLogBookModel.message));
        }
      }
    } catch (e) {
      emit(NewLogBookNotReported(logbookNotReported: e.toString()));
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
