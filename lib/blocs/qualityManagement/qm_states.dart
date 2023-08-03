import '../../data/models/qualityManagement/fetch_qm_details_model.dart';
import '../../data/models/qualityManagement/fetch_qm_list_model.dart';
import '../../data/models/qualityManagement/fetch_qm_roles_model.dart';

abstract class QualityManagementStates {}

class QualityManagementInitial extends QualityManagementStates {}

class FetchingQualityManagementList extends QualityManagementStates {}

class QualityManagementListFetched extends QualityManagementStates {
  final FetchQualityManagementListModel fetchQualityManagementListModel;
  final Map filtersMap;

  QualityManagementListFetched(
      {required this.filtersMap,
      required this.fetchQualityManagementListModel});
}

class FetchingQualityManagementDetails extends QualityManagementStates {}

class QualityManagementDetailsFetched extends QualityManagementStates {
  final FetchQualityManagementDetailsModel fetchQualityManagementDetailsModel;
  final String clientId;

  QualityManagementDetailsFetched(
      {required this.clientId,
      required this.fetchQualityManagementDetailsModel});
}

class QualityManagementDetailsNotFetched extends QualityManagementStates {
  final String detailsNotFetched;

  QualityManagementDetailsNotFetched({required this.detailsNotFetched});
}

class FetchingQualityManagementRoles extends QualityManagementStates {}

class QualityManagementRolesFetched extends QualityManagementStates {
  final FetchQualityManagementRolesModel fetchQualityManagementRolesModel;
  final String roleId;

  QualityManagementRolesFetched(
      {required this.roleId, required this.fetchQualityManagementRolesModel});
}

class QualityManagementRolesNotFetched extends QualityManagementStates {
  final String rolesNotFetched;

  QualityManagementRolesNotFetched({required this.rolesNotFetched});
}

class QualityManagementRoleChanged extends QualityManagementStates {
  final String roleId;

  QualityManagementRoleChanged({required this.roleId});
}
