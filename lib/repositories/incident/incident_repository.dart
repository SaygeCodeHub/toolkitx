import '../../data/models/incident/fetch_incident_master_model.dart';
import '../../data/models/incident/fetch_incidents_list_model.dart';
import '../../data/models/incident/incident_details_model.dart';
import '../../data/models/incident/incident_fetch_roles_model.dart';
import '../../data/models/incident/incident_unlink_permit_model.dart';
import '../../data/models/incident/save_report_new_incident_model.dart';
import '../../data/models/incident/save_report_new_incident_photos_model.dart';

abstract class IncidentRepository {
  Future<FetchIncidentsListModel> fetchIncidents(
      String userId, String hashCode, String filter, String role);

  Future<IncidentFetchRolesModel> fetchIncidentRole(
      String hashCode, String userId);

  Future<IncidentDetailsModel> fetchIncidentDetails(
      String incidentId, String hashCode, String userId, String role);

  Future<IncidentUnlinkPermitModel> removeLinkedPermit(
      Map removeLinkedPermitMap);

  Future<FetchIncidentMasterModel> fetchIncidentMaster(
      String hashCode, String role);

  Future<SaveReportNewIncidentModel> saveIncident(Map reportNewIncidentMap);

  Future<SaveReportNewIncidentPhotosModel> saveIncidentPhotos(
      Map saveIncidentPhotosMap);
}
