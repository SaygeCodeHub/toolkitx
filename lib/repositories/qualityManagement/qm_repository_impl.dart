import 'package:toolkit/data/models/qualityManagement/fetch_qm_details_model.dart';
import 'package:toolkit/data/models/qualityManagement/fetch_qm_list_model.dart';
import 'package:toolkit/data/models/qualityManagement/fetch_qm_roles_model.dart';

import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';
import 'qm_repository.dart';

class QualityManagementRepositoryImpl extends QualityManagementRepository {
  @override
  Future<FetchQualityManagementListModel> fetchQualityManagementList(int pageNo,
      String userId, String hashCode, String filter, String role) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}qaincident/get?pageno=$pageNo&userid=$userId&hashcode=$hashCode&filter=$filter&role=$role");
    return FetchQualityManagementListModel.fromJson(response);
  }

  @override
  Future<FetchQualityManagementDetailsModel> fetchQualityManagementDetails(
      String qmId, String hashCode, String userId, String role) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}qaincident/getincident?incidentid=$qmId&hashcode=$hashCode&userid=$userId&role=$role");
    return FetchQualityManagementDetailsModel.fromJson(response);
  }

  @override
  Future<FetchQualityManagementRolesModel> fetchQualityManagementRoles(
      String hashCode, String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}qaincident/getroles?hashcode=$hashCode&userid=$userId");
    return FetchQualityManagementRolesModel.fromJson(response);
  }
}
