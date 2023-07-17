import '../../data/models/todo/add_todo_model.dart';
import '../../data/models/todo/delete_todo_document_model.dart';
import '../../data/models/todo/fetch_assign_todo_by_me_list_model.dart';
import '../../data/models/todo/fetch_assign_todo_to_me_list_model.dart';
import '../../data/models/todo/fetch_todo_details_model.dart';
import '../../data/models/todo/fetch_todo_document_details_model.dart';
import '../../data/models/todo/fetch_todo_master_model.dart';
import '../../data/models/todo/submit_todo_model.dart';
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

class AddingToDo extends ToDoStates {}

class ToDoAdded extends ToDoStates {
  final Map todoMap;
  final AddToDoModel addToDoModel;

  ToDoAdded({required this.addToDoModel, required this.todoMap});
}

class ToDoNotAdded extends ToDoStates {
  final String todoNotAdded;

  ToDoNotAdded({required this.todoNotAdded});
}

class SubmittingToDo extends ToDoStates {}

class ToDoSubmitted extends ToDoStates {
  final SubmitToDoModel submitToDoModel;

  ToDoSubmitted({required this.submitToDoModel});
}

class ToDoNotSubmitted extends ToDoStates {
  final String todoNotSubmitted;

  ToDoNotSubmitted({required this.todoNotSubmitted});
}

class ToDoFetchingMaster extends ToDoStates {}

class ToDoMasterFetched extends ToDoStates {
  final FetchToDoMasterModel fetchToDoMasterModel;

  ToDoMasterFetched({required this.fetchToDoMasterModel});
}

class ToDoMasterNotFetched extends ToDoStates {
  final String masterNotFetched;

  ToDoMasterNotFetched({required this.masterNotFetched});
}

class ToDoCategoryChanged extends ToDoStates {
  final String categoryId;

  ToDoCategoryChanged({required this.categoryId});
}
