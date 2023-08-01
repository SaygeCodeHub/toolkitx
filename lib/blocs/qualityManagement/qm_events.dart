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

class ReportNewQAAnonymously extends QualityManagementEvent {
  final String anonymousId;

  ReportNewQAAnonymously({required this.anonymousId});
}

class FetchQualityManagementMaster extends QualityManagementEvent {}

class ReportNewQualityManagementContractorListChange
    extends QualityManagementEvent {
  final String selectContractorId;
  final String selectContractorName;

  ReportNewQualityManagementContractorListChange(
      {required this.selectContractorName, required this.selectContractorId});
}

class ReportNewQualityManagementDateTimeDescriptionValidation
    extends QualityManagementEvent {
  final Map reportNewQAMap;

  ReportNewQualityManagementDateTimeDescriptionValidation(
      {required this.reportNewQAMap});
}

class ReportQualityManagementSiteListChange extends QualityManagementEvent {
  final String selectSiteName;

  ReportQualityManagementSiteListChange({required this.selectSiteName});
}

class ReportNewQualityManagementLocationChange extends QualityManagementEvent {
  final String selectLocationName;

  ReportNewQualityManagementLocationChange({required this.selectLocationName});
}

class ReportNewQualityManagementSeverityChange extends QualityManagementEvent {
  final String severityId;

  ReportNewQualityManagementSeverityChange({required this.severityId});
}

class ReportNewQualityManagementImpactChange extends QualityManagementEvent {
  final String impactId;

  ReportNewQualityManagementImpactChange({required this.impactId});
}

class ReportNewQualityManagementSiteLocationValidation
    extends QualityManagementEvent {
  final Map reportNewQAMap;

  ReportNewQualityManagementSiteLocationValidation(
      {required this.reportNewQAMap});
}

class ReportNewQualityManagementFetchCustomInfoField
    extends QualityManagementEvent {
  ReportNewQualityManagementFetchCustomInfoField();
}

class ReportNewQualityManagementCustomInfoFiledExpansionChange
    extends QualityManagementEvent {
  final String? reportQMCustomInfoOptionId;

  ReportNewQualityManagementCustomInfoFiledExpansionChange(
      {required this.reportQMCustomInfoOptionId});
}

class SaveReportNewQualityManagement extends QualityManagementEvent {
  final Map reportNewQAMap;
  final String role;

  SaveReportNewQualityManagement(
      {required this.role, required this.reportNewQAMap});
}

class SaveReportNewQualityManagementPhotos extends QualityManagementEvent {
  final Map reportNewQAMap;

  SaveReportNewQualityManagementPhotos({required this.reportNewQAMap});
}
