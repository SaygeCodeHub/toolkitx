import '../../data/models/todo/fetch_assign_todo_by_me_list_model.dart';
import '../../data/models/todo/fetch_assign_todo_to_me_list_model.dart';

abstract class ToDoEvent {}

class FetchTodoAssignedToMeAndByMeListEvent extends ToDoEvent {
  FetchTodoAssignedToMeAndByMeListEvent();
}

class ToDoToggleIndex extends ToDoEvent {
  final int selectedIndex;
  final FetchToDoAssignToByListModel? fetchToDoAssignToByListModel;
  final FetchToDoAssignToMeListModel? fetchToDoAssignToMeListModel;

  ToDoToggleIndex(
      {this.fetchToDoAssignToMeListModel,
      this.fetchToDoAssignToByListModel,
      required this.selectedIndex});
}

class FetchToDoDetailsAndDocumentDetails extends ToDoEvent {
  final String todoId;
  final int selectedIndex;

  FetchToDoDetailsAndDocumentDetails(
      {required this.todoId, required this.selectedIndex});
}

class DeleteToDoDocument extends ToDoEvent {
  final Map todoMap;

  DeleteToDoDocument({required this.todoMap});
}

class ToDoMarkAsDone extends ToDoEvent {
  final Map todoMap;

  ToDoMarkAsDone({required this.todoMap});
}

class FetchToDoHistoryList extends ToDoEvent {}

class SelectToDoSendEmailOption extends ToDoEvent {
  final String optionId;
  final String optionName;

  SelectToDoSendEmailOption({required this.optionName, required this.optionId});
}

class SelectToDoSendNotificationOption extends ToDoEvent {
  final String optionId;
  final String optionName;

  SelectToDoSendNotificationOption(
      {required this.optionName, required this.optionId});
}

class SaveToDoSettings extends ToDoEvent {
  final Map todoMap;

  SaveToDoSettings({required this.todoMap});
}
