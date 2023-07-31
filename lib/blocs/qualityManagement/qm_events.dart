abstract class QualityManagementEvent {}

class FetchQualityManagementList extends QualityManagementEvent {
  final int pageNo;
  final bool isFromHome;

  FetchQualityManagementList({required this.isFromHome, required this.pageNo});
}

class FetchQualityManagementDetails extends QualityManagementEvent {
  final String qmId;
  final int initialIndex;

  FetchQualityManagementDetails(
      {required this.initialIndex, required this.qmId});
}

class QualityManagementApplyFilter extends QualityManagementEvent {
  final Map filtersMap;

  QualityManagementApplyFilter({required this.filtersMap});
}

class QualityManagementClearFilter extends QualityManagementEvent {}
