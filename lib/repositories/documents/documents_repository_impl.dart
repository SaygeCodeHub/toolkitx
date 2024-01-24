import 'package:toolkit/data/models/documents/document_upload_file_version_model.dart';

import '../../data/models/documents/document_master_model.dart';
import '../../data/models/documents/document_roles_model.dart';
import '../../data/models/documents/documents_details_models.dart';
import '../../data/models/documents/documents_list_model.dart';
import '../../data/models/documents/documents_to_link_model.dart';
import '../../data/models/documents/post_document_model.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';
import 'documents_repository.dart';

class DocumentsRepositoryImpl extends DocumentsRepository {
  @override
  Future<DocumentsListModel> getDocumentsList(String userId, String hashCode,
      String filter, String role, int page) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}document/get?pageno=$page&hashcode=$hashCode&userid=$userId&filter=$filter");
    return DocumentsListModel.fromJson(response);
  }

  @override
  Future<DocumentRolesModel> getDocumentsRoles(
      String userId, String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}document/getroles?hashcode=$hashCode&userid=$userId");
    return DocumentRolesModel.fromJson(response);
  }

  @override
  Future<FetchDocumentMasterModel> fetchDocumentMaster(
      String userId, String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}document/getmaster?hashcode=$hashCode&userid=$userId");
    return FetchDocumentMasterModel.fromJson(response);
  }

  @override
  Future<DocumentDetailsModel> getDocumentsDetails(
      String userId, String hashCode, String roleId, String documentId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}document/getdocument?hashcode=$hashCode&documentid=$documentId&role=$roleId&userid=$userId");
    return DocumentDetailsModel.fromJson(response);
  }

  @override
  Future<DocumentsToLinkModel> getDocumentsToLink(
      String filter, String hashCode, String documentId, int pageNo) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}document/getdocumentstolink?pageno=$pageNo&hashcode=$hashCode&documentid=$documentId&filter=$filter");
    return DocumentsToLinkModel.fromJson(response);
  }

  @override
  Future<PostDocumentsModel> saveLinkedDocuments(
      Map saveLinkedDocumentsMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}document/savelinkeddocuments",
        saveLinkedDocumentsMap);
    return PostDocumentsModel.fromJson(response);
  }

  @override
  Future<PostDocumentsModel> attachDocuments(Map attachDocumentsMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}document/attachfiles", attachDocumentsMap);
    return PostDocumentsModel.fromJson(response);
  }

  @override
  Future<DocumentUploadFileVersionModel> documentUploadFileVersion(Map uploadFileVersionMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}document/uploadfileversion", uploadFileVersionMap);
    return DocumentUploadFileVersionModel.fromJson(response);
  }

  @override
  Future<PostDocumentsModel> deleteDocuments(Map deleteDocumentsMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}document/deletedocumentfile",
        deleteDocumentsMap);
    return PostDocumentsModel.fromJson(response);
  }

  @override
  Future<PostDocumentsModel> approveDocuments(Map approveDocumentsMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}document/approvedocument", approveDocumentsMap);
    return PostDocumentsModel.fromJson(response);
  }

  @override
  Future<PostDocumentsModel> closeDocuments(Map closeDocumentsMsp) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}document/closedocument", closeDocumentsMsp);
    return PostDocumentsModel.fromJson(response);
  }

  @override
  Future<PostDocumentsModel> openDocumentFopInformation(
      Map openDocumentFopInformationMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}document/opendocumentforinformation",
        openDocumentFopInformationMap);
    return PostDocumentsModel.fromJson(response);
  }

  @override
  Future<PostDocumentsModel> openDocumentFopReview(
      Map openDocumentFopReviewMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}document/opendocumentforreview",
        openDocumentFopReviewMap);
    return PostDocumentsModel.fromJson(response);
  }

  @override
  Future<PostDocumentsModel> rejectDocuments(Map rejectDocumentsMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}document/rejectdocument", rejectDocumentsMap);
    return PostDocumentsModel.fromJson(response);
  }

  @override
  Future<PostDocumentsModel> saveDocumentComments(
      Map saveDocumentCommentsMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}document/savecomments",
        saveDocumentCommentsMap);
    return PostDocumentsModel.fromJson(response);
  }

  @override
  Future<PostDocumentsModel> withdrawDocuments(Map withdrawDocumentsMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}document/withdrawdocument",
        withdrawDocumentsMap);
    return PostDocumentsModel.fromJson(response);
  }

}
