import 'package:toolkit/data/models/documents/document_master_model.dart';
import 'package:toolkit/data/models/documents/document_roles_model.dart';
import 'package:toolkit/data/models/documents/documents_list_model.dart';

import '../../data/models/documents/documents_details_models.dart';

abstract class DocumentsRepository {
  Future<DocumentsListModel> getDocumentsList(
      String userId, String hashCode, String filter, String role, int page);

  Future<DocumentRolesModel> getDocumentsRoles(String userId, String hashCode);

  Future<FetchDocumentMasterModel> fetchDocumentMaster(
      String userId, String hashCode);

  Future<DocumentDetailsModel> getDocumentsDetails(
      String userId, String hashCode, String roleId, String documentId);
}
