import '../../../data/models/incident/fetch_incident_master_model.dart';
import '../../../data/models/incident/save_report_new_incident_model.dart';
import '../../../data/models/incident/save_report_new_incident_photos_model.dart';

abstract class ReportNewIncidentStates {}

class ReportNewIncidentInitial extends ReportNewIncidentStates {}

class FetchingIncidentMaster extends ReportNewIncidentStates {}

class IncidentMasterFetched extends ReportNewIncidentStates {
  final FetchIncidentMasterModel fetchIncidentMasterModel;
  final List categoryList;
  final List categorySelectedList;

  IncidentMasterFetched(
      {required this.categorySelectedList,
      required this.categoryList,
      required this.fetchIncidentMasterModel});
}

class IncidentMasterNotFetched extends ReportNewIncidentStates {}

class ReportNewIncidentAnonymousSelected extends ReportNewIncidentStates {
  final Map reportAnonymousMap;
  final String reportAnonymousId;

  ReportNewIncidentAnonymousSelected(
      {required this.reportAnonymousId, required this.reportAnonymousMap});
}

class ReportNewIncidentContractorSelected extends ReportNewIncidentStates {
  final FetchIncidentMasterModel fetchIncidentMasterModel;
  final String selectContractorId;
  final String selectContractorName;

  ReportNewIncidentContractorSelected(
      {required this.fetchIncidentMasterModel,
      required this.selectContractorId,
      required this.selectContractorName});
}

class ReportNewIncidentSiteSelected extends ReportNewIncidentStates {
  final FetchIncidentMasterModel fetchIncidentMasterModel;
  final String selectSiteName;

  ReportNewIncidentSiteSelected(
      {required this.fetchIncidentMasterModel, required this.selectSiteName});
}

class ReportNewIncidentLocationSelected extends ReportNewIncidentStates {
  final FetchIncidentMasterModel fetchIncidentMasterModel;
  final String selectLocationName;

  ReportNewIncidentLocationSelected(
      {required this.fetchIncidentMasterModel,
      required this.selectLocationName});
}

class ReportNewIncidentAuthoritySelected extends ReportNewIncidentStates {
  final Map reportIncidentAuthorityMap;
  final String reportIncidentAuthorityId;

  ReportNewIncidentAuthoritySelected(
      {required this.reportIncidentAuthorityId,
      required this.reportIncidentAuthorityMap});
}

class ReportNewIncidentDateTimeDescValidated extends ReportNewIncidentStates {
  final String dateTimeDescValidationMessage;

  ReportNewIncidentDateTimeDescValidated(
      {required this.dateTimeDescValidationMessage});
}

class ReportNewIncidentDateTimeDescValidationComplete
    extends ReportNewIncidentStates {
  ReportNewIncidentDateTimeDescValidationComplete();
}

class ReportNewIncidentSiteLocationValidated extends ReportNewIncidentStates {
  final String siteLocationValidationMessage;

  ReportNewIncidentSiteLocationValidated(
      {required this.siteLocationValidationMessage});
}

class ReportNewIncidentSiteLocationValidationComplete
    extends ReportNewIncidentStates {
  ReportNewIncidentSiteLocationValidationComplete();
}

class ReportNewIncidentCustomFieldFetched extends ReportNewIncidentStates {
  final FetchIncidentMasterModel fetchIncidentMasterModel;

  ReportNewIncidentCustomFieldFetched({required this.fetchIncidentMasterModel});
}

class ReportNewIncidentCustomFieldSelected extends ReportNewIncidentStates {
  final FetchIncidentMasterModel fetchIncidentMasterModel;
  final String reportIncidentCustomInfoOptionId;

  ReportNewIncidentCustomFieldSelected(
      {required this.fetchIncidentMasterModel,
      required this.reportIncidentCustomInfoOptionId});
}

class ReportNewIncidentSaving extends ReportNewIncidentStates {}

class ReportNewIncidentSaved extends ReportNewIncidentStates {
  final SaveReportNewIncidentModel saveReportNewIncidentModel;

  ReportNewIncidentSaved({required this.saveReportNewIncidentModel});
}

class ReportNewIncidentNotSaved extends ReportNewIncidentStates {
  final String incidentNotSavedMessage;

  ReportNewIncidentNotSaved({required this.incidentNotSavedMessage});
}

class ReportNewIncidentPhotoSaved extends ReportNewIncidentStates {
  final SaveReportNewIncidentPhotosModel saveReportNewIncidentPhotosModel;

  ReportNewIncidentPhotoSaved({required this.saveReportNewIncidentPhotosModel});
}

class ReportNewIncidentInjuredPersonDetailsFetched
    extends ReportNewIncidentStates {
  final List injuredPersonDetailsList;

  ReportNewIncidentInjuredPersonDetailsFetched(
      {required this.injuredPersonDetailsList});
}
