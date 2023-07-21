import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/todo/todo_states.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/data/models/todo/fetch_todo_document_master_model.dart';
import 'package:toolkit/repositories/todo/todo_repository.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../di/app_module.dart';
import '../../data/models/todo/add_todo_model.dart';
import '../../data/models/todo/delete_todo_document_model.dart';
import '../../data/models/todo/fetch_assign_todo_by_me_list_model.dart';
import '../../data/models/todo/fetch_assign_todo_to_me_list_model.dart';
import '../../data/models/todo/fetch_document_for_todo_model.dart';
import '../../data/models/todo/fetch_todo_details_model.dart';
import '../../data/models/todo/fetch_todo_document_details_model.dart';
import '../../data/models/todo/fetch_todo_history_list_model.dart';
import '../../data/models/todo/save_todo_settings_model.dart';
import '../../data/models/todo/fetch_todo_master_model.dart';
import '../../data/models/todo/submit_todo_model.dart';
import '../../data/models/todo/save_todo_documents_model.dart';
import '../../data/models/todo/todo_mark_as_done_model.dart';
import '../../data/models/todo/todo_upload_document_model.dart';
import 'todo_event.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoStates> {
  final ToDoRepository _toDoRepository = getIt<ToDoRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  FetchDocumentForToDoModel fetchDocumentForToDoModel =
      FetchDocumentForToDoModel();
  FetchToDoMasterModel fetchToDoMasterModel = FetchToDoMasterModel();
  int initialIndex = 0;
  Map todoMap = {};
  Map filters = {};

  ToDoStates get initialState => TodoInitial();

  ToDoBloc() : super(TodoInitial()) {
    on<FetchTodoAssignedToMeAndByMeListEvent>(_fetchAssignToMeAndByMeList);
    on<ToDoToggleIndex>(_toggleIndexChanged);
    on<FetchToDoDetailsAndDocumentDetails>(_fetchDetails);
    on<DeleteToDoDocument>(_deleteDocument);
    on<ToDoMarkAsDone>(_markAsDone);
    on<FetchToDoHistoryList>(_fetchHistoryList);
    on<SelectToDoSendEmailOption>(_selectEmailOption);
    on<SelectToDoSendNotificationOption>(_selectNotificationOption);
    on<SaveToDoSettings>(_saveSettings);
    on<FetchDocumentForToDo>(_fetchDocumentForTodo);
    on<SelectDocumentForToDo>(_selectDocumentForTodo);
    on<FetchToDoMaster>(_fetchMaster);
    on<SelectToDoDocumentType>(_selectDocumentType);
    on<ToDoUploadDocument>(_uploadDocument);
    on<ApplyToDoFilter>(_applyFilter);
    on<ClearToDoFilter>(_clearFilter);
    on<ToDoPopUpMenuMarkAsDone>(_popupMenuMarkAsDone);
    on<SaveToDoDocuments>(_saveDocuments);
    on<AddToDo>(_addTodo);
    on<SubmitToDo>(_submitTodo);
    on<ChangeToDoCategory>(_categoryChanged);
    on<FetchToDoDocumentMaster>(_fetchDocumentMaster);
    on<ShowToDoSettingByUserType>(_showSettingByUserType);
  }

  _applyFilter(ApplyToDoFilter event, Emitter<ToDoStates> emit) {
    filters = event.todoFilterMap;
  }

  FutureOr<void> _clearFilter(
      ClearToDoFilter event, Emitter<ToDoStates> emit) async {
    filters = {};
  }

  FutureOr<void> _showSettingByUserType(
      ShowToDoSettingByUserType event, Emitter<ToDoStates> emit) async {
    String? userType = await _customerCache.getUserType(CacheKeys.userType);
    emit(ToDoSettingsShowedByUserType(userType: userType!));
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

  FutureOr _toggleIndexChanged(
      ToDoToggleIndex event, Emitter<ToDoStates> emit) {
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
    emit(DeletingToDoDocument());
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
    emit(ToDoMarkingAsDone());
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
      if (toDoMarkAsDoneModel.status == 200) {
        emit(ToDoMarkedAsDone(toDoMarkAsDoneModel: toDoMarkAsDoneModel));
      } else {
        emit(ToDoCannotMarkAsDone(
            cannotMarkAsDone:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      e.toString();
    }
  }

  FutureOr _fetchDocumentForTodo(
      FetchDocumentForToDo event, Emitter<ToDoStates> emit) async {
    emit(FetchingDocumentForToDo());
    try {
      todoMap = event.todoMap;
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      if (event.isFromPopUpMenu == true) {
        add(ClearToDoFilter());
        fetchDocumentForToDoModel = await _toDoRepository.fetchDocumentForTodo(
            1, hashCode!, todoMap['todoId'], '', '');
        add(SelectDocumentForToDo(
            selectedDocument: '', documentList: [], filtersMap: {}));
      } else {
        fetchDocumentForToDoModel = await _toDoRepository.fetchDocumentForTodo(
            1, hashCode!, todoMap['todoId'], '', jsonEncode(filters));
        add(SelectDocumentForToDo(
            selectedDocument: '', documentList: [], filtersMap: filters));
      }
    } catch (e) {
      e.toString();
    }
  }

  FutureOr _fetchHistoryList(
      FetchToDoHistoryList event, Emitter<ToDoStates> emit) async {
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

  _selectEmailOption(
      SelectToDoSendEmailOption event, Emitter<ToDoStates> emit) {
    Map emailOptionsMap = {
      "1": DatabaseUtil.getText('Yes'),
      "0": DatabaseUtil.getText('No')
    };
    emit(ToDoSendEmailOptionSelected(
        optionId: event.optionId,
        emailOptionsMap: emailOptionsMap,
        optionName: event.optionName));
  }

  _selectNotificationOption(
      SelectToDoSendNotificationOption event, Emitter<ToDoStates> emit) {
    Map notificationOptionsMap = {
      "1": DatabaseUtil.getText('Yes'),
      "0": DatabaseUtil.getText('No')
    };

    emit(ToDoSendNotificationOptionSelected(
        optionId: event.optionId,
        notificationOptionsMap: notificationOptionsMap,
        optionName: event.optionName));
  }

  FutureOr _saveSettings(
      SaveToDoSettings event, Emitter<ToDoStates> emit) async {
    emit(SavingToDoSettings());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      todoMap = event.todoMap;
      Map saveSettingsMap = {
        "userid": userId,
        "hashcode": hashCode,
        "assigned": todoMap['assigned'],
        "completed": todoMap['completed']
      };
      SaveToDoSettingsModel saveToDoSettingsModel =
          await _toDoRepository.todoSaveSettings(saveSettingsMap);
      emit(ToDoSettingsSaved(saveToDoSettingsModel: saveToDoSettingsModel));
    } catch (e) {
      emit(ToDoSettingsNotSaved(settingsNotSaved: e.toString()));
    }
  }

  _selectDocumentForTodo(
      SelectDocumentForToDo event, Emitter<ToDoStates> emit) {
    List selectedDocumentList = List.from(event.documentList);
    if (event.selectedDocument != '') {
      if (event.documentList.contains(event.selectedDocument) != true) {
        selectedDocumentList.add(event.selectedDocument);
      } else {
        selectedDocumentList.remove(event.selectedDocument);
      }
    }
    emit(DocumentForToDoFetched(
        fetchDocumentForToDoModel: fetchDocumentForToDoModel,
        selectDocumentList: selectedDocumentList,
        filterMap: filters));
  }

  FutureOr _addTodo(AddToDo event, Emitter<ToDoStates> emit) async {
    emit(AddingToDo());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      todoMap = event.todoMap;
      if (todoMap['createdfor'] == null ||
          todoMap['createdfor'].toString().isEmpty) {
        emit(ToDoNotAdded(todoNotAdded: StringConstants.kSelectCreatedFor));
      } else if (todoMap['categoryid'] == null ||
          todoMap['categoryid'].toString().isEmpty) {
        emit(ToDoNotAdded(todoNotAdded: StringConstants.kSelectCategory));
      } else if (todoMap['duedate'] == null ||
          todoMap['duedate'].toString().isEmpty) {
        emit(ToDoNotAdded(todoNotAdded: StringConstants.kSelectDueDate));
      } else if (todoMap['heading'] == null ||
          todoMap['heading'].toString().trim().isEmpty) {
        emit(ToDoNotAdded(todoNotAdded: StringConstants.kAddHeading));
      } else if (todoMap['description'] == null ||
          todoMap['description'].toString().trim().isEmpty) {
        emit(ToDoNotAdded(todoNotAdded: StringConstants.kAddDescription));
      } else {
        Map addToDoMap = {
          "idm": userId,
          "description": todoMap['description'],
          "duedate": todoMap['duedate'],
          "heading": todoMap['heading'],
          "categoryid": todoMap['categoryid'],
          "userid": userId,
          "createdfor": todoMap['createdfor'],
          "hashcode": hashCode
        };
        AddToDoModel addToDoModel = await _toDoRepository.addToDo(addToDoMap);
        if (addToDoModel.status == 200) {
          todoMap['todoId'] = addToDoModel.message;
        }
        emit(ToDoAdded(todoMap: todoMap, addToDoModel: addToDoModel));
      }
    } catch (e) {
      emit(ToDoNotAdded(todoNotAdded: e.toString()));
    }
  }

  FutureOr _submitTodo(SubmitToDo event, Emitter<ToDoStates> emit) async {
    emit(SubmittingToDo());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      todoMap = event.todoMap;
      Map submitToDoMap = {
        "todoid": todoMap['todoId'],
        "userid": userId,
        "hashcode": hashCode
      };
      SubmitToDoModel submitToDoModel =
          await _toDoRepository.submitToDo(submitToDoMap);
      emit(ToDoSubmitted(submitToDoModel: submitToDoModel));
    } catch (e) {
      emit(ToDoNotSubmitted(todoNotSubmitted: e.toString()));
    }
  }

  FutureOr _fetchMaster(FetchToDoMaster event, Emitter<ToDoStates> emit) async {
    emit(ToDoFetchingMaster());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      fetchToDoMasterModel =
          await _toDoRepository.fetchMaster(hashCode!, userId!);
      emit(ToDoMasterFetched(fetchToDoMasterModel: fetchToDoMasterModel));
    } catch (e) {
      emit(ToDoMasterNotFetched());
    }
  }

  _selectDocumentType(SelectToDoDocumentType event, Emitter<ToDoStates> emit) {
    emit(ToDoDocumentTypeSelected(
        documentTypeName: event.documentTypeName,
        documentTypeId: (event.documentTypeId)));
  }

  FutureOr _uploadDocument(
      ToDoUploadDocument event, Emitter<ToDoStates> emit) async {
    emit(UploadingToDoDocument());
    try {
      todoMap = event.todoMap;
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      if (todoMap['name'] == null || todoMap['name'].toString().isEmpty) {
        emit(ToDoDocumentNotUploaded(
            documentNotUploaded: StringConstants.kDocumentNameValidation));
      } else if (todoMap['files'] == null ||
          todoMap['files'].toString().isEmpty) {
        emit(ToDoDocumentNotUploaded(
            documentNotUploaded: StringConstants.kDocumentUploadValidation));
      } else {
        Map uploadDocumentMap = {
          "idm": todoMap['todoId'],
          "todoid": todoMap['todoId'],
          "name": todoMap['name'],
          "files": todoMap['files'],
          "userid": userId,
          "type": todoMap['type'],
          "hashcode": hashCode
        };
        ToDoUploadDocumentModel uploadDocumentModel =
            await _toDoRepository.uploadToDoDocument(uploadDocumentMap);
        if (uploadDocumentModel.status == 200) {
          emit(ToDoDocumentUploaded(
              toDoUploadDocumentModel: uploadDocumentModel));
        } else {
          emit(ToDoDocumentNotUploaded(
              documentNotUploaded:
                  DatabaseUtil.getText('some_unknown_error_please_try_again')));
        }
      }
    } catch (e) {
      emit(ToDoDocumentNotUploaded(documentNotUploaded: e.toString()));
    }
  }

  FutureOr _popupMenuMarkAsDone(
      ToDoPopUpMenuMarkAsDone event, Emitter<ToDoStates> emit) async {
    emit(PopUpMenuToDoMarkingAsDone());
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
      if (toDoMarkAsDoneModel.status == 200) {
        emit(PopUpMenuToDoMarkedAsDone(
            toDoMarkAsDoneModel: toDoMarkAsDoneModel));
      } else {
        emit(PopUpMenuToDoCannotMarkAsDone(
            cannotMarkAsDone:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(PopUpMenuToDoCannotMarkAsDone(cannotMarkAsDone: e.toString()));
    }
  }

  FutureOr _saveDocuments(
      SaveToDoDocuments event, Emitter<ToDoStates> emit) async {
    emit(SavingToDoDocuments());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      todoMap = event.todoMap;
      if (todoMap['documents'] == null ||
          todoMap['documents'].toString().isEmpty) {
        emit(ToDoDocumentsNotSaved(
            documentsNotSaved: DatabaseUtil.getText('PleaseSelectDocuments')));
      } else {
        Map saveDocumentsMap = {
          "hashcode": hashCode,
          "todoid": todoMap['todoId'],
          "documents": todoMap['documents'].toString().replaceAll(' ', ''),
          "userid": userId
        };
        SaveToDoDocumentsModel saveToDoDocumentsModel =
            await _toDoRepository.saveToDoDocuments(saveDocumentsMap);
        if (saveToDoDocumentsModel.status == 200) {
          emit(ToDoDocumentsSaved(
              saveToDoDocumentsModel: saveToDoDocumentsModel));
        } else {
          emit(ToDoDocumentsNotSaved(
              documentsNotSaved:
                  DatabaseUtil.getText('some_unknown_error_please_try_again')));
        }
      }
    } catch (e) {
      emit(ToDoDocumentsNotSaved(documentsNotSaved: e.toString()));
    }
  }

  FutureOr _fetchDocumentMaster(
      FetchToDoDocumentMaster event, Emitter<ToDoStates> emit) async {
    emit(FetchingToDoDocumentMaster());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      FetchToDoDocumentMasterModel fetchToDoDocumentMasterModel =
          await _toDoRepository.fetchDocumentMaster(hashCode!, userId!);
      todoMap = event.todoMap;
      List popUpMenuList = [
        DatabaseUtil.getText('MarkasDone'),
        DatabaseUtil.getText('AssignDocuments'),
        DatabaseUtil.getText('dms_uploaddocuments'),
      ];
      if (todoMap['isFromAdd'] == true || todoMap['isFromHistory'] == true) {
        popUpMenuList.removeAt(0);
      }
      emit(ToDoDocumentMasterFetched(
          fetchToDoDocumentMasterModel: fetchToDoDocumentMasterModel,
          popUpMenuList: popUpMenuList));
      add(ChangeToDoCategory(categoryId: ''));
    } catch (e) {
      emit(ToDoMasterNotFetched());
    }
  }

  _categoryChanged(ChangeToDoCategory event, Emitter<ToDoStates> emit) {
    emit(ToDoCategoryChanged(categoryId: event.categoryId));
  }
}
