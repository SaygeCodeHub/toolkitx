import '../../../data/models/incident/fetch_incident_master_model.dart';

abstract class ReportNewIncidentStates {}

class ReportNewIncidentInitial extends ReportNewIncidentStates {}

class FetchingIncidentMaster extends ReportNewIncidentStates {}

class IncidentMasterFetched extends ReportNewIncidentStates {
  final FetchIncidentMasterModel fetchIncidentMasterModel;
  final List categoryList;
  final List categorySelectedList;
  final Map addNewIncidentMap;

  IncidentMasterFetched(
      {required this.addNewIncidentMap,
      required this.categorySelectedList,
      required this.categoryList,
      required this.fetchIncidentMasterModel});
}

class IncidentMasterNotFetched extends ReportNewIncidentStates {}

class ReportNewIncidentPrimaryFetched extends ReportNewIncidentStates {
  ReportNewIncidentPrimaryFetched();
}

class IncidentReportAnonymousSelected extends ReportNewIncidentStates {
  final Map reportAnonymousMap;
  final String reportAnonymousId;

  IncidentReportAnonymousSelected(
      {required this.reportAnonymousId, required this.reportAnonymousMap});
}

class ReportIncidentContractorSelected extends ReportNewIncidentStates {
  final FetchIncidentMasterModel fetchIncidentMasterModel;
  final int selectContractorId;
  final String selectContractorName;

  ReportIncidentContractorSelected(
      {required this.fetchIncidentMasterModel,
      required this.selectContractorId,
      required this.selectContractorName});
}

class ReportIncidentSiteSelected extends ReportNewIncidentStates {
  final FetchIncidentMasterModel fetchIncidentMasterModel;
  final String selectSiteName;

  ReportIncidentSiteSelected(
      {required this.fetchIncidentMasterModel, required this.selectSiteName});
}

class ReportIncidentLocationSelected extends ReportNewIncidentStates {
  final FetchIncidentMasterModel fetchIncidentMasterModel;
  final String selectLocationName;

  ReportIncidentLocationSelected(
      {required this.fetchIncidentMasterModel,
      required this.selectLocationName});
}

class IncidentReportAuthoritySelected extends ReportNewIncidentStates {
  final Map reportAuthorityMap;
  final String reportAuthorityId;

  IncidentReportAuthoritySelected(
      {required this.reportAuthorityId, required this.reportAuthorityMap});
}
