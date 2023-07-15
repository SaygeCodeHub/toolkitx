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
