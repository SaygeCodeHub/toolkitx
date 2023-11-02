import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/safetyNotice/safety_notice_events.dart';
import 'package:toolkit/blocs/safetyNotice/safety_notice_states.dart';
import 'package:toolkit/data/models/encrypt_class.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../../di/app_module.dart';
import '../../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/safetyNotice/add_safety_notice_model.dart';
import '../../data/safetyNotice/cancel_safety_notice_model.dart';
import '../../data/safetyNotice/close_safety_notice_model.dart';
import '../../data/safetyNotice/fetch_safety_notice_details_model.dart';
import '../../data/safetyNotice/fetch_safety_notice_history_model.dart';
import '../../data/safetyNotice/fetch_safety_notices_model.dart';
import '../../data/safetyNotice/hold_safety_notice_model.dart';
import '../../data/safetyNotice/issue_safety_notice_model.dart';
import '../../data/safetyNotice/reissue_safety_notice_model.dart';
import '../../data/safetyNotice/save_safety_notice_files_model.dart';
import '../../data/safetyNotice/update_safety_notice_model.dart';
import '../../repositories/safetyNotice/safety_notice_repository.dart';

class SafetyNoticeBloc extends Bloc<SafetyNoticeEvent, SafetyNoticeStates> {
  final SafetyNoticeRepository _safetyNoticeRepository =
      getIt<SafetyNoticeRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  bool safetyNoticeListReachedMax = false;
  bool safetyNoticeHistoryListReachedMax = false;
  List<Notice> noticesDatum = [];
  List<HistoryNotice> noticesHistoryDatum = [];
  String safetyNoticeId = '';
  int safetyNoticeTabIndex = 0;
  Map safetyNoticeDetailsMap = {};
  Map safetNoticeFilterMap = {};

  SafetyNoticeStates get initialState => SafetyNoticeInitialState();

