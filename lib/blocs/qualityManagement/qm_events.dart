import '../../data/models/incident/save_incident_comments_model.dart';
import '../../data/models/qualityManagement/fetch_qm_classification_model.dart';

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

class ReportNewQAAnonymously extends QualityManagementEvent {
  final String anonymousId;

  ReportNewQAAnonymously({required this.anonymousId});
}

class FetchQualityManagementMaster extends QualityManagementEvent {
  final Map reportNewQAMap;

  FetchQualityManagementMaster({required this.reportNewQAMap});
}

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

class SelectQualityManagementClassification extends QualityManagementEvent {
  final String classificationId;
  final FetchQualityManagementClassificationModel
      fetchQualityManagementClassificationModel;

  SelectQualityManagementClassification(
      {required this.fetchQualityManagementClassificationModel,
      required this.classificationId});
}

class SaveQualityManagementComments extends QualityManagementEvent {
  final Map saveCommentsMap;

  SaveQualityManagementComments({required this.saveCommentsMap});
}

class SaveQualityManagementCommentsFiles extends QualityManagementEvent {
  final Map saveCommentsMap;
  final SaveIncidentAndQMCommentsModel saveIncidentAndQMCommentsModel;

  SaveQualityManagementCommentsFiles(
      {required this.saveIncidentAndQMCommentsModel,
      required this.saveCommentsMap});
}

class GenerateQualityManagementPDF extends QualityManagementEvent {
  GenerateQualityManagementPDF();
}

class UpdateQualityManagementDetails extends QualityManagementEvent {
  final Map editQMDetailsMap;

  UpdateQualityManagementDetails({required this.editQMDetailsMap});
}

class FetchQualityManagementRoles extends QualityManagementEvent {}

class SelectQualityManagementRole extends QualityManagementEvent {
  final String roleId;

  SelectQualityManagementRole({required this.roleId});
}

class SelectQualityManagementStatusFilter extends QualityManagementEvent {
  final List statusList;
  final String statusId;

  SelectQualityManagementStatusFilter(
      {required this.statusList, required this.statusId});
}

class QualityManagementApplyFilter extends QualityManagementEvent {
  final Map filtersMap;

  QualityManagementApplyFilter({required this.filtersMap});
}

class QualityManagementClearFilter extends QualityManagementEvent {}

class FetchQualityManagementClassificationValue
    extends QualityManagementEvent {}
