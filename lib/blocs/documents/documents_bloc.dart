import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/documents/document_master_model.dart';
import 'package:toolkit/data/models/documents/document_roles_model.dart';
import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/documents/documents_list_model.dart';
import '../../di/app_module.dart';
import '../../repositories/documents/documents_repository.dart';
import 'documents_events.dart';
import 'documents_states.dart';

class DocumentsBloc extends Bloc<DocumentsEvents, DocumentsStates> {
  final DocumentsRepository _documentsRepository = getIt<DocumentsRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  String roleId = '';
  Map filters = {};
  List type = [];
  List masterData = [];
  bool docListReachedMax = false;
  String selectedType = '';
  List<DocumentsListDatum> documentsListDatum = [];

  DocumentsStates get initialState => const DocumentsInitial();

  DocumentsBloc() : super(const DocumentsInitial()) {
    on<GetDocumentsList>(_getDocumentsList);
    on<GetDocumentRoles>(_getDocumentsRoles);
    on<SelectDocumentRoleEvent>(_selectDocumentRoleEvent);
    on<FetchDocumentMaster>(_fetchDocumentMaster);
    on<SelectDocumentStatusFilter>(_selectDocumentStatusFilter);
    on<SelectDocumentLocationFilter>(_selectDocumentLocationFilter);
    on<ApplyDocumentFilter>(_applyDocumentFilter);
    on<ClearDocumentFilter>(_clearDocumentFilter);
  }

  Future<void> _getDocumentsList(
      GetDocumentsList event, Emitter<DocumentsStates> emit) async {
    try {
      emit(const FetchingDocumentsList());
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      if (!docListReachedMax) {
        if (event.isFromHome == true) {
          filters = {};
          DocumentsListModel documentsListModel =
              await _documentsRepository.getDocumentsList(userId.toString(),
                  hashCode.toString(), "", roleId, event.page);
          documentsListDatum.addAll(documentsListModel.data);
          docListReachedMax = documentsListModel.data.isEmpty;
          emit(DocumentsListFetched(documentsListModel: documentsListModel));
        } else {
          DocumentsListModel documentsListModel =
              await _documentsRepository.getDocumentsList(userId.toString(),
                  hashCode.toString(), jsonEncode(filters), roleId, event.page);
          documentsListDatum.addAll(documentsListModel.data);
          docListReachedMax = documentsListModel.data.isEmpty;
          emit(DocumentsListFetched(documentsListModel: documentsListModel));
        }
      }
    } catch (e) {
      emit(DocumentsListError(message: e.toString()));
    }
  }

  Future<FutureOr<void>> _getDocumentsRoles(
      GetDocumentRoles event, Emitter<DocumentsStates> emit) async {
    emit(const FetchingDocumentRoles());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      DocumentRolesModel documentRolesModel =
          await _documentsRepository.getDocumentsRoles(userId, hashCode);
      emit(DocumentRolesFetched(
          documentRolesModel: documentRolesModel, roleId: roleId));
    } catch (e) {
      emit(const CouldNotFetchDocumentRoles());
      rethrow;
    }
  }

  FutureOr<void> _selectDocumentRoleEvent(
      SelectDocumentRoleEvent event, Emitter<DocumentsStates> emit) {
    roleId = event.roleId;
    emit(const DocumentRoleSelected());
  }

  Future<FutureOr<void>> _fetchDocumentMaster(
      FetchDocumentMaster event, Emitter<DocumentsStates> emit) async {
    emit(FetchingDocumentMaster());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      FetchDocumentMasterModel fetchDocumentMasterModel =
          await _documentsRepository.fetchDocumentMaster(userId!, hashCode!);
      masterData = fetchDocumentMasterModel.data;
      if (fetchDocumentMasterModel.status == 200) {
        emit(DocumentMasterFetched(
            fetchDocumentMasterModel: fetchDocumentMasterModel));
      }
    } catch (e) {
      emit(DocumentMasterError(fetchError: e.toString()));
    }
  }

  FutureOr<void> _selectDocumentStatusFilter(
      SelectDocumentStatusFilter event, Emitter<DocumentsStates> emit) {
    emit(DocumentStatusFilterSelected(selectedIndex: event.selectedIndex));
  }

  FutureOr<void> _selectDocumentLocationFilter(
      SelectDocumentLocationFilter event, Emitter<DocumentsStates> emit) {
    emit(DocumentTypeFilterSelected(selectedType: event.selectedType));
  }

  FutureOr<void> _applyDocumentFilter(
      ApplyDocumentFilter event, Emitter<DocumentsStates> emit) {
    filters = {
      "documentName": event.filterMap["documentName"],
      "documentId": event.filterMap["documentId"],
      "author": event.filterMap["author"],
      'type': event.filterMap["type"],
      "status": event.filterMap["status"]
    };
  }

  FutureOr<void> _clearDocumentFilter(
      ClearDocumentFilter event, Emitter<DocumentsStates> emit) {
    filters = {};
    type = [];
    add(GetDocumentsList(page: 1, isFromHome: false));
  }
}