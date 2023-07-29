abstract class QualityManagementEvent {}

class FetchQualityManagementList extends QualityManagementEvent {
  final int pageNo;

  FetchQualityManagementList({required this.pageNo});
}

class FetchQualityManagementDetails extends QualityManagementEvent {
  final String qmId;
  final int initialIndex;

  FetchQualityManagementDetails(
      {required this.initialIndex, required this.qmId});
}

class FetchQualityManagementRoles extends QualityManagementEvent {}

class SelectQualityManagementRole extends QualityManagementEvent {
  final String roleId;

  SelectQualityManagementRole({required this.roleId});
}
