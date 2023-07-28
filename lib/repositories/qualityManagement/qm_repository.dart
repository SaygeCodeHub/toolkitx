import '../../data/models/qualityManagement/fetch_qm_list_model.dart';

abstract class QualityManagementRepository {
  Future<FetchQualityManagementListModel> fetchQualityManagementList(
      int pageNo, String userId, String hashCode, String filter, String role);
}
