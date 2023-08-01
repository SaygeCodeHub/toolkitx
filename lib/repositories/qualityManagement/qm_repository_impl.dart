import 'package:toolkit/data/models/qualityManagement/fetch_qm_details_model.dart';
import 'package:toolkit/data/models/qualityManagement/fetch_qm_list_model.dart';
import 'package:toolkit/data/models/qualityManagement/fetch_qm_master_model.dart';
import 'package:toolkit/data/models/qualityManagement/save_new_qm_reporting_model.dart';
import 'package:toolkit/data/models/qualityManagement/save_qm_photos_model.dart';

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
  Future<FetchQualityManagementMasterModel> fetchQualityManagementMaster(
      String hashCode, String role) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}qaincident/getmaster?hashcode=$hashCode&role=$role");
    return FetchQualityManagementMasterModel.fromJson(response);
  }

  @override
  Future<SaveNewQualityManagementReportingModel> saveNewQMReporting(
      Map saveQMMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}qaincident/save", saveQMMap);
    return SaveNewQualityManagementReportingModel.fromJson(response);
  }

  @override
  Future<SaveQualityManagementPhotos> saveQualityManagementPhotos(
      Map savePhotosMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}qaincident/savefiles", savePhotosMap);
    return SaveQualityManagementPhotos.fromJson(response);
  }
}
