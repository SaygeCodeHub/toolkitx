import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/SignInQRCode/assign_to_me_workorder_model.dart';
import 'package:toolkit/di/app_module.dart';

import '../../../data/cache/cache_keys.dart';
import '../../../data/cache/customer_cache.dart';
import '../../../data/models/SignInQRCode/assign_to_me_checklist_model.dart';
import '../../../data/models/SignInQRCode/assign_to_me_loto_model.dart';
import '../../../data/models/SignInQRCode/assign_to_me_permit_model.dart';
import '../../../repositories/SignInQRCode/signin_repository.dart';
import '../../../utils/database_utils.dart';

part 'sign_in_assign_to_me_event.dart';
part 'sign_in_assign_to_me_state.dart';

class SignInAssignToMeBloc
    extends Bloc<SignInAssignToMeEvent, SignInAssignToMeState> {
  final SignInRepository _signInRepository = getIt<SignInRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  SignInAssignToMeBloc() : super(SignInAssignToMeInitial()) {
    on<AssignToMeWorkOrder>(_assignToMeWorkorder);
    on<AssignToMePermit>(_assignToMePermit);
    on<AssignToMeLOTO>(_assignToMeLOTO);
    on<AssignToMeChecklist>(_assignToMeChecklist);
  }

  Future<FutureOr<void>> _assignToMeWorkorder(
      AssignToMeWorkOrder event, Emitter<SignInAssignToMeState> emit) async {
    emit(WorkOrderAssigning());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userid = await _customerCache.getUserId(CacheKeys.userId);

      Map assignToMeWorkorderMap = {
        "woid": event.assignToMeWorkOrdersMap["woid"],
        "peopleid": userid,
        "userid": userid,
        "hashcode": hashCode
      };
      AssignToMeWorkOrderModel assignToMeWorkOrderModel =
          await _signInRepository.assignToMeWorkOrder(assignToMeWorkorderMap);

      if (assignToMeWorkOrderModel.status == 200) {
        emit(WorkOrderAssigned(
            assignToMeWorkOrderModel: assignToMeWorkOrderModel));
      } else {
        emit(WorkOrderAssignError(
            workOrderError:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(WorkOrderAssignError(workOrderError: e.toString()));
    }
  }

  Future<FutureOr<void>> _assignToMePermit(
      AssignToMePermit event, Emitter<SignInAssignToMeState> emit) async {
    emit(PermitAssigning());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userid = await _customerCache.getUserId(CacheKeys.userId);

      Map assignToMePermitMap = {
        "permitid": event.assignToMePermitsMap["permitid"],
        "userid": userid,
        "hashcode": hashCode
      };
      AssignToMePermitModel assignToMePermitModel =
          await _signInRepository.assignToMePermit(assignToMePermitMap);
      if (assignToMePermitModel.status == 200) {
        emit(
            PermitAssigned(assignToMePermitModel: assignToMePermitModel));
      } else {
        emit(PermitAssignError(
            permitError:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(PermitAssignError(permitError: e.toString()));
    }
  }

  Future<FutureOr<void>> _assignToMeLOTO(
      AssignToMeLOTO event, Emitter<SignInAssignToMeState> emit) async {
    emit(LOTOAssigning());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userid = await _customerCache.getHashCode(CacheKeys.userId);

      Map assignToMeLOTOMap = {
        "lotoid": event.assignToMeLOTOsMap["lotoid"],
        "userid": userid,
        "hashcode": hashCode
      };
      AssignToMeLotoModel assignToMeLotoModel =
          await _signInRepository.assignToMeLOTO(assignToMeLOTOMap);
      if (assignToMeLotoModel.status == 200) {
        emit(LOTOAssigned(assignToMeLotoModel: assignToMeLotoModel));
      } else {
        emit(LOTOAssignError(
            permitError:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(LOTOAssignError(permitError: e.toString()));
    }
  }

  Future<FutureOr<void>> _assignToMeChecklist(
      AssignToMeChecklist event, Emitter<SignInAssignToMeState> emit) async {
    emit(ChecklistAssigning());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userid = await _customerCache.getHashCode(CacheKeys.userId);

      Map assignToMeChecklistMap = {
        "checklistid": event.assignToMeChecklistsMap,
        "userid": userid,
        "hashcode": hashCode
      };

      AssignToMeChecklistModel assignToMeChecklistModel =
          await _signInRepository.assignToMeChecklist(assignToMeChecklistMap);

      if (assignToMeChecklistModel.status == 200) {
        emit(ChecklistAssigned(
            assignToMeChecklistModel: assignToMeChecklistModel));
      } else {
        emit(ChecklistAssignError(
            checklistError:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(ChecklistAssignError(checklistError: e.toString()));
    }
  }
}
