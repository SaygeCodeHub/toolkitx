import '../../data/models/todo/delete_todo_document_model.dart';
import '../../data/models/todo/fetch_assign_todo_by_me_list_model.dart';
import '../../data/models/todo/fetch_assign_todo_to_me_list_model.dart';
import '../../data/models/todo/fetch_todo_details_model.dart';
import '../../data/models/todo/fetch_todo_document_details_model.dart';
import '../../data/models/todo/send_reminder_for_todo_model.dart';
import '../../data/models/todo/todo_mark_as_done_model.dart';

abstract class ToDoStates {}

class TodoInitial extends ToDoStates {}

class FetchingTodoAssignedToMeAndByMeList extends ToDoStates {}

class TodoAssignedToMeAndByMeListFetched extends ToDoStates {
  final FetchToDoAssignToMeListModel fetchToDoAssignToMeListModel;
  final FetchToDoAssignToByListModel fetchToDoAssignToByListModel;
  final int? selectedIndex;

  TodoAssignedToMeAndByMeListFetched(
      {required this.fetchToDoAssignToByListModel,
      this.selectedIndex,
      required this.fetchToDoAssignToMeListModel});
}

class FetchingTodoDetailsAndDocumentDetails extends ToDoStates {}

class TodoDetailsAndDocumentDetailsFetched extends ToDoStates {
  final FetchToDoDetailsModel fetchToDoDetailsModel;
  final FetchToDoDocumentDetailsModel fetchToDoDocumentDetailsModel;
  final String clientId;

  TodoDetailsAndDocumentDetailsFetched(
      {required this.clientId,
      required this.fetchToDoDocumentDetailsModel,
      required this.fetchToDoDetailsModel});
}

class DeletingToDoDocument extends ToDoStates {}

class ToDoDocumentDeleted extends ToDoStates {
  final DeleteToDoDocumentModel deleteToDoDocumentModel;

  ToDoDocumentDeleted({required this.deleteToDoDocumentModel});
}

class CannotDeleteToDoDocument extends ToDoStates {}

class ToDoMarkingAsDone extends ToDoStates {}

class ToDoMarkedAsDone extends ToDoStates {
  final ToDoMarkAsDoneModel toDoMarkAsDoneModel;

  ToDoMarkedAsDone({required this.toDoMarkAsDoneModel});
}

class ToDoCannotMarkAsDone extends ToDoStates {
  final String cannotMarkAsDone;

  ToDoCannotMarkAsDone({required this.cannotMarkAsDone});
}

class SendingReminderForToDo extends ToDoStates {}

class ReminderSendForToDo extends ToDoStates {
  final SendReminderTodoModel sendReminderTodoModel;

  ReminderSendForToDo({required this.sendReminderTodoModel});
}

class ReminderCannotSendForToDo extends ToDoStates {
  final String cannotSendReminder;

  ReminderCannotSendForToDo({required this.cannotSendReminder});
}
