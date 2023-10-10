import 'dart:developer';

import 'package:toolkit/data/models/documents/document_master_model.dart';
import 'package:toolkit/data/models/documents/document_roles_model.dart';

import '../../data/models/documents/documents_details_models.dart';
import '../../data/models/documents/documents_list_model.dart';
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
    log('response==================>$response');
    return DocumentDetailsModel.fromJson(response);
  }
}
