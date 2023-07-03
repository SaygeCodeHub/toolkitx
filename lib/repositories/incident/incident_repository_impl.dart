import 'package:toolkit/data/models/incident/fetch_incidents_list_model.dart';

import '../../../utils/constants/api_constants.dart';
import '../../../utils/dio_client.dart';
import '../../data/models/incident/fetch_incident_master_model.dart';
import '../../data/models/incident/incident_fetch_roles_model.dart';
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
  Future<FetchIncidentsListModel> fetchIncidents(
      String userId, String hashCode, String filter, String role) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}incident/get?pageno=1&userid=$userId&hashcode=$hashCode&filter=$filter&role=$role");
    return FetchIncidentsListModel.fromJson(response);
  }

  @override
  Future<FetchIncidentMasterModel> fetchIncidentMaster(
      String hashCode, String role) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}incident/getmaster?hashcode=$hashCode&role=$role");
    return FetchIncidentMasterModel.fromJson(response);
  }
}
