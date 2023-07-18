import '../../data/models/todo/delete_todo_document_model.dart';
import '../../data/models/todo/fetch_assign_todo_by_me_list_model.dart';
import '../../data/models/todo/fetch_assign_todo_to_me_list_model.dart';
import '../../data/models/todo/fetch_todo_details_model.dart';
import '../../data/models/todo/fetch_todo_document_details_model.dart';
import '../../data/models/todo/fetch_todo_history_list_model.dart';
import '../../data/models/todo/save_todo_settings_model.dart';
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

class ToDoCannotMarkAsDone extends ToDoStates {}

class FetchingTodoHistoryList extends ToDoStates {}

class TodoHistoryListFetched extends ToDoStates {
  final FetchToDoHistoryListModel fetchToDoHistoryListModel;

  TodoHistoryListFetched({required this.fetchToDoHistoryListModel});
}

class ToDoSendEmailOptionSelected extends ToDoStates {
  final String optionId;
  final Map emailOptionsMap;
  final String optionName;

  ToDoSendEmailOptionSelected(
      {required this.optionName,
      required this.emailOptionsMap,
      required this.optionId});
}

class ToDoSendNotificationOptionSelected extends ToDoStates {
  final String optionId;
  final Map notificationOptionsMap;
  final String optionName;

  ToDoSendNotificationOptionSelected(
      {required this.optionName,
      required this.notificationOptionsMap,
      required this.optionId});
}

class SavingToDoSettings extends ToDoStates {}

class ToDoSettingsSaved extends ToDoStates {
  final SaveToDoSettingsModel saveToDoSettingsModel;

  ToDoSettingsSaved({required this.saveToDoSettingsModel});
}

class ToDoSettingsNotSaved extends ToDoStates {
  final String settingsNotSaved;

  ToDoSettingsNotSaved({required this.settingsNotSaved});
}
