import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/thirdPartyApprove/sys_user_checklist_third_party_approve_events.dart';
import 'package:toolkit/blocs/checklist/systemUser/thirdPartyApprove/sys_user_checklist_third_party_approve_states.dart';
import 'package:toolkit/data/models/checklist/systemUser/sys_user_third_party_approval_model.dart';
import '../../../../data/cache/cache_keys.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../di/app_module.dart';
import '../../../../repositories/checklist/systemUser/sys_user_checklist_repository.dart';

class CheckListThirdPartyApproveBloc extends Bloc<
    ThirdPartyApproveCheckListEvent, CheckListThirdPartyApproveStates> {
  final SysUserCheckListRepository _sysUserCheckListRepository =
      getIt<SysUserCheckListRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  CheckListThirdPartyApproveStates get initialState =>
      CheckListThirdPartyApproveInitial();

  CheckListThirdPartyApproveBloc()
      : super(CheckListThirdPartyApproveInitial()) {
    on<ThirdPartyApproveCheckListEvent>(_thirdPartyApproveChecklist);
  }

  FutureOr<void> _thirdPartyApproveChecklist(
      ThirdPartyApproveCheckListEvent event,
      Emitter<CheckListThirdPartyApproveStates> emit) async {
    emit(CheckListThirdPartyApproving());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      if (event.responseIdList.isEmpty || event.responseIdList == []) {
        emit(CheckListThirdPartyNotApproved(
            errorMessage: 'Please select atleast one record to continue!'));
      } else if (event.thirdPartyApproveMap["name"] == null ||
          event.thirdPartyApproveMap["name"].toString().trim().isEmpty) {
        emit(CheckListThirdPartyNotApproved(errorMessage: 'Please enter name'));
      } else {
        List responseId = [];
        for (int i = 0; i < event.responseIdList.length; i++) {
          responseId.add({"id": event.responseIdList[i]});
        }
        final Map postThirdPartApprovalDataMap = {
          "hashcode": hashCode,
          "responseids": responseId,
          "name": event.thirdPartyApproveMap["name"],
          "sign_text": event.thirdPartyApproveMap["sign_text"]
        };
        SaveCheckListThirdPartyApproval saveThirdPartyApproval =
            await _sysUserCheckListRepository
                .checklistThirdPartyApproval(postThirdPartApprovalDataMap);
        emit(CheckListThirdPartyApproved(
            saveThirdPartyApproval: saveThirdPartyApproval));
      }
    } catch (e) {
      emit(CheckListThirdPartyNotApproved(errorMessage: e.toString()));
    }
  }
}
