import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/approve/sys_user_approve_checklist_events.dart';
import 'package:toolkit/blocs/checklist/systemUser/approve/sys_user_approve_checklist_states.dart';
import '../../../../data/cache/cache_keys.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../data/models/checklist/systemUser/sys_user_approve_model.dart';
import '../../../../di/app_module.dart';
import '../../../../repositories/checklist/systemUser/sys_user_checklist_repository.dart';

class CheckListApproveBloc
    extends Bloc<ApproveCheckListEvent, CheckListApproveStates> {
  final SysUserCheckListRepository _sysUserCheckListRepository =
      getIt<SysUserCheckListRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  CheckListApproveStates get initialState => ApproveCheckListInitial();

  CheckListApproveBloc() : super(ApproveCheckListInitial()) {
    on<ApproveCheckListEvent>(_checklistApprove);
  }

  FutureOr<void> _checklistApprove(
      ApproveCheckListEvent event, Emitter<CheckListApproveStates> emit) async {
    emit(ApprovingCheckList());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      if (event.responseIdList.isEmpty || event.responseIdList == []) {
        emit(CheckListNotApproved(
            errorMessage: 'Please select atleast one record to continue!'));
      } else if (event.approveMap["comment"] == null ||
          event.approveMap["comment"].toString().trim().isEmpty) {
        emit(CheckListNotApproved(errorMessage: 'Please add comment!'));
      } else {
        List responseId = [];
        for (int i = 0; i < event.responseIdList.length; i++) {
          responseId.add({"id": event.responseIdList[i]});
        }
        final Map postApproveDataMap = {
          "hashcode": hashCode,
          "responseids": responseId,
          "comments": event.approveMap["comment"]
        };
        ChecklistApproveModel checklistApproveModel =
            await _sysUserCheckListRepository
                .checkListApprove(postApproveDataMap);
        emit(CheckListApproved(checklistApproveModel: checklistApproveModel));
      }
    } catch (e) {
      emit(CheckListNotApproved(errorMessage: e.toString()));
    }
  }
}
