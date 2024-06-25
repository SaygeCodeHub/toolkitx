import '../../../../data/models/checklist/systemUser/sys_user_change_role_model.dart';

abstract class CheckListRoleEvents {}

class CheckListFetchRoles extends CheckListRoleEvents {
  final String roleName;
  bool isChanged;

  CheckListFetchRoles({required this.roleName, this.isChanged = false});
}

class CheckListChangeRole extends CheckListRoleEvents {
  final CheckListRolesModel checkListRolesModel;
  final String roleId;
  final String roleName;
  final bool isRoleSelected;

  CheckListChangeRole(
      {this.isRoleSelected = false,
      required this.checkListRolesModel,
      required this.roleId,
      required this.roleName});
}
