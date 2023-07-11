import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/todo/todoAssignToMeAndByMeList/todo_assign_to_me_and_by_me_states.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/repositories/todo/todo_repository.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../../../data/cache/customer_cache.dart';
import '../../../../di/app_module.dart';
import '../../../data/models/todo/fetch_assign_todo_by_me_list_model.dart';
import '../../../data/models/todo/fetch_assign_todo_to_me_list_model.dart';
import '../../../data/models/todo/fetch_todo_history_list_model.dart';
import 'todo_assign_to_me_and_by_me_event.dart';

class TodoAssignedToMeAndByMeBloc
    extends Bloc<ToDoAssignedToMeAndByMeEvent, TodoAssignedToMeAndByMeStates> {
  final ToDoRepository _toDoRepository = getIt<ToDoRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  TodoAssignedToMeAndByMeStates get initialState =>
      TodoAssignedToMeAndByMeInitial();

  TodoAssignedToMeAndByMeBloc() : super(TodoAssignedToMeAndByMeInitial()) {
    on<FetchTodoAssignedToMeAndByMeListEvent>(_fetchToDoAssignToMeList);
    on<ToDoToggleIndex>(_toggleIndexChanged);
    on<FetchToDoHistoryList>(_fetchHistoryList);
  }

  FutureOr _fetchToDoAssignToMeList(FetchTodoAssignedToMeAndByMeListEvent event,
      Emitter<TodoAssignedToMeAndByMeStates> emit) async {
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

  _toggleIndexChanged(
      ToDoToggleIndex event, Emitter<TodoAssignedToMeAndByMeStates> emit) {
    emit(TodoAssignedToMeAndByMeListFetched(
        fetchToDoAssignToMeListModel: event.fetchToDoAssignToMeListModel!,
        selectedIndex: event.selectedIndex,
        fetchToDoAssignToByListModel: event.fetchToDoAssignToByListModel!));
  }

  FutureOr _fetchHistoryList(FetchToDoHistoryList event,
      Emitter<TodoAssignedToMeAndByMeStates> emit) async {
    emit(FetchingTodoHistoryList());
    try {
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchToDoHistoryListModel fetchToDoHistoryListModel =
          await _toDoRepository.fetchToDoHistoryList(1, hashCode!, userId!);
      emit(TodoHistoryListFetched(
          fetchToDoHistoryListModel: fetchToDoHistoryListModel));
    } catch (e) {
      e.toString();
    }
  }
}
