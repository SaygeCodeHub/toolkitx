import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/todo/todo_states.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/repositories/todo/todo_repository.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../di/app_module.dart';
import '../../data/models/todo/add_todo_model.dart';
import '../../data/models/todo/delete_todo_document_model.dart';
import '../../data/models/todo/fetch_assign_todo_by_me_list_model.dart';
import '../../data/models/todo/fetch_assign_todo_to_me_list_model.dart';
import '../../data/models/todo/fetch_todo_details_model.dart';
import '../../data/models/todo/fetch_todo_document_details_model.dart';
import '../../data/models/todo/todo_mark_as_done_model.dart';
import 'todo_event.dart';

class TodoBloc extends Bloc<ToDoEvent, ToDoStates> {
  final ToDoRepository _toDoRepository = getIt<ToDoRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  int initialIndex = 0;
  Map todoMap = {};

  ToDoStates get initialState => TodoInitial();

  TodoBloc() : super(TodoInitial()) {
    on<FetchTodoAssignedToMeAndByMeListEvent>(_fetchAssignToMeAndByMeList);
    on<ToDoToggleIndex>(_toggleIndexChanged);
    on<FetchToDoDetailsAndDocumentDetails>(_fetchDetails);
    on<DeleteToDoDocument>(_deleteDocument);
    on<ToDoMarkAsDone>(_markAsDone);
    on<AddToDo>(_addTodo);
  }

  FutureOr _fetchAssignToMeAndByMeList(
      FetchTodoAssignedToMeAndByMeListEvent event,
      Emitter<ToDoStates> emit) async {
    emit(FetchingTodoAssignedToMeAndByMeList());
    try {
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchToDoAssignToMeListModel fetchToDoAssignToMeListModel =
          await _toDoRepository.fetchToDoAssignToMeList(
              1, hashCode!, StringConstants.kAssignedToMe, userId!);
      FetchToDoAssignToByListModel fetchToDoAssignToByListModel =
          await _toDoRepository.fetchToDoAssignByMeList(
              1, hashCode, StringConstants.kAssignedByMe, userId);
      if (fetchToDoAssignToMeListModel.status == 200 &&
          fetchToDoAssignToByListModel.status == 200) {
        emit(TodoAssignedToMeAndByMeListFetched(
          fetchToDoAssignToMeListModel: fetchToDoAssignToMeListModel,
          fetchToDoAssignToByListModel: fetchToDoAssignToByListModel,
        ));
        add(ToDoToggleIndex(
            selectedIndex: 0,
            fetchToDoAssignToMeListModel: fetchToDoAssignToMeListModel,
            fetchToDoAssignToByListModel: fetchToDoAssignToByListModel));
      }
    } catch (e) {
      e.toString();
    }
  }

  _toggleIndexChanged(ToDoToggleIndex event, Emitter<ToDoStates> emit) {
    emit(TodoAssignedToMeAndByMeListFetched(
        fetchToDoAssignToMeListModel: event.fetchToDoAssignToMeListModel!,
        selectedIndex: event.selectedIndex,
        fetchToDoAssignToByListModel: event.fetchToDoAssignToByListModel!));
  }

  FutureOr _fetchDetails(FetchToDoDetailsAndDocumentDetails event,
      Emitter<ToDoStates> emit) async {
    emit(FetchingTodoDetailsAndDocumentDetails());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? clientId = await _customerCache.getClientId(CacheKeys.clientId);
      initialIndex = event.selectedIndex;
      FetchToDoDetailsModel fetchToDoDetailsModel =
          await _toDoRepository.fetchToDoDetails(hashCode!, event.todoId);
      FetchToDoDocumentDetailsModel fetchToDoDocumentDetailsModel =
          await _toDoRepository.fetchToDoDocumentDetails(
              hashCode, event.todoId);
      if (fetchToDoDetailsModel.status == 200 ||
          fetchToDoDocumentDetailsModel.status == 200) {
        emit(TodoDetailsAndDocumentDetailsFetched(
            fetchToDoDocumentDetailsModel: fetchToDoDocumentDetailsModel,
            fetchToDoDetailsModel: fetchToDoDetailsModel,
            clientId: clientId!));
      }
    } catch (e) {
      e.toString();
    }
  }

  FutureOr _deleteDocument(
      DeleteToDoDocument event, Emitter<ToDoStates> emit) async {
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      todoMap = event.todoMap;
      Map deleteDocumentMap = {
        'userid': userId,
        'hashcode': hashCode,
        'tododocid': todoMap['todoDocId']
      };
      DeleteToDoDocumentModel deleteToDoDocumentModel =
          await _toDoRepository.toDoDeleteDocument(deleteDocumentMap);
      emit(ToDoDocumentDeleted(
          deleteToDoDocumentModel: deleteToDoDocumentModel));
    } catch (e) {
      e.toString();
    }
  }

  FutureOr _markAsDone(ToDoMarkAsDone event, Emitter<ToDoStates> emit) async {
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      todoMap = event.todoMap;
      Map markAsDoneMapMap = {
        'todoid': todoMap['todoId'],
        'userid': userId,
        'hashcode': hashCode
      };
      ToDoMarkAsDoneModel toDoMarkAsDoneModel =
          await _toDoRepository.toDoMarkAsDone(markAsDoneMapMap);
      emit(ToDoMarkedAsDone(toDoMarkAsDoneModel: toDoMarkAsDoneModel));
    } catch (e) {
      e.toString();
    }
  }

  FutureOr _addTodo(AddToDo event, Emitter<ToDoStates> emit) async {
    emit(AddingToDo());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      todoMap = event.todoMap;
      Map addToDoMap = {
        "idm": userId,
        "description": todoMap['description'],
        "duedate": todoMap['duedate'],
        "heading": todoMap['heading'],
        "categoryid": "",
        "userid": userId,
        "createdfor": "e2c25001-e312-4dfa-ae59-51ac706f6b87",
        "hashcode": hashCode
      };
      AddToDoModel addToDoModel = await _toDoRepository.addToDo(addToDoMap);
      if (addToDoModel.status == 200) {
        todoMap['todoId'] = addToDoModel.message;
      }
      emit(ToDoAdded(todoMap: todoMap, addToDoModel: addToDoModel));
    } catch (e) {
      e.toString();
    }
  }
}
