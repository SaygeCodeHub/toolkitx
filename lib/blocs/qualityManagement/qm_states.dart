import '../../data/models/incident/save_incident_comments_files_model.dart';
import '../../data/models/incident/save_incident_comments_model.dart';
import '../../data/models/pdf_generation_model.dart';
import '../../data/models/qualityManagement/fetch_qm_classification_model.dart';
import '../../data/models/qualityManagement/fetch_qm_details_model.dart';
import '../../data/models/qualityManagement/fetch_qm_list_model.dart';
import '../../data/models/qualityManagement/fetch_qm_roles_model.dart';
import '../../data/models/qualityManagement/fetch_qm_master_model.dart';
import '../../data/models/qualityManagement/save_new_qm_reporting_model.dart';
import '../../data/models/qualityManagement/save_qm_photos_model.dart';

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
  final List qmPopUpMenu;
  final bool showPopUpMenu;

  QualityManagementDetailsFetched(
      {required this.qmPopUpMenu,
      required this.showPopUpMenu,
      required this.clientId,
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

class QualityManagementFilterStatusSelected extends QualityManagementStates {
  final List selectedStatusList;

  QualityManagementFilterStatusSelected({required this.selectedStatusList});
}

class QualityManagementSavingComments extends QualityManagementStates {}

class QualityManagementCommentsSaved extends QualityManagementStates {
  final SaveIncidentAndQMCommentsModel saveIncidentAndQMCommentsModel;
  final SaveIncidentAndQMCommentsFilesModel saveIncidentAndQMCommentsFilesModel;
  final String qmId;

  QualityManagementCommentsSaved(
      {required this.qmId,
      required this.saveIncidentAndQMCommentsModel,
      required this.saveIncidentAndQMCommentsFilesModel});
}

class QualityManagementCommentsNotSaved extends QualityManagementStates {
  final String commentsNotSaved;

  QualityManagementCommentsNotSaved({required this.commentsNotSaved});
}

class GeneratingQualityManagementPDF extends QualityManagementStates {
  GeneratingQualityManagementPDF();
}

class QualityManagementPDFGenerated extends QualityManagementStates {
  final PdfGenerationModel? pdfGenerationModel;
  final String pdfLink;

  QualityManagementPDFGenerated(
      {this.pdfGenerationModel, required this.pdfLink});
}

class QualityManagementPDFGenerationFailed extends QualityManagementStates {
  final String pdfNoteGenerated;

  QualityManagementPDFGenerationFailed({required this.pdfNoteGenerated});
}

class FetchingQualityManagementClassificationValue
    extends QualityManagementStates {}

class QualityManagementClassificationValueFetched
    extends QualityManagementStates {
  final FetchQualityManagementClassificationModel
      fetchQualityManagementClassificationModel;
  final String classificationId;

  QualityManagementClassificationValueFetched(
      {required this.classificationId,
      required this.fetchQualityManagementClassificationModel});
}

class QualityManagementClassificationValueNotFetched
    extends QualityManagementStates {
  final String classificationNotFetched;

  QualityManagementClassificationValueNotFetched(
      {required this.classificationNotFetched});
}

class FetchingQualityManagementMaster extends QualityManagementStates {}

class QualityManagementMasterFetched extends QualityManagementStates {
  final FetchQualityManagementMasterModel fetchQualityManagementMasterModel;

  QualityManagementMasterFetched(
      {required this.fetchQualityManagementMasterModel});
}

class QualityManagementMasterNotFetched extends QualityManagementStates {
  final String masterNotFetched;

  QualityManagementMasterNotFetched({required this.masterNotFetched});
}

class ReportedNewQAAnonymously extends QualityManagementStates {
  final String anonymousId;

  ReportedNewQAAnonymously({required this.anonymousId});
}

class ReportNewQualityManagementContractorSelected
    extends QualityManagementStates {
  final FetchQualityManagementMasterModel fetchQualityManagementMasterModel;
  final String selectContractorId;
  final String selectContractorName;

  ReportNewQualityManagementContractorSelected(
      {required this.fetchQualityManagementMasterModel,
      required this.selectContractorId,
      required this.selectContractorName});
}

class ReportNewQualityManagementDateTimeDescValidated
    extends QualityManagementStates {
  final String dateTimeDescValidationMessage;

  ReportNewQualityManagementDateTimeDescValidated(
      {required this.dateTimeDescValidationMessage});
}

class ReportNewQualityManagementDateTimeDescValidationComplete
    extends QualityManagementStates {
  ReportNewQualityManagementDateTimeDescValidationComplete();
}

class ReportNewQualityManagementSiteSelected extends QualityManagementStates {
  final FetchQualityManagementMasterModel fetchQualityManagementMasterModel;
  final String selectSiteName;

  ReportNewQualityManagementSiteSelected(
      {required this.fetchQualityManagementMasterModel,
      required this.selectSiteName});
}

class ReportNewQualityManagementLocationSelected
    extends QualityManagementStates {
  final FetchQualityManagementMasterModel fetchQualityManagementMasterModel;
  final String selectLocationName;

  ReportNewQualityManagementLocationSelected(
      {required this.fetchQualityManagementMasterModel,
      required this.selectLocationName});
}

class ReportNewQualityManagementSeveritySelected
    extends QualityManagementStates {
  final FetchQualityManagementMasterModel fetchQualityManagementMasterModel;
  final String severityId;

  ReportNewQualityManagementSeveritySelected(
      {required this.severityId,
      required this.fetchQualityManagementMasterModel});
}

class ReportNewQualityManagementImpactSelected extends QualityManagementStates {
  final FetchQualityManagementMasterModel fetchQualityManagementMasterModel;
  final String impactId;

  ReportNewQualityManagementImpactSelected(
      {required this.impactId,
      required this.fetchQualityManagementMasterModel});
}

class ReportNewQualityManagementSiteLocationValidated
    extends QualityManagementStates {
  final String siteLocationValidationMessage;

  ReportNewQualityManagementSiteLocationValidated(
      {required this.siteLocationValidationMessage});
}

class ReportNewQualityManagementSiteLocationValidationComplete
    extends QualityManagementStates {
  ReportNewQualityManagementSiteLocationValidationComplete();
}

class ReportNewQualityManagementCustomFieldFetched
    extends QualityManagementStates {
  final FetchQualityManagementMasterModel fetchQualityManagementMasterModel;

  ReportNewQualityManagementCustomFieldFetched(
      {required this.fetchQualityManagementMasterModel});
}

class ReportNewQualityManagementCustomFieldSelected
    extends QualityManagementStates {
  final FetchQualityManagementMasterModel fetchQualityManagementMasterModel;
  final String reportQMCustomInfoOptionId;

  ReportNewQualityManagementCustomFieldSelected(
      {required this.fetchQualityManagementMasterModel,
      required this.reportQMCustomInfoOptionId});
}

class ReportNewQualityManagementSaving extends QualityManagementStates {}

class ReportNewQualityManagementSaved extends QualityManagementStates {
  final SaveNewQualityManagementReportingModel
      saveNewQualityManagementReporting;

  ReportNewQualityManagementSaved(
      {required this.saveNewQualityManagementReporting});
}

class ReportNewQualityManagementNotSaved extends QualityManagementStates {
  final String qualityManagementNotSavedMessage;

  ReportNewQualityManagementNotSaved(
      {required this.qualityManagementNotSavedMessage});
}

class ReportNewQualityManagementPhotoSaved extends QualityManagementStates {
  final SaveQualityManagementPhotos saveQualityManagementPhotos;

  ReportNewQualityManagementPhotoSaved(
      {required this.saveQualityManagementPhotos});
}
