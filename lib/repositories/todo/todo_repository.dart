import '../../data/models/todo/delete_todo_document_model.dart';
import '../../data/models/todo/fetch_assign_todo_by_me_list_model.dart';
import '../../data/models/todo/fetch_assign_todo_to_me_list_model.dart';
import '../../data/models/todo/fetch_todo_details_model.dart';
import '../../data/models/todo/fetch_todo_document_details_model.dart';
import '../../data/models/todo/send_reminder_for_todo_model.dart';
import '../../data/models/todo/todo_mark_as_done_model.dart';

abstract class ToDoRepository {
  Future<FetchToDoAssignToMeListModel> fetchToDoAssignToMeList(
      int pageNo, String hashCode, String filter, String userId);

  Future<FetchToDoAssignToByListModel> fetchToDoAssignByMeList(
      int pageNo, String hashCode, String filter, String userId);

  Future<FetchToDoDetailsModel> fetchToDoDetails(
      String hashCode, String todoId);

  Future<FetchToDoDocumentDetailsModel> fetchToDoDocumentDetails(
      String hashCode, String todoId);

  Future<DeleteToDoDocumentModel> toDoDeleteDocument(Map todoDeleteDocumentMap);

  Future<ToDoMarkAsDoneModel> toDoMarkAsDone(Map todoMarkAsDoneMap);

  Future<SendReminderTodoModel> sendReminderForTodo(Map sendReminderMap);
}
