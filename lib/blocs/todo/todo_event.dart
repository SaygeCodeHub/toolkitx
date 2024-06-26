import '../../data/models/todo/fetch_assign_todo_by_me_list_model.dart';
import '../../data/models/todo/fetch_assign_todo_to_me_list_model.dart';

abstract class ToDoEvent {}

class FetchTodoAssignedToMeAndByMeListEvent extends ToDoEvent {}

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

class FetchDocumentForToDo extends ToDoEvent {
  final Map todoMap;
  final bool isFromPopUpMenu;

  FetchDocumentForToDo({required this.isFromPopUpMenu, required this.todoMap});
}

class SelectDocumentForToDo extends ToDoEvent {
  final String selectedDocument;
  final List documentList;
  final Map filtersMap;

  SelectDocumentForToDo(
      {required this.filtersMap,
      required this.selectedDocument,
      required this.documentList});
}

class FetchToDoMaster extends ToDoEvent {}

class SelectToDoDocumentType extends ToDoEvent {
  final String documentTypeName;
  final int documentTypeId;

  SelectToDoDocumentType(
      {required this.documentTypeId, required this.documentTypeName});
}

class ToDoUpload extends ToDoEvent {}

class ToDoUploadDocument extends ToDoEvent {
  final Map todoMap;

  ToDoUploadDocument({required this.todoMap});
}

class ApplyToDoFilter extends ToDoEvent {
  final Map todoFilterMap;

  ApplyToDoFilter({required this.todoFilterMap});
}

class ClearToDoFilter extends ToDoEvent {}

class ToDoPopUpMenuMarkAsDone extends ToDoEvent {
  final Map todoMap;

  ToDoPopUpMenuMarkAsDone({required this.todoMap});
}

class SaveToDoDocuments extends ToDoEvent {
  final Map todoMap;

  SaveToDoDocuments({required this.todoMap});
}

class AddToDo extends ToDoEvent {
  final Map todoMap;

  AddToDo({required this.todoMap});
}

class SubmitToDo extends ToDoEvent {
  final Map todoMap;

  SubmitToDo({required this.todoMap});
}

class FetchToDoDocumentMaster extends ToDoEvent {
  final Map todoMap;

  FetchToDoDocumentMaster({required this.todoMap});
}

class ChangeToDoCategory extends ToDoEvent {
  final String categoryId;

  ChangeToDoCategory({required this.categoryId});
}

class ToDoSendReminder extends ToDoEvent {
  final Map todoMap;

  ToDoSendReminder({required this.todoMap});
}

class FetchToDoHistoryList extends ToDoEvent {
  final int page;

  FetchToDoHistoryList({required this.page});
}

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

class ShowToDoSettingByUserType extends ToDoEvent {}
