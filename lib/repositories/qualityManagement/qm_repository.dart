import '../../data/models/incident/save_incident_comments_files_model.dart';
import '../../data/models/incident/save_incident_comments_model.dart';
import '../../data/models/pdf_generation_model.dart';
import '../../data/models/qualityManagement/fetch_qm_classification_model.dart';
import '../../data/models/qualityManagement/fetch_qm_details_model.dart';
import '../../data/models/qualityManagement/fetch_qm_list_model.dart';

abstract class QualityManagementRepository {
  Future<FetchQualityManagementListModel> fetchQualityManagementList(
      int pageNo, String userId, String hashCode, String filter, String role);

  Future<FetchQualityManagementDetailsModel> fetchQualityManagementDetails(
      String qmId, String hashCode, String userId, String role);

  Future<SaveIncidentAndQMCommentsModel> saveComments(Map saveCommentsMap);

  Future<SaveIncidentAndQMCommentsFilesModel> saveCommentsFile(
      Map saveCommentsFilesMap);

  Future<PdfGenerationModel> generatePdf(String qmId, String hashCode);

  Future<FetchQualityManagementClassificationModel> fetchClassification(
      String hashCode);
}
