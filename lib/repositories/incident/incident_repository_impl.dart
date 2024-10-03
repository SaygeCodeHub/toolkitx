import 'dart:convert';

import 'package:toolkit/data/models/incident/edit_incident_details_model.dart';
import 'package:toolkit/data/models/incident/fetch_incident_location_model.dart';

import 'package:toolkit/data/models/incident/save_incident_comments_files_model.dart';
import 'package:toolkit/data/models/incident/save_incident_comments_model.dart';

import '../../../utils/constants/api_constants.dart';
import '../../../utils/dio_client.dart';
import '../../data/models/incident/fetch_incidents_list_model.dart';
import '../../data/models/incident/fetch_permit_to_link_model.dart';
import '../../data/models/incident/incident_details_model.dart';
import '../../data/models/incident/fetch_incident_master_model.dart';
import '../../data/models/incident/incident_fetch_roles_model.dart';
import '../../data/models/incident/incident_injury_master.dart';
import '../../data/models/incident/incident_unlink_permit_model.dart';
import '../../data/models/incident/save_report_new_incident_model.dart';
import '../../data/models/incident/save_report_new_incident_photos_model.dart';
import '../../data/models/incident/save_injured_person_model.dart';
import '../../data/models/pdf_generation_model.dart';
import '../../data/models/incident/saved_linked_permit_model.dart';
import 'incident_repository.dart';

class IncidentRepositoryImpl extends IncidentRepository {
  @override
  Future<IncidentFetchRolesModel> fetchIncidentRole(
      String hashCode, String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}incident/getroles?hashcode=$hashCode&userid=$userId");
    return IncidentFetchRolesModel.fromJson(response);
  }

  @override
  Future<FetchIncidentsListModel> fetchIncidents(String userId, String hashCode,
      String filter, String role, int page) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}incident/get?pageno=$page&userid=$userId&hashcode=$hashCode&filter=$filter&role=$role");
    return FetchIncidentsListModel.fromJson(response);
  }

  @override
  Future<IncidentInjuryMasterModel> fetchInjuryMaster(String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}incident/getinjuredpersonmaster?hashcode=$hashCode");
    return IncidentInjuryMasterModel.fromJson(response);
  }

  @override
  Future<IncidentDetailsModel> fetchIncidentDetails(
      String incidentId, String hashCode, String userId, String role) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}incident/getincident1?incidentid=$incidentId&hashcode=$hashCode&userid=$userId&role=$role");
    return IncidentDetailsModel.fromJson(response);
  }

  @override
  Future<IncidentUnlinkPermitModel> removeLinkedPermit(
      Map removeLinkedPermitMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}incident/unlinkpermit", removeLinkedPermitMap);
    return IncidentUnlinkPermitModel.fromJson(response);
  }

  @override
  Future<FetchIncidentMasterModel> fetchIncidentMaster(
      String hashCode, String role) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}incident/getmaster?hashcode=$hashCode&role=$role");
    return FetchIncidentMasterModel.fromJson(response);
  }

  @override
  Future<SaveReportNewIncidentModel> saveIncident(
      Map reportNewIncidentMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}incident/save", reportNewIncidentMap);
    return SaveReportNewIncidentModel.fromJson(response);
  }

  @override
  Future<SaveReportNewIncidentPhotosModel> saveIncidentPhotos(
      Map saveIncidentPhotosMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}incident/savefiles", saveIncidentPhotosMap);
    return SaveReportNewIncidentPhotosModel.fromJson(response);
  }

  @override
  Future<SaveInjuredPersonModel> saveInjuredPerson(Map injuredPersonMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}incident/saveinjuredperson", injuredPersonMap);
    return SaveInjuredPersonModel.fromJson(response);
  }

  @override
  Future<FetchPermitToLinkModel> fetchPermitToLink(
      int pageNo, String hashCode, String filter, String incidentId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}/incident/getpermitstolink?pageno=$pageNo&hashcode=$hashCode&filter=$filter&incidentid=$incidentId");
    return FetchPermitToLinkModel.fromJson(response);
  }

  @override
  Future<SaveLinkedPermitModel> saveLinkedPermit(Map linkedPermitMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}incident/savelinkedpermit", linkedPermitMap);
    return SaveLinkedPermitModel.fromJson(response);
  }

  @override
  Future<PdfGenerationModel> generatePdf(
      String hashCode, String incidentId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}incident/getpdf?incidentid=$incidentId&hashcode=$hashCode");
    return PdfGenerationModel.fromJson(response);
  }

  @override
  Future<EditIncidentDetailsModel> editIncidentDetails(
      Map editIncidentDetails) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}incident/update", editIncidentDetails);
    return EditIncidentDetailsModel.fromJson(response);
  }

  @override
  Future<SaveIncidentAndQMCommentsFilesModel> saveCommentsFiles(
      Map saveCommentsFilesMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}incident/savecommentsfiles",
        saveCommentsFilesMap);
    return SaveIncidentAndQMCommentsFilesModel.fromJson(response);
  }

  @override
  Future<SaveIncidentAndQMCommentsModel> saveComments(
      Map saveCommentsMap) async {
    print('incident impl ${jsonEncode(saveCommentsMap)}');
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}incident/savecomments", saveCommentsMap);
    return SaveIncidentAndQMCommentsModel.fromJson(response);
  }

  @override
  Future<FetchIncidentLocationModel> fetchIncidentLocation(
      String hashCode, int siteId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}incident/GetLocationBySite?hashcode=$hashCode&siteid=$siteId");
    return FetchIncidentLocationModel.fromJson(response);
  }
}
