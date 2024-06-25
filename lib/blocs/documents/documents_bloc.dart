import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/documents/document_master_model.dart';
import 'package:toolkit/data/models/documents/document_roles_model.dart';
import 'package:toolkit/data/models/documents/document_upload_file_version_model.dart';
import 'package:toolkit/data/models/documents/documents_to_link_model.dart';
import 'package:toolkit/data/models/documents/post_document_model.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/documents/documents_details_models.dart';
import '../../data/models/documents/documents_list_model.dart';
import '../../data/models/documents/save_document_comments_model.dart';
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
  String linkDocSelectedType = '';
  List<DocumentsListDatum> documentsListDatum = [];
  String documentId = '';
  Map linkDocFilters = {};
  List<DocumentsToLinkData> documentsToLinkList = [];
  bool linkDocumentsReachedMax = false;

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
    on<GetDocumentsDetails>(_getDocumentsDetails);
    on<GetDocumentsToLink>(_fetchDocumentsToLink);
    on<SaveLinkedDocuments>(_saveLinkedDocuments);
    on<AttachDocuments>(_attachDocuments);
    on<UploadDocumentFileVersion>(_uploadDocumentFileVersion);
    on<DeleteDocuments>(_deleteDocuments);
    on<OpenDocumentsForInformation>(_openDocumentsForInformation);
    on<OpenDocumentsForReview>(_openDocumentsForReview);
    on<ApproveDocument>(_approveDocuments);
    on<RejectDocument>(_rejectDocument);
    on<WithdrawDocument>(_withdrawDocument);
    on<CloseDocument>(_closeDocument);
    on<SaveDocumentComments>(_saveDocumentComments);
  }

  Future<void> _getDocumentsList(
      GetDocumentsList event, Emitter<DocumentsStates> emit) async {
    try {
      emit(const FetchingDocumentsList());
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      if (event.isFromHome == true) {
        docListReachedMax = false;
        selectedType = '';
        filters = {};
        DocumentsListModel documentsListModel =
            await _documentsRepository.getDocumentsList(
                userId.toString(), hashCode.toString(), "", roleId, event.page);
        documentsListDatum.addAll(documentsListModel.data);
        docListReachedMax = documentsListModel.data.isEmpty;
        emit(DocumentsListFetched(documentsListModel: documentsListModel));
      } else if (!docListReachedMax) {
        DocumentsListModel documentsListModel =
            await _documentsRepository.getDocumentsList(userId.toString(),
                hashCode.toString(), jsonEncode(filters), roleId, event.page);
        documentsListDatum.addAll(documentsListModel.data);
        docListReachedMax = documentsListModel.data.isEmpty;
        emit(DocumentsListFetched(documentsListModel: documentsListModel));
      } else {}
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
    linkDocSelectedType = event.selectedType;
    emit(DocumentTypeFilterSelected(selectedType: event.selectedType));
  }

  FutureOr<void> _applyDocumentFilter(
      ApplyDocumentFilter event, Emitter<DocumentsStates> emit) {
    filters = {
      "name": event.filterMap["documentName"] ?? '',
      "docno": event.filterMap["documentId"] ?? '',
      "author": event.filterMap["author"] ?? '',
      'type': event.filterMap["type"] ?? '',
      "status": event.filterMap["status"] ?? ''
    };
  }

  FutureOr<void> _clearDocumentFilter(
      ClearDocumentFilter event, Emitter<DocumentsStates> emit) {
    filters = {};
    type = [];
    add(GetDocumentsList(page: 1, isFromHome: false));
  }

  Future<FutureOr<void>> _getDocumentsDetails(
      GetDocumentsDetails event, Emitter<DocumentsStates> emit) async {
    emit(const FetchingDocumentsDetails());
    try {
      String hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      String clientId =
          await _customerCache.getClientId(CacheKeys.clientId) ?? '';
      List documentsPopUpMenu = [DatabaseUtil.getText('dms_linkotherdocument')];
      DocumentDetailsModel documentDetailsModel = await _documentsRepository
          .getDocumentsDetails(userId, hashCode, roleId, documentId);
      if (documentDetailsModel.data.canaddcomments == '1') {
        documentsPopUpMenu.add(DatabaseUtil.getText('AddComments'));
      }
      if (documentDetailsModel.data.canaddmoredocs == '1') {
        documentsPopUpMenu.add(DatabaseUtil.getText('dms_attachdocument'));
      }
      if (documentDetailsModel.data.canapprove == '1') {
        documentsPopUpMenu.add(DatabaseUtil.getText('dms_approvedocument'));
      }
      if (documentDetailsModel.data.canclose == '1') {
        documentsPopUpMenu.add(DatabaseUtil.getText('dms_closedocument'));
      }
      if (documentDetailsModel.data.canopen == '1') {
        documentsPopUpMenu.add(DatabaseUtil.getText('dms_openforreview'));
        documentsPopUpMenu.add(DatabaseUtil.getText('dms_openforinformation'));
      }
      if (documentDetailsModel.data.canreject == '1') {
        documentsPopUpMenu.add(DatabaseUtil.getText('dms_rejectdocument'));
      }
      if (documentDetailsModel.data.canwithdraw == '1') {
        documentsPopUpMenu.add(DatabaseUtil.getText('withdraw'));
      }
      emit(DocumentsDetailsFetched(
          documentDetailsModel: documentDetailsModel,
          documentsPopUpMenu: documentsPopUpMenu,
          clientId: clientId));
    } catch (e) {
      emit(DocumentsDetailsError(message: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchDocumentsToLink(
      GetDocumentsToLink event, Emitter<DocumentsStates> emit) async {
    emit(const FetchingDocumentsToLink());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      if (!linkDocumentsReachedMax) {
        DocumentsToLinkModel documentsToLinkModel =
            await _documentsRepository.getDocumentsToLink(
                jsonEncode(linkDocFilters), hashCode, documentId, event.page);
        documentsToLinkList.addAll(documentsToLinkModel.data);
        linkDocumentsReachedMax = documentsToLinkModel.data.isEmpty;
        emit(DocumentsToLinkFetched(
            documentsToLinkModel: documentsToLinkModel,
            documentsToLinkList: documentsToLinkList));
      }
    } catch (e) {
      emit(DocumentMasterError(fetchError: e.toString()));
    }
  }

  Future<FutureOr<void>> _saveLinkedDocuments(
      SaveLinkedDocuments event, Emitter<DocumentsStates> emit) async {
    emit(const SavingLikedDocuments());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      Map saveLinkedDocumentsMap = {
        "hashcode": hashCode,
        "documentid": documentId,
        "documents": event.linkedDocuments.replaceAll(" ", ""),
        "userid": userId
      };
      PostDocumentsModel saveLinkedDocumentsModel = await _documentsRepository
          .saveLinkedDocuments(saveLinkedDocumentsMap);
      if (saveLinkedDocumentsModel.message == '1') {
        emit(LikedDocumentsSaved(
            saveLinkedDocumentsModel: saveLinkedDocumentsModel));
      } else {
        emit(SaveLikedDocumentsError(
            message:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(SaveLikedDocumentsError(message: e.toString()));
    }
  }

  Future<FutureOr<void>> _attachDocuments(
      AttachDocuments event, Emitter<DocumentsStates> emit) async {
    emit(const AttachingDocuments());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      if (event.attachDocumentsMap['files'] != null) {
        Map attachDocumentsMap = {
          "documentid": documentId,
          "files": event.attachDocumentsMap['files'],
          "userid": userId,
          "notes": event.attachDocumentsMap['notes'],
          "hashcode": hashCode
        };
        PostDocumentsModel postDocumentsModel =
            await _documentsRepository.attachDocuments(attachDocumentsMap);
        if (postDocumentsModel.message == '1') {
          emit(DocumentsAttached(postDocumentsModel: postDocumentsModel));
        } else {
          emit(AttachDocumentsError(
              message:
                  DatabaseUtil.getText('some_unknown_error_please_try_again')));
        }
      } else {
        emit(AttachDocumentsError(
            message: DatabaseUtil.getText('PleaseSelectAnyDocOrImage')));
      }
    } catch (e) {
      emit(AttachDocumentsError(message: e.toString()));
    }
  }

  Future<FutureOr<void>> _uploadDocumentFileVersion(
      UploadDocumentFileVersion event, Emitter<DocumentsStates> emit) async {
    emit(DocumentFileVersionUploading());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      if (event.uploadFileVersionMap['filename'] != null) {
        Map uploadFileVersionMap = {
          "fileid": event.uploadFileVersionMap['fileid'],
          "filename": event.uploadFileVersionMap['filename'],
          "userid": userId,
          "notes": event.uploadFileVersionMap['notes'],
          "hashcode": hashCode
        };
        DocumentUploadFileVersionModel documentUploadFileVersionModel =
            await _documentsRepository
                .documentUploadFileVersion(uploadFileVersionMap);
        if (documentUploadFileVersionModel.message == '1') {
          emit(DocumentFileVersionUploaded(
              documentUploadFileVersionModel: documentUploadFileVersionModel));
        } else {
          emit(DocumentFileVersionNotUploaded(
              errorMessage: documentUploadFileVersionModel.message));
        }
      } else {
        emit(DocumentFileVersionNotUploaded(
            errorMessage: DatabaseUtil.getText('PleaseSelectAnyDocOrImage')));
      }
    } catch (e) {
      emit(DocumentFileVersionNotUploaded(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _deleteDocuments(
      DeleteDocuments event, Emitter<DocumentsStates> emit) async {
    emit(const DeletingDocuments());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      Map deleteDocumentsMap = {"fileid": event.fileId, "hashcode": hashCode};
      PostDocumentsModel postDocumentsModel =
          await _documentsRepository.deleteDocuments(deleteDocumentsMap);
      if (postDocumentsModel.message == '1') {
        emit(DocumentsDeleted(postDocumentsModel: postDocumentsModel));
      } else {
        emit(DeleteDocumentsError(
            message:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(DeleteDocumentsError(message: e.toString()));
    }
  }

  Future<FutureOr<void>> _openDocumentsForInformation(
      OpenDocumentsForInformation event, Emitter<DocumentsStates> emit) async {
    emit(const OpeningDocumentsForInformation());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      Map openDocumentForInfoMap = {
        "hashcode": hashCode,
        "documentid": documentId,
        "userid": userId
      };
      PostDocumentsModel postDocumentsModel = await _documentsRepository
          .openDocumentFopInformation(openDocumentForInfoMap);
      if (postDocumentsModel.message == '1') {
        emit(DocumentOpenedForInformation(
            postDocumentsModel: postDocumentsModel));
      } else {
        emit(OpenDocumentsForInformationError(
            message:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(OpenDocumentsForInformationError(message: e.toString()));
    }
  }

  Future<FutureOr<void>> _openDocumentsForReview(
      OpenDocumentsForReview event, Emitter<DocumentsStates> emit) async {
    emit(const OpeningDocumentsForReview());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      Map openDocumentFopInformationMap = {
        "hashcode": hashCode,
        "documentid": documentId,
        "duedate": event.dueDate,
        "userid": userId
      };
      if (event.dueDate.isEmpty || event.dueDate == '') {
        emit(const OpenDocumentsForReviewError(message: 'Please select date'));
      } else {
        PostDocumentsModel postDocumentsModel = await _documentsRepository
            .openDocumentFopReview(openDocumentFopInformationMap);
        if (postDocumentsModel.message == '1') {
          emit(DocumentOpenedForReview());
        } else {
          emit(OpenDocumentsForReviewError(
              message:
                  DatabaseUtil.getText('some_unknown_error_please_try_again')));
        }
      }
    } catch (e) {
      emit(OpenDocumentsForReviewError(message: e.toString()));
    }
  }

  Future<FutureOr<void>> _approveDocuments(
      ApproveDocument event, Emitter<DocumentsStates> emit) async {
    emit(const ApprovingDocuments());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      Map approveDocumentsMap = {
        "hashcode": hashCode,
        "documentid": documentId,
        "comments": event.comment,
        "userid": userId,
        "role": roleId
      };
      PostDocumentsModel postDocumentsModel =
          await _documentsRepository.approveDocuments(approveDocumentsMap);
      if (postDocumentsModel.message == '1') {
        emit(DocumentsApproved());
      } else {
        emit(ApproveDocumentsError(
            message:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(ApproveDocumentsError(message: e.toString()));
    }
  }

  Future<FutureOr<void>> _rejectDocument(
      RejectDocument event, Emitter<DocumentsStates> emit) async {
    emit(RejectingDocuments());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      Map rejectDocumentsMap = {
        "hashcode": hashCode,
        "documentid": documentId,
        "comments": event.comment,
        "userid": userId,
        "role": roleId
      };
      PostDocumentsModel postDocumentsModel =
          await _documentsRepository.rejectDocuments(rejectDocumentsMap);
      if (postDocumentsModel.message == '1') {
        emit(DocumentsRejected());
      } else {
        emit(RejectDocumentsError(
            message:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(RejectDocumentsError(message: e.toString()));
    }
  }

  Future<FutureOr<void>> _withdrawDocument(
      WithdrawDocument event, Emitter<DocumentsStates> emit) async {
    emit(const WithdrawingDocuments());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      Map withdrawDocumentsMap = {
        "documentid": hashCode,
        "userid": userId,
        "hashcode": hashCode,
        "role": roleId
      };
      PostDocumentsModel postDocumentsModel =
          await _documentsRepository.withdrawDocuments(withdrawDocumentsMap);
      if (postDocumentsModel.message == '1') {
        emit(DocumentsWithdrawn());
      } else {
        emit(WithdrawDocumentsError(
            message:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(WithdrawDocumentsError(message: e.toString()));
    }
  }

  Future<FutureOr<void>> _closeDocument(
      CloseDocument event, Emitter<DocumentsStates> emit) async {
    emit(ClosingDocuments());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      Map closeDocumentsMsp = {
        "documentid": documentId,
        "userid": userId,
        "hashcode": hashCode
      };
      PostDocumentsModel postDocumentsModel =
          await _documentsRepository.closeDocuments(closeDocumentsMsp);
      if (postDocumentsModel.message == '1') {
        emit(DocumentsClosed());
      } else {
        emit(CloseDocumentsError(
            message:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(CloseDocumentsError(message: e.toString()));
    }
  }

  Future<FutureOr<void>> _saveDocumentComments(
      SaveDocumentComments event, Emitter<DocumentsStates> emit) async {
    emit(const SavingDocumentComments());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      if (event.saveDocumentsCommentsMap['comments'] != null) {
        Map saveDocumentCommentsMap = {
          "userid": userId,
          "documentid": documentId,
          "comments": event.saveDocumentsCommentsMap['comments'],
          "files": event.saveDocumentsCommentsMap['files'],
          "refno": event.saveDocumentsCommentsMap['refno'],
          "hashcode": hashCode
        };
        SaveDocumentCommentsModel saveDocumentCommentsModel =
            await _documentsRepository
                .saveDocumentComments(saveDocumentCommentsMap);
        if (saveDocumentCommentsModel.message == '1') {
          emit(DocumentCommentsSaved());
        } else {
          emit(SaveDocumentCommentsError(
              errorMessage: saveDocumentCommentsModel.message));
        }
      } else {
        emit(SaveDocumentCommentsError(
            errorMessage: DatabaseUtil.getText('ValidComments')));
      }
    } catch (e) {
      emit(SaveDocumentCommentsError(errorMessage: e.toString()));
    }
  }
}
