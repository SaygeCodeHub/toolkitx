import 'package:toolkit/data/models/documents/document_master_model.dart';
import 'package:toolkit/data/models/documents/document_roles_model.dart';
import 'package:toolkit/data/models/documents/documents_list_model.dart';
import 'package:toolkit/data/models/documents/save_document_comments_model.dart';

import '../../data/models/documents/document_upload_file_version_model.dart';
import '../../data/models/documents/documents_details_models.dart';
import '../../data/models/documents/documents_to_link_model.dart';
import '../../data/models/documents/post_document_model.dart';

abstract class DocumentsRepository {
  Future<DocumentsListModel> getDocumentsList(
      String userId, String hashCode, String filter, String role, int page);

  Future<DocumentRolesModel> getDocumentsRoles(String userId, String hashCode);

  Future<FetchDocumentMasterModel> fetchDocumentMaster(
      String userId, String hashCode);

  Future<DocumentDetailsModel> getDocumentsDetails(
      String userId, String hashCode, String roleId, String documentId);

  Future<DocumentsToLinkModel> getDocumentsToLink(
      String filter, String hashCode, String documentId, int pageNo);

  Future<PostDocumentsModel> saveLinkedDocuments(Map saveLinkedDocumentsMap);

  Future<PostDocumentsModel> attachDocuments(Map attachDocumentsMap);

  Future<DocumentUploadFileVersionModel> documentUploadFileVersion(
      Map uploadFileVersionMap);

  Future<PostDocumentsModel> deleteDocuments(Map deleteDocumentsMap);

  Future<PostDocumentsModel> approveDocuments(Map approveDocumentsMap);

  Future<PostDocumentsModel> rejectDocuments(Map rejectDocumentsMap);

  Future<PostDocumentsModel> withdrawDocuments(Map withdrawDocumentsMap);

  Future<PostDocumentsModel> closeDocuments(Map closeDocumentsMsp);

  Future<SaveDocumentCommentsModel> saveDocumentComments(
      Map saveDocumentCommentsMap);

  Future<PostDocumentsModel> openDocumentFopInformation(
      Map openDocumentFopInformationMap);

  Future<PostDocumentsModel> openDocumentFopReview(
      Map openDocumentFopReviewMap);
}
