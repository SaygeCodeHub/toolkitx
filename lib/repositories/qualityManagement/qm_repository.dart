import 'package:toolkit/data/models/qualityManagement/fetch_custom_fields_by_key.dart';

import '../../data/models/incident/save_incident_comments_files_model.dart';
import '../../data/models/incident/save_incident_comments_model.dart';
import '../../data/models/pdf_generation_model.dart';
import '../../data/models/qualityManagement/fetch_qm_classification_model.dart';
import '../../data/models/qualityManagement/fetch_qm_details_model.dart';
import '../../data/models/qualityManagement/fetch_qm_list_model.dart';
import '../../data/models/qualityManagement/fetch_qm_master_model.dart';
import '../../data/models/qualityManagement/fetch_qm_roles_model.dart';
import '../../data/models/qualityManagement/save_new_qm_reporting_model.dart';
import '../../data/models/qualityManagement/save_qm_photos_model.dart';
import '../../data/models/qualityManagement/update_quality_management_details_model.dart';

abstract class QualityManagementRepository {
  Future<FetchQualityManagementListModel> fetchQualityManagementList(
      int pageNo, String userId, String hashCode, String filter, String role);

  Future<FetchQualityManagementDetailsModel> fetchQualityManagementDetails(
      String qmId, String hashCode, String userId, String role);

  Future<SaveIncidentAndQMCommentsModel> saveComments(Map saveCommentsMap);

  Future<SaveIncidentAndQMCommentsFilesModel> saveCommentsFile(
      Map saveCommentsFilesMap);

  Future<PdfGenerationModel> generatePdf(String qmId, String hashCode);

  Future<FetchQualityManagementMasterModel> fetchQualityManagementMaster(
      String hashCode, String role);

  Future<SaveNewQualityManagementReportingModel> saveNewQMReporting(
      Map saveQMMap);

  Future<SaveQualityManagementPhotos> saveQualityManagementPhotos(
      Map savePhotosMap);

  Future<UpdateQualityManagementDetailsModel> updateQualityManagementDetails(
      Map updateDetailsMap);

  Future<FetchQualityManagementClassificationModel> fetchClassification(
      String hashCode);

  Future<FetchQualityManagementRolesModel> fetchQualityManagementRoles(
      String hashCode, String userId);

  Future<FetchCustomFieldsByKeyModel> fetchCustomFieldsByKey(
      String moduleName, String categoryId, String hashCode);
}
