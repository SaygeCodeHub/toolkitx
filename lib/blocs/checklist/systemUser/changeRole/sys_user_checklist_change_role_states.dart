import 'package:equatable/equatable.dart';

import '../../../../data/models/checklist/systemUser/sys_user_change_role_model.dart';

abstract class CheckListRoleStates extends Equatable {}

class CheckListRoleInitial extends CheckListRoleStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchingCheckListRoles extends CheckListRoleStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CheckListRolesFetched extends CheckListRoleStates {
  final CheckListRolesModel checkListRolesModel;
  final String roleId;
  final String roleName;
  final bool isRoleSelected;

  CheckListRolesFetched(
      {required this.isRoleSelected,
      required this.roleId,
      required this.roleName,
      required this.checkListRolesModel});

  @override
  List<Object?> get props => [checkListRolesModel, roleId, roleName];
}

class CheckListRolesNotFetched extends CheckListRoleStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CheckListRoleChanged extends CheckListRoleStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}
