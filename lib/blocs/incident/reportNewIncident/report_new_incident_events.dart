import '../../../data/models/incident/fetch_incident_location_model.dart';

abstract class ReportNewIncidentEvent {}

class FetchIncidentMaster extends ReportNewIncidentEvent {
  final String role;
  final String categories;

  FetchIncidentMaster({required this.categories, required this.role});
}

class SelectIncidentCategory extends ReportNewIncidentEvent {
  final String selectedCategory;
  final List multiSelectList;

  SelectIncidentCategory(
      {required this.selectedCategory, required this.multiSelectList});
}

class ReportNewIncidentAnonymousExpansionChange extends ReportNewIncidentEvent {
  final String reportIncidentAnonymousId;

  ReportNewIncidentAnonymousExpansionChange(
      {required this.reportIncidentAnonymousId});
}

class ReportNewIncidentContractorListChange extends ReportNewIncidentEvent {
  final String selectContractorId;
  final String selectContractorName;

  ReportNewIncidentContractorListChange(
      {required this.selectContractorName, required this.selectContractorId});
}

class ReportNewIncidentLocationListChange extends ReportNewIncidentEvent {}

class ReportIncidentSiteListChange extends ReportNewIncidentEvent {
  final String selectSiteName;
  final int siteId;

  ReportIncidentSiteListChange({required this.selectSiteName,required this.siteId});
}

class ReportNewIncidentLocationChange extends ReportNewIncidentEvent {
  final String selectLocationName;

  ReportNewIncidentLocationChange({required this.selectLocationName});
}

class ReportNewIncidentAuthorityExpansionChange extends ReportNewIncidentEvent {
  final String reportIncidentAuthorityId;

  ReportNewIncidentAuthorityExpansionChange(
      {required this.reportIncidentAuthorityId});
}

class ReportNewIncidentDateTimeDescriptionValidation
    extends ReportNewIncidentEvent {
  final Map reportNewIncidentMap;

  ReportNewIncidentDateTimeDescriptionValidation(
      {required this.reportNewIncidentMap});
}

class ReportNewIncidentSiteLocationValidation extends ReportNewIncidentEvent {
  final Map reportNewIncidentMap;

  ReportNewIncidentSiteLocationValidation({required this.reportNewIncidentMap});
}

class ReportNewIncidentCustomInfoFieldFetch extends ReportNewIncidentEvent {
  ReportNewIncidentCustomInfoFieldFetch();
}

class ReportNewIncidentCustomInfoFiledExpansionChange
    extends ReportNewIncidentEvent {
  final String? reportIncidentCustomInfoOptionId;

  ReportNewIncidentCustomInfoFiledExpansionChange(
      {required this.reportIncidentCustomInfoOptionId});
}

class SaveReportNewIncident extends ReportNewIncidentEvent {
  final Map reportNewIncidentMap;
  final String role;

  SaveReportNewIncident(
      {required this.role, required this.reportNewIncidentMap});
}

class SaveReportNewIncidentPhotos extends ReportNewIncidentEvent {
  final Map reportNewIncidentMap;

  SaveReportNewIncidentPhotos({required this.reportNewIncidentMap});
}

class FetchIncidentInjuredPerson extends ReportNewIncidentEvent {
  final List injuredPersonDetailsList;

  FetchIncidentInjuredPerson({required this.injuredPersonDetailsList});
}

class IncidentRemoveInjuredPersonDetails extends ReportNewIncidentEvent {
  final List injuredPersonDetailsList;
  final int? index;

  IncidentRemoveInjuredPersonDetails(
      {this.index, required this.injuredPersonDetailsList});
}

class FetchIncidentLocations extends ReportNewIncidentEvent {
  final int siteId;

  FetchIncidentLocations({required this.siteId});
}

class SelectLocationId extends ReportNewIncidentEvent {
  final dynamic locationId;

  SelectLocationId({required this.locationId});
}

class FetchIncidentAssetsList extends ReportNewIncidentEvent {
  final List<Asset> assetList;

  FetchIncidentAssetsList({required this.assetList});
}
