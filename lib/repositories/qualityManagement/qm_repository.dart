import '../../data/models/qualityManagement/fetch_qm_details_model.dart';
import '../../data/models/qualityManagement/fetch_qm_list_model.dart';
import '../../data/models/qualityManagement/fetch_qm_master_model.dart';
import '../../data/models/qualityManagement/save_new_qm_reporting_model.dart';
import '../../data/models/qualityManagement/save_qm_photos_model.dart';

abstract class QualityManagementRepository {
  Future<FetchQualityManagementListModel> fetchQualityManagementList(
      int pageNo, String userId, String hashCode, String filter, String role);

  Future<FetchQualityManagementDetailsModel> fetchQualityManagementDetails(
      String qmId, String hashCode, String userId, String role);

  Future<FetchQualityManagementMasterModel> fetchQualityManagementMaster(
      String hashCode, String role);

  Future<SaveNewQualityManagementReportingModel> saveNewQMReporting(
      Map saveQMMap);

  Future<SaveQualityManagementPhotos> saveQualityManagementPhotos(
      Map savePhotosMap);
}
