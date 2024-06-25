import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/changeRole/sys_user_checklist_change_role_event.dart';
import 'package:toolkit/blocs/checklist/systemUser/changeRole/sys_user_checklist_change_role_states.dart';
import '../../../../data/cache/cache_keys.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../data/models/checklist/systemUser/sys_user_change_role_model.dart';
import '../../../../di/app_module.dart';
import '../../../../repositories/checklist/systemUser/sys_user_checklist_repository.dart';

class CheckListRoleBloc extends Bloc<CheckListRoleEvents, CheckListRoleStates> {
  final SysUserCheckListRepository _sysUserCheckListRepository =
      getIt<SysUserCheckListRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  String roleId = '';
  String roleName = '';

  CheckListRoleStates get initialState => CheckListRoleInitial();

  CheckListRoleBloc() : super(CheckListRoleInitial()) {
    on<CheckListFetchRoles>(_checkListFetchRoles);
    on<CheckListChangeRole>(_checkListChangeRole);
  }

  FutureOr<void> _checkListFetchRoles(
      CheckListFetchRoles event, Emitter<CheckListRoleStates> emit) async {
    emit(FetchingCheckListRoles());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      CheckListRolesModel checkListRolesModel =
          await _sysUserCheckListRepository.fetchCheckListRole(
              hashCode, userId);
      if (checkListRolesModel.status == 200 &&
          checkListRolesModel.data!.isNotEmpty) {
        add(CheckListChangeRole(
            roleId: roleId,
            roleName: event.roleName,
            checkListRolesModel: checkListRolesModel));
      } else {
        emit(CheckListRolesNotFetched());
      }
    } catch (e) {
      emit(CheckListRolesNotFetched());
    }
  }

  _checkListChangeRole(
      CheckListChangeRole event, Emitter<CheckListRoleStates> emit) {
    roleId = event.roleId;
    roleName = event.roleName;
    if (event.roleName == '') {
      roleName = event.checkListRolesModel.data![0].groupName.toString();
      emit(CheckListRolesFetched(
          roleId: roleId,
          roleName: roleName,
          checkListRolesModel: event.checkListRolesModel,
          isRoleSelected: event.isRoleSelected));
    } else {
      emit(CheckListRolesFetched(
          roleId: roleId,
          roleName: roleName,
          checkListRolesModel: event.checkListRolesModel,
          isRoleSelected: event.isRoleSelected));
    }
  }
}
