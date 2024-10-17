import '../../data/models/incident/edit_incident_details_model.dart';
import '../../data/models/incident/fetch_incident_location_model.dart';
import '../../data/models/incident/fetch_incident_master_model.dart';
import '../../data/models/incident/fetch_incidents_list_model.dart';
import '../../data/models/incident/fetch_permit_to_link_model.dart';
import '../../data/models/incident/incident_details_model.dart';
import '../../data/models/incident/incident_fetch_roles_model.dart';
import '../../data/models/incident/incident_injury_master.dart';
import '../../data/models/incident/incident_unlink_permit_model.dart';
import '../../data/models/incident/save_incident_comments_files_model.dart';
import '../../data/models/incident/save_incident_comments_model.dart';
import '../../data/models/incident/save_injured_person_model.dart';
import '../../data/models/incident/save_report_new_incident_model.dart';
import '../../data/models/incident/save_report_new_incident_photos_model.dart';
import '../../data/models/incident/saved_linked_permit_model.dart';
import '../../data/models/pdf_generation_model.dart';

abstract class IncidentRepository {
  Future<FetchIncidentsListModel> fetchIncidents(
      String userId, String hashCode, String filter, String role, int page);

  Future<IncidentInjuryMasterModel> fetchInjuryMaster(String hashCode);

  Future<SaveInjuredPersonModel> saveInjuredPerson(Map injuredPersonMap);

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

  Future<PdfGenerationModel> generatePdf(String hashCode, String incidentId);

  Future<FetchPermitToLinkModel> fetchPermitToLink(
      int pageNo, String hashCode, String filter, String incidentId);

  Future<SaveLinkedPermitModel> saveLinkedPermit(Map linkedPermitMap);

  Future<EditIncidentDetailsModel> editIncidentDetails(Map editIncidentDetails);

  Future<SaveIncidentAndQMCommentsModel> saveComments(Map saveCommentsMap);

  Future<SaveIncidentAndQMCommentsFilesModel> saveCommentsFiles(
      Map saveCommentsFilesMap);

  Future<FetchIncidentLocationModel> fetchIncidentLocation(
      String hashCode, int siteId);
}
