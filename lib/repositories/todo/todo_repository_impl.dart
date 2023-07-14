import 'package:toolkit/data/models/todo/delete_todo_document_model.dart';
import 'package:toolkit/data/models/todo/fetch_assign_todo_by_me_list_model.dart';
import 'package:toolkit/data/models/todo/fetch_assign_todo_to_me_list_model.dart';
import 'package:toolkit/data/models/todo/fetch_todo_details_model.dart';
import 'package:toolkit/data/models/todo/fetch_todo_document_details_model.dart';
import 'package:toolkit/data/models/todo/send_reminder_for_todo_model.dart';
import 'package:toolkit/data/models/todo/todo_mark_as_done_model.dart';
import 'package:toolkit/repositories/todo/todo_repository.dart';

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
  Future<SendReminderTodoModel> sendReminderForTodo(Map sendReminderMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}todo/SendReminder", sendReminderMap);
    return SendReminderTodoModel.fromJson(response);
  }
}
