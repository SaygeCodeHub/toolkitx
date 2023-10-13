import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/safetyNotice/safety_notice_events.dart';
import 'package:toolkit/blocs/safetyNotice/safety_notice_states.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../../di/app_module.dart';
import '../../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/safetyNotice/add_safety_notice_model.dart';
import '../../data/safetyNotice/fetch_safety_notice_details_model.dart';
import '../../data/safetyNotice/fetch_safety_notices_model.dart';
import '../../data/safetyNotice/save_safety_notice_files_model.dart';
import '../../repositories/safetyNotice/safety_notice_repository.dart';

class SafetyNoticeBloc extends Bloc<SafetyNoticeEvent, SafetyNoticeStates> {
  final SafetyNoticeRepository _safetyNoticeRepository =
      getIt<SafetyNoticeRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  bool safetyNoticeListReachedMax = false;
  List<Notice> noticesDatum = [];
  String safetyNoticeId = '';
  int safetyNoticeTabIndex = 0;

  SafetyNoticeStates get initialState => SafetyNoticeInitialState();

  SafetyNoticeBloc() : super(SafetyNoticeInitialState()) {
    on<FetchSafetyNotices>(_fetchSafetyNotices);
    on<AddSafetyNotice>(_addSafetyNotice);
    on<SafetyNoticeSaveFiles>(_saveSafetyNoticeFiles);
    on<FetchSafetyNoticeDetails>(_fetchSafetyNoticeDetails);
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

  FutureOr<void> _addSafetyNotice(
      AddSafetyNotice event, Emitter<SafetyNoticeStates> emit) async {
    emit(AddingSafetyNotice());
    try {
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      if (event.addSafetyNoticeMap['notice'] == null) {
        emit(SafetyNoticeNotAdded(
            errorMessage: StringConstants.kSafetyNoticeValidation));
      } else if (event.addSafetyNoticeMap['validity'] == null) {
        emit(SafetyNoticeNotAdded(
            errorMessage: StringConstants.kSafetyNoticeValidityValidation));
      } else {
        Map addSafetyNoticeMap = {
          "userid": userId,
          "notice": event.addSafetyNoticeMap['notice'] ?? '',
          "validity": event.addSafetyNoticeMap['validity'] ?? '',
          "hashcode": hashCode
        };
        AddSafetyNoticeModel addSafetyNoticeModel =
            await _safetyNoticeRepository.addSafetyNotices(addSafetyNoticeMap);
        if (addSafetyNoticeModel.status == 200) {
          emit(SafetyNoticeAdded(addSafetyNoticeModel: addSafetyNoticeModel));
          add(SafetyNoticeSaveFiles(
              safetyNoticeId: addSafetyNoticeModel.message,
              addSafetyNoticeMap: event.addSafetyNoticeMap));
        } else {
          emit(SafetyNoticeNotAdded(
              errorMessage:
                  DatabaseUtil.getText('some_unknown_error_please_try_again')));
        }
      }
    } catch (e) {
      emit(SafetyNoticeNotAdded(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _saveSafetyNoticeFiles(
      SafetyNoticeSaveFiles event, Emitter<SafetyNoticeStates> emit) async {
    emit(SavingSafetyNoticeFiles());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      Map saveSafetyNoticeFilesMap = {
        "noticeid": event.safetyNoticeId,
        "file_name": event.addSafetyNoticeMap['file_name'] ?? '',
        "hashcode": hashCode
      };
      SaveSafetyNoticeFilesModel saveSafetyNoticeFilesModel =
          await _safetyNoticeRepository
              .saveSafetyNoticesFiles(saveSafetyNoticeFilesMap);
      if (saveSafetyNoticeFilesModel.status == 200) {
        emit(SafetyNoticeFilesSaved(
            saveSafetyNoticeFilesModel: saveSafetyNoticeFilesModel));
      } else {
        emit(SafetyNoticeFilesNotSaved(
            filesNotSaved:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(SafetyNoticeFilesNotSaved(filesNotSaved: e.toString()));
    }
  }

  FutureOr<void> _fetchSafetyNoticeDetails(
      FetchSafetyNoticeDetails event, Emitter<SafetyNoticeStates> emit) async {
    emit(FetchingSafetyNoticeDetails());
    try {
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? clientId = await _customerCache.getClientId(CacheKeys.clientId);
      FetchSafetyNoticeDetailsModel fetchSafetyNoticeDetailsModel =
          await _safetyNoticeRepository.fetchSafetyNoticeDetails(
              event.safetyNoticeId, userId!, hashCode!);
      safetyNoticeId = event.safetyNoticeId;
      safetyNoticeTabIndex = event.tabIndex;
      emit(SafetyNoticeDetailsFetched(
          fetchSafetyNoticeDetailsModel: fetchSafetyNoticeDetailsModel,
          clientId: clientId!));
    } catch (e) {
      emit(SafetyNoticeDetailsNotFetched(detailsNotFetched: e.toString()));
    }
  }
}
