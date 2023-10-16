import 'dart:async';

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
import '../../data/safetyNotice/fetch_safety_notice_details_model.dart';
import '../../data/safetyNotice/fetch_safety_notices_model.dart';
import '../../data/safetyNotice/issue_safety_notice_model.dart';
import '../../data/safetyNotice/save_safety_notice_files_model.dart';
import '../../data/safetyNotice/update_safety_notice_model.dart';
import '../../repositories/safetyNotice/safety_notice_repository.dart';

class SafetyNoticeBloc extends Bloc<SafetyNoticeEvent, SafetyNoticeStates> {
  final SafetyNoticeRepository _safetyNoticeRepository =
      getIt<SafetyNoticeRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  bool safetyNoticeListReachedMax = false;
  List<Notice> noticesDatum = [];
  String safetyNoticeId = '';
  int safetyNoticeTabIndex = 0;
  Map safetyNoticeDetailsMap = {};

  SafetyNoticeStates get initialState => SafetyNoticeInitialState();

  SafetyNoticeBloc() : super(SafetyNoticeInitialState()) {
    on<FetchSafetyNotices>(_fetchSafetyNotices);
    on<AddSafetyNotice>(_addSafetyNotice);
    on<SafetyNoticeSaveFiles>(_saveSafetyNoticeFiles);
    on<FetchSafetyNoticeDetails>(_fetchSafetyNoticeDetails);
    on<UpdateSafetyNotice>(_updateSafetyNotice);
    on<IssueSafetyNotice>(_issueSafetyNotice);
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
        popUpMenuList.add(DatabaseUtil.getText('Reissue'));
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
}
