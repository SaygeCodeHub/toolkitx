import '../../data/models/todo/add_todo_model.dart';
import '../../data/models/todo/delete_todo_document_model.dart';
import '../../data/models/todo/fetch_assign_todo_by_me_list_model.dart';
import '../../data/models/todo/fetch_assign_todo_to_me_list_model.dart';
import '../../data/models/todo/fetch_document_for_todo_model.dart';
import '../../data/models/todo/fetch_todo_details_model.dart';
import '../../data/models/todo/fetch_todo_document_details_model.dart';
import '../../data/models/todo/fetch_todo_document_master_model.dart';
import '../../data/models/todo/fetch_todo_master_model.dart';
import '../../data/models/todo/save_todo_documents_model.dart';
import '../../data/models/todo/submit_todo_model.dart';
import '../../data/models/todo/send_reminder_for_todo_model.dart';
import '../../data/models/todo/todo_mark_as_done_model.dart';
import '../../data/models/todo/todo_upload_document_model.dart';

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

class FetchingDocumentForToDo extends ToDoStates {}

class DocumentForToDoFetched extends ToDoStates {
  final FetchDocumentForToDoModel fetchDocumentForToDoModel;
  final List selectDocumentList;
  final Map filterMap;

  DocumentForToDoFetched(
      {required this.filterMap,
      required this.selectDocumentList,
      required this.fetchDocumentForToDoModel});
}

class ToDoMasterFetched extends ToDoStates {
  final FetchToDoMasterModel fetchToDoMasterModel;

  ToDoMasterFetched({required this.fetchToDoMasterModel});
}

class ToDoMasterNotFetched extends ToDoStates {}

class ToDoDocumentTypeSelected extends ToDoStates {
  final String documentTypeName;
  final int documentTypeId;

  ToDoDocumentTypeSelected(
      {required this.documentTypeId, required this.documentTypeName});
}

class UploadingToDoDocument extends ToDoStates {}

class ToDoDocumentUploaded extends ToDoStates {
  final ToDoUploadDocumentModel toDoUploadDocumentModel;

  ToDoDocumentUploaded({required this.toDoUploadDocumentModel});
}

class ToDoDocumentNotUploaded extends ToDoStates {
  final String documentNotUploaded;

  ToDoDocumentNotUploaded({required this.documentNotUploaded});
}

class PopUpMenuToDoMarkingAsDone extends ToDoStates {}

class PopUpMenuToDoMarkedAsDone extends ToDoStates {
  final ToDoMarkAsDoneModel toDoMarkAsDoneModel;

  PopUpMenuToDoMarkedAsDone({required this.toDoMarkAsDoneModel});
}

class PopUpMenuToDoCannotMarkAsDone extends ToDoStates {
  final String cannotMarkAsDone;

  PopUpMenuToDoCannotMarkAsDone({required this.cannotMarkAsDone});
}

class SavingToDoDocuments extends ToDoStates {}

class ToDoDocumentsSaved extends ToDoStates {
  final SaveToDoDocumentsModel saveToDoDocumentsModel;

  ToDoDocumentsSaved({required this.saveToDoDocumentsModel});
}

class ToDoDocumentsNotSaved extends ToDoStates {
  final String documentsNotSaved;

  ToDoDocumentsNotSaved({required this.documentsNotSaved});
}

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

class ToDoCategoryChanged extends ToDoStates {
  final String categoryId;

  ToDoCategoryChanged({required this.categoryId});
}

class FetchingToDoDocumentMaster extends ToDoStates {}

class ToDoDocumentMasterFetched extends ToDoStates {
  final FetchToDoDocumentMasterModel fetchToDoDocumentMasterModel;
  final List popUpMenuList;

  ToDoDocumentMasterFetched(
      {required this.popUpMenuList,
      required this.fetchToDoDocumentMasterModel});
}

class ToDoDocumentMasterNotFetched extends ToDoStates {
  final String documentMasterNotFetched;

  ToDoDocumentMasterNotFetched({required this.documentMasterNotFetched});
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