  SafetyNoticeBloc() : super(SafetyNoticeInitialState()) {
    on<FetchSafetyNotices>(_fetchSafetyNotices);
    on<SelectSafetyNoticeStatus>(_selectSafetyNoticeStatus);
    on<SafetyNoticeApplyFilter>(_safetyNoticeApplyFilter);
    on<AddSafetyNotice>(_addSafetyNotice);
    on<SafetyNoticeSaveFiles>(_saveSafetyNoticeFiles);
    on<FetchSafetyNoticeDetails>(_fetchSafetyNoticeDetails);
    on<UpdateSafetyNotice>(_updateSafetyNotice);
    on<IssueSafetyNotice>(_issueSafetyNotice);
    on<HoldSafetyNotice>(_holdSafetyNotice);
    on<CancelSafetyNotice>(_cancelSafetyNotice);
    on<CloseSafetyNotice>(_closeSafetyNotice);
    on<FetchSafetyNoticeHistoryList>(_fetchSafetyNoticeHistory);
    on<ReIssueSafetyNotice>(_reIssueSafetyNotice);
    on<SafetyNoticeReadReceipt>(_safetyNoticeReadReceipt);
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
          if (event.addSafetyNoticeMap['file_name'] != null) {
            add(SafetyNoticeSaveFiles(
                safetyNoticeId: addSafetyNoticeModel.message,
                addSafetyNoticeMap: event.addSafetyNoticeMap));
          }
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
      String? apiKey = await _customerCache.getApiKey(CacheKeys.apiKey);
      FetchSafetyNoticeDetailsModel fetchSafetyNoticeDetailsModel =
          await _safetyNoticeRepository.fetchSafetyNoticeDetails(
              event.safetyNoticeId, userId!, hashCode!);
      safetyNoticeId = event.safetyNoticeId;
      safetyNoticeTabIndex = event.tabIndex;
      List popUpMenuList = [];
      if (fetchSafetyNoticeDetailsModel.data.canEdit == '1') {
        popUpMenuList.add(DatabaseUtil.getText('Edit'));
      }
      if (fetchSafetyNoticeDetailsModel.data.canIssue == '1') {
        popUpMenuList.insert(1, DatabaseUtil.getText('Issue'));
      }
      if (fetchSafetyNoticeDetailsModel.data.canHold == '1') {
        popUpMenuList.insert(1, DatabaseUtil.getText('Hold'));
      }
      if (fetchSafetyNoticeDetailsModel.data.canCancel == '1') {
        popUpMenuList.add(DatabaseUtil.getText('Cancel'));
      }
      if (fetchSafetyNoticeDetailsModel.data.canReissue == '1') {
        popUpMenuList.add(DatabaseUtil.getText('ReIssue'));
      }
      if (fetchSafetyNoticeDetailsModel.data.canClose == '1') {
        popUpMenuList.add(DatabaseUtil.getText('Close'));
      }
      String encryptedNoticeId = EncryptData.encryptAESPrivateKey(
          fetchSafetyNoticeDetailsModel.data.noticeid, apiKey);
      safetyNoticeDetailsMap = {
        "notice": fetchSafetyNoticeDetailsModel.data.notice,
        "validity": fetchSafetyNoticeDetailsModel.data.validity,
        "noticeid": encryptedNoticeId,
        'clientId': clientId,
        'file_name': fetchSafetyNoticeDetailsModel.data.files
      };
      emit(SafetyNoticeDetailsFetched(
          fetchSafetyNoticeDetailsModel: fetchSafetyNoticeDetailsModel,
          clientId: clientId!,
          popUpMenuOptionsList: popUpMenuList,
          safetyNoticeDetailsMap: safetyNoticeDetailsMap));
      add(SafetyNoticeReadReceipt(safetyNoticeId: event.safetyNoticeId));
    } catch (e) {
      emit(SafetyNoticeDetailsNotFetched(detailsNotFetched: e.toString()));
    }
  }

  FutureOr<void> _updateSafetyNotice(
      UpdateSafetyNotice event, Emitter<SafetyNoticeStates> emit) async {
    emit(UpdatingSafetyNotice());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map updateSafetyNoticeMap = {
        "userid": userId,
        "notice": event.updateSafetyNoticeMap['notice'] ?? '',
        "validity": event.updateSafetyNoticeMap['validity'] ?? '',
        "noticeid": event.updateSafetyNoticeMap['noticeid'] ?? '',
        "hashcode": hashCode
      };
      UpdatingSafetyNoticeModel updatingSafetyNoticeModel =
          await _safetyNoticeRepository
              .updateSafetyNotices(updateSafetyNoticeMap);
      if (updatingSafetyNoticeModel.status == 200) {
        emit(SafetyNoticeUpdated(
            updatingSafetyNoticeModel: updatingSafetyNoticeModel));
        if (event.updateSafetyNoticeMap['file_name'] != null) {
          add(SafetyNoticeSaveFiles(
              safetyNoticeId: updatingSafetyNoticeModel.message,
              addSafetyNoticeMap: event.updateSafetyNoticeMap));
        }
      } else {
        emit(SafetyNoticeCouldNotUpdate(
            noticeNotUpdated:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(SafetyNoticeCouldNotUpdate(noticeNotUpdated: e.toString()));
    }
  }

  FutureOr<void> _issueSafetyNotice(
      IssueSafetyNotice event, Emitter<SafetyNoticeStates> emit) async {
    emit(IssuingSafetyNotice());
    try {
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      Map issueSafetyNoticeMap = {
        "userid": userId,
        "noticeid": safetyNoticeDetailsMap['noticeid'],
        "hashcode": hashCode
      };
      IssueSafetyNoticeModel issueSafetyNoticeModel =
          await _safetyNoticeRepository
              .issueSafetyNotices(issueSafetyNoticeMap);
      if (issueSafetyNoticeModel.status == 200) {
        emit(
            SafetyNoticeIssued(issueSafetyNoticeModel: issueSafetyNoticeModel));
      } else {
        emit(SafetyNoticeFailedToIssue(
            noticeNotIssued:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(SafetyNoticeFailedToIssue(noticeNotIssued: e.toString()));
    }
  }

  FutureOr<void> _holdSafetyNotice(
      HoldSafetyNotice event, Emitter<SafetyNoticeStates> emit) async {
    emit(PuttingSafetyNoticeOnHold());
    try {
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      Map holdSafetyNoticeMap = {
        "userid": userId,
        "noticeid": safetyNoticeDetailsMap['noticeid'],
        "hashcode": hashCode
      };
      HoldSafetyNoticeModel holdSafetyNoticeModel =
          await _safetyNoticeRepository.holdSafetyNotices(holdSafetyNoticeMap);
      if (holdSafetyNoticeModel.status == 200) {
        emit(SafetyNoticeOnHold(holdSafetyNoticeModel: holdSafetyNoticeModel));
      } else {
        emit(SafetyNoticeNotOnHold(
            noticeNotOnHold:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(SafetyNoticeNotOnHold(noticeNotOnHold: e.toString()));
    }
  }

  FutureOr<void> _cancelSafetyNotice(
      CancelSafetyNotice event, Emitter<SafetyNoticeStates> emit) async {
    emit(CancellingSafetyNotice());
    try {
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      Map cancelSafetyNoticeMap = {
        "userid": userId,
        "noticeid": safetyNoticeDetailsMap['noticeid'],
        "hashcode": hashCode
      };
      CancelSafetyNoticeModel cancelSafetyNoticeModel =
          await _safetyNoticeRepository
              .cancelSafetyNotices(cancelSafetyNoticeMap);
      if (cancelSafetyNoticeModel.status == 200) {
        emit(SafetyNoticeCancelled(
            cancelSafetyNoticeModel: cancelSafetyNoticeModel));
      } else {
        emit(SafetyNoticeNotCancelled(
            noticeNotCancelled:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(SafetyNoticeNotCancelled(noticeNotCancelled: e.toString()));
    }
  }

  FutureOr<void> _closeSafetyNotice(
      CloseSafetyNotice event, Emitter<SafetyNoticeStates> emit) async {
    emit(ClosingSafetyNotice());
    try {
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      Map closeSafetyNoticeMap = {
        "userid": userId,
        "noticeid": safetyNoticeDetailsMap['noticeid'],
        "hashcode": hashCode
      };
      CloseSafetyNoticeModel closeSafetyNoticeModel =
          await _safetyNoticeRepository.closeSafetyNotice(closeSafetyNoticeMap);
      if (closeSafetyNoticeModel.status == 200) {
        emit(
            SafetyNoticeClosed(closeSafetyNoticeModel: closeSafetyNoticeModel));
      } else {
        emit(SafetyNoticeNotClosed(
            noticeNotClosed:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(SafetyNoticeNotClosed(noticeNotClosed: e.toString()));
    }
  }

  FutureOr<void> _fetchSafetyNoticeHistory(FetchSafetyNoticeHistoryList event,
      Emitter<SafetyNoticeStates> emit) async {
    emit(FetchingSafetyNoticeHistoryList());
    try {
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      if (!safetyNoticeHistoryListReachedMax) {
        FetchHistorySafetyNoticeModel fetchHistorySafetyNoticeModel =
            await _safetyNoticeRepository.fetchSafetyNoticeHistoryList(
                event.pageNo, userId!, hashCode!, '{}');
        noticesHistoryDatum
            .addAll(fetchHistorySafetyNoticeModel.data.noticesHistoryDatum);
        safetyNoticeHistoryListReachedMax =
            fetchHistorySafetyNoticeModel.data.noticesHistoryDatum.isEmpty;
        emit(SafetyNoticeHistoryListFetched(historyDatum: noticesHistoryDatum));
      }
    } catch (e) {
      emit(SafetyNoticeHistoryListNotFetched(historyNotFetched: e.toString()));
    }
  }

  FutureOr<void> _reIssueSafetyNotice(
      ReIssueSafetyNotice event, Emitter<SafetyNoticeStates> emit) async {
    emit(ReIssuingSafetyNotice());
    try {
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      Map reIssueSafetyNoticeMap = {
        "userid": userId,
        "noticeid": safetyNoticeDetailsMap['noticeid'],
        "hashcode": hashCode
      };
      ReIssueSafetyNoticeModel reIssueSafetyNoticeModel =
          await _safetyNoticeRepository
              .reIssueSafetyNotice(reIssueSafetyNoticeMap);
      if (reIssueSafetyNoticeModel.status == 200) {
        emit(SafetyNoticeReIssued(
            reIssueSafetyNoticeModel: reIssueSafetyNoticeModel));
      } else {
        emit(SafetyNoticeFailedToReIssue(
            noticeNotReIssued:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(SafetyNoticeFailedToReIssue(noticeNotReIssued: e.toString()));
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

  FutureOr<void> _safetyNoticeReadReceipt(
      SafetyNoticeReadReceipt event, Emitter<SafetyNoticeStates> emit) async {
    String? userId = await _customerCache.getUserId(CacheKeys.userId);
    String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
    Map saveReadReceiptMap = {
      "hashcode": hashCode,
      "userid": userId,
      "noticeid": event.safetyNoticeId
    };
    await _safetyNoticeRepository.saveReadReceipt(saveReadReceiptMap);
  }
}
