import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/rejectReason/workforce_checklist_reject_reason_event.dart';
import 'package:toolkit/blocs/checklist/workforce/rejectReason/workforce_checklist_reject_reason_states.dart';
import 'package:toolkit/data/models/checklist/workforce/fetch_checklist_workforce_documents_model.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../../data/cache/cache_keys.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../data/models/checklist/workforce/workforce_checklist_save_reject_reason_model.dart';
import '../../../../data/models/checklist/workforce/workforce_fetch_reject_reason_model.dart';
import '../../../../di/app_module.dart';
import '../../../../repositories/checklist/workforce/workforce_repository.dart';

class WorkForceCheckListSaveRejectBloc extends Bloc<
    WorkForceCheckListRejectReasonEvent, WorkForceCheckListRejectReasonStates> {
  final WorkForceRepository _workForceRepository = getIt<WorkForceRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  WorkForceCheckListSaveRejectBloc() : super(CheckListRejectReasonInitial()) {
    on<CheckListFetchRejectReasons>(_fetchChecklistRejectReason);
    on<CheckListSelectRejectReasons>(_selectRejectReason);
    on<CheckListSaveRejectReasons>(_saveRejectReasons);
    on<FetchChecklistWorkforceDocuments>(_fetchChecklistWorkforceDocuments);
  }

  FutureOr<void> _fetchChecklistRejectReason(CheckListFetchRejectReasons event,
      Emitter<WorkForceCheckListRejectReasonStates> emit) async {
    emit(CheckListFetchingRejectReasons());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      GetCheckListRejectReasonsModel getCheckListRejectReasonsModel =
          await _workForceRepository.fetchChecklistRejectReason(hashCode);
      if (getCheckListRejectReasonsModel.status == 200 &&
          getCheckListRejectReasonsModel.data!.isNotEmpty) {
        add(CheckListSelectRejectReasons(
            reason: '',
            getCheckListRejectReasonsModel: getCheckListRejectReasonsModel));
      } else {
        emit(CheckListRejectReasonsError());
      }
    } catch (e) {
      emit(CheckListRejectReasonsError());
    }
  }

  _selectRejectReason(CheckListSelectRejectReasons event,
      Emitter<WorkForceCheckListRejectReasonStates> emit) async {
    emit(CheckListRejectReasonsFetched(
        getCheckListRejectReasonsModel: event.getCheckListRejectReasonsModel,
        reason: event.reason));
  }

  FutureOr<void> _saveRejectReasons(CheckListSaveRejectReasons event,
      Emitter<WorkForceCheckListRejectReasonStates> emit) async {
    emit(SavingCheckListRejectReasons());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      if (event.reason == "" || event.reason.trim().isEmpty) {
        emit(CheckListRejectReasonsNotSaved(
            message: StringConstants.kSelectReason));
      } else {
        Map saveRejectReasonMap = {
          "scheduleid": event.allCheckListDataMap["scheduleId"],
          "workforceid": userId,
          "reasontext": event.reason,
          "hashcode": hashCode
        };
        PostRejectReasonsModel postRejectReasonsModel =
            await _workForceRepository.saveRejectReasons(saveRejectReasonMap);
        emit(CheckListRejectReasonsSaved(
            postRejectReasonsModel: postRejectReasonsModel));
      }
    } catch (e) {
      emit(CheckListRejectReasonsNotSaved(message: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchChecklistWorkforceDocuments(
      FetchChecklistWorkforceDocuments event,
      Emitter<WorkForceCheckListRejectReasonStates> emit) async {
    emit(ChecklistWorkforceDocumentsFetching());
    try {
      String hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String clientId =
          await _customerCache.getClientId(CacheKeys.clientId) ?? '';
      FetchChecklistWorkforceDocumentsModel
          fetchChecklistWorkforceDocumentsModel = await _workForceRepository
              .fetchChecklistViewDocuments(event.checklistId, hashCode);
      if (fetchChecklistWorkforceDocumentsModel.status == 200) {
        emit(ChecklistWorkforceDocumentsFetched(
            fetchChecklistWorkforceDocumentsModel:
                fetchChecklistWorkforceDocumentsModel,
            clientId: clientId));
      } else {
        emit(ChecklistWorkforceDocumentsNotFetched(
            errorMessage: fetchChecklistWorkforceDocumentsModel.message));
      }
    } catch (e) {
      emit(ChecklistWorkforceDocumentsNotFetched(errorMessage: e.toString()));
    }
  }
}
