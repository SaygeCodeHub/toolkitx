import 'package:toolkit/data/models/todo/add_todo_model.dart';
import 'package:toolkit/data/models/todo/delete_todo_document_model.dart';
import 'package:toolkit/data/models/todo/fetch_assign_todo_by_me_list_model.dart';
import 'package:toolkit/data/models/todo/fetch_assign_todo_to_me_list_model.dart';
import 'package:toolkit/data/models/todo/fetch_document_for_todo_model.dart';
import 'package:toolkit/data/models/todo/fetch_todo_details_model.dart';
import 'package:toolkit/data/models/todo/fetch_todo_document_details_model.dart';
import 'package:toolkit/data/models/todo/fetch_todo_document_master_model.dart';
import 'package:toolkit/data/models/todo/fetch_todo_master_model.dart';
import 'package:toolkit/data/models/todo/submit_todo_model.dart';
import 'package:toolkit/data/models/todo/save_todo_settings_model.dart';
import 'package:toolkit/data/models/todo/todo_mark_as_done_model.dart';
import 'package:toolkit/data/models/todo/todo_upload_document_model.dart';
import 'package:toolkit/data/models/todo/fetch_todo_history_list_model.dart';
import 'package:toolkit/repositories/todo/todo_repository.dart';

import '../../data/models/todo/save_todo_documents_model.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';

class ToDoRepositoryImpl extends ToDoRepository {
  @override
  Future<FetchToDoAssignToMeListModel> fetchToDoAssignToMeList(
      int pageNo, String hashCode, String filter, String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}todo/get?pageno=1&hashcode=$hashCode&filter=$filter&userid=$userId");
    return FetchToDoAssignToMeListModel.fromJson(response);
  }

  @override
  Future<FetchToDoAssignToByListModel> fetchToDoAssignByMeList(
      int pageNo, String hashCode, String filter, String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}todo/get?pageno=1&hashcode=$hashCode&filter=$filter&userid=$userId");
    return FetchToDoAssignToByListModel.fromJson(response);
  }

  @override
  Future<FetchToDoDetailsModel> fetchToDoDetails(
      String hashCode, String todoId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}todo/gettodo?hashcode=$hashCode&todoid=$todoId");
    return FetchToDoDetailsModel.fromJson(response);
  }

  @override
  Future<FetchToDoDocumentDetailsModel> fetchToDoDocumentDetails(
      String hashCode, String todoId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}todo/GetToDoDocument?hashcode=$hashCode&todoid=$todoId");

    return FetchToDoDocumentDetailsModel.fromJson(response);
  }

  @override
  Future<DeleteToDoDocumentModel> toDoDeleteDocument(
      Map todoDeleteDocumentMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}todo/deletedocument", todoDeleteDocumentMap);
    return DeleteToDoDocumentModel.fromJson(response);
  }

  @override
  Future<ToDoMarkAsDoneModel> toDoMarkAsDone(Map todoMarkAsDoneMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}todo/markasdone", todoMarkAsDoneMap);
    return ToDoMarkAsDoneModel.fromJson(response);
  }

  @override
  Future<FetchDocumentForToDoModel> fetchDocumentForTodo(int pageNo,
      String hashCode, String todoId, String name, String filter) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}todo/getdocumentsfortodo?pageno=1&hashcode=$hashCode&todoid=$todoId&name=$name&filter=$filter");
    return FetchDocumentForToDoModel.fromJson(response);
  }

  @override
  Future<FetchToDoMasterModel> fetchTodoMaster(
      String hashCode, String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}document/getmaster?hashcode=$hashCode&userid=$userId");
    return FetchToDoMasterModel.fromJson(response);
  }

  @override
  Future<ToDoUploadDocumentModel> uploadToDoDocument(
      Map uploadDocumentMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}todo/uploaddocument", uploadDocumentMap);
    return ToDoUploadDocumentModel.fromJson(response);
  }

  @override
  Future<SaveToDoDocumentsModel> saveToDoDocuments(Map saveDocumentMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}todo/managedocuments", saveDocumentMap);
    return SaveToDoDocumentsModel.fromJson(response);
  }

  @override
  Future<AddToDoModel> addToDo(Map addToDoMap) async {
    final response =
        await DioClient().post("${ApiConstants.baseUrl}todo/save", addToDoMap);
    return AddToDoModel.fromJson(response);
  }

  @override
  Future<SubmitToDoModel> submitToDo(Map submitToDoMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}todo/publishtodo", submitToDoMap);
    return SubmitToDoModel.fromJson(response);
  }

  @override
  Future<FetchToDoMasterModel> fetchMaster(
      String hashCode, String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}todo/getmaster?hashcode=$hashCode&userid=$userId");
    return FetchToDoMasterModel.fromJson(response);
  }

  @override
  Future<FetchToDoDocumentMasterModel> fetchDocumentMaster(
      String hashCode, String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}document/getmaster?hashcode=$hashCode&userid=$userId");
    return FetchToDoDocumentMasterModel.fromJson(response);
  }

  @override
  Future<FetchToDoHistoryListModel> fetchToDoHistoryList(
      int pageNo, String hashCode, String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}todo/gethistory?pageno=1&hashcode=$hashCode&userid=$userId");
    return FetchToDoHistoryListModel.fromJson(response);
  }

  @override
  Future<SaveToDoSettingsModel> todoSaveSettings(
      Map todoSaveSettingsMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}todo/SaveSettings", todoSaveSettingsMap);
    return SaveToDoSettingsModel.fromJson(response);
  }
}
