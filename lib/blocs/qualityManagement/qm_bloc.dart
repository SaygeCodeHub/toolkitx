import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_events.dart';
import 'package:toolkit/blocs/qualityManagement/qm_states.dart';
import 'package:toolkit/repositories/qualityManagement/qm_repository.dart';
import '../../../../../data/cache/customer_cache.dart';
import '../../../../di/app_module.dart';
import '../../../data/cache/cache_keys.dart';
import '../../data/models/encrypt_class.dart';
import '../../data/models/incident/save_incident_comments_files_model.dart';
import '../../data/models/incident/save_incident_comments_model.dart';
import '../../data/models/pdf_generation_model.dart';
import '../../data/models/qualityManagement/fetch_qm_classification_model.dart';
import '../../data/models/qualityManagement/fetch_qm_details_model.dart';
import '../../data/models/qualityManagement/fetch_qm_list_model.dart';
import '../../utils/database_utils.dart';

class QualityManagementBloc
    extends Bloc<QualityManagementEvent, QualityManagementStates> {
  final QualityManagementRepository _qualityManagementRepository =
      getIt<QualityManagementRepository>();
  final SaveIncidentAndQMCommentsFilesModel
      saveIncidentAndQMCommentsFilesModel =
      SaveIncidentAndQMCommentsFilesModel();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  Map filters = {};
  String roleId = '';
  int qmTabIndex = 0;
  String commentId = '';
  String nextStatus = '';
  String qmId = '';

  QualityManagementStates get initialState => QualityManagementInitial();

  QualityManagementBloc() : super(QualityManagementInitial()) {
    on<FetchQualityManagementList>(_fetchList);
    on<FetchQualityManagementDetails>(_fetchDetails);
    on<SelectQualityManagementClassification>(_selectClassification);
    on<SaveQualityManagementComments>(_saveComments);
    on<SaveQualityManagementCommentsFiles>(_saveCommentsFile);
    on<GenerateQualityManagementPDF>(_generatePdf);
    on<FetchQualityManagementClassificationValue>(_fetchClassification);
  }

  FutureOr<void> _fetchList(FetchQualityManagementList event,
      Emitter<QualityManagementStates> emit) async {
    emit(FetchingQualityManagementList());
    try {
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchQualityManagementListModel fetchQualityManagementListModel =
          await _qualityManagementRepository.fetchQualityManagementList(
              event.pageNo, userId!, hashCode!, '', '');
      emit(QualityManagementListFetched(
        fetchQualityManagementListModel: fetchQualityManagementListModel,
      ));
    } catch (e) {
      e.toString();
    }
  }

  FutureOr<void> _fetchDetails(FetchQualityManagementDetails event,
      Emitter<QualityManagementStates> emit) async {
    emit(FetchingQualityManagementDetails());
    try {
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? hashKey = await _customerCache.getClientId(CacheKeys.clientId);
      List popUpMenuItems = [
        DatabaseUtil.getText('AddComments'),
      ];
      qmTabIndex = event.initialIndex;
      FetchQualityManagementDetailsModel fetchQualityManagementDetailsModel =
          await _qualityManagementRepository.fetchQualityManagementDetails(
              event.qmId, hashCode!, userId!, '');
      nextStatus = fetchQualityManagementDetailsModel.data.nextStatus;
      qmId = fetchQualityManagementDetailsModel.data.id;
      if (fetchQualityManagementDetailsModel.data.canEdit == '1') {
        popUpMenuItems.add(DatabaseUtil.getText('Edit'));
      }
      if (fetchQualityManagementDetailsModel.data.nextStatus == '0') {
        popUpMenuItems.add(DatabaseUtil.getText('Report'));
      }
      if (fetchQualityManagementDetailsModel.data.nextStatus == '1') {
        popUpMenuItems.add(DatabaseUtil.getText('Acknowledge'));
      }
      if (fetchQualityManagementDetailsModel.data.nextStatus == '2') {
        popUpMenuItems.add(DatabaseUtil.getText('DefineMitigation'));
      }
      if (fetchQualityManagementDetailsModel.data.nextStatus == '3') {
        popUpMenuItems.add(DatabaseUtil.getText('ApproveMitigation'));
      }
      if (fetchQualityManagementDetailsModel.data.nextStatus == '4') {
        popUpMenuItems.add(DatabaseUtil.getText('ImplementMitigation'));
      }
      if (fetchQualityManagementDetailsModel.data.canResolve == '1') {
        popUpMenuItems.add(DatabaseUtil.getText('Markasresolved'));
      }
      popUpMenuItems.add(DatabaseUtil.getText('GenerateReport'));
      emit(QualityManagementDetailsFetched(
          fetchQualityManagementDetailsModel:
              fetchQualityManagementDetailsModel,
          clientId: hashKey!,
          qmPopUpMenu: popUpMenuItems,
          showPopUpMenu: true));
    } catch (e) {
      emit(QualityManagementDetailsNotFetched(detailsNotFetched: e.toString()));
    }
  }

  FutureOr<void> _saveComments(SaveQualityManagementComments event,
      Emitter<QualityManagementStates> emit) async {
    emit(QualityManagementSavingComments());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userid = await _customerCache.getUserId(CacheKeys.userId);
      String? privateKey = await _customerCache.getApiKey(CacheKeys.apiKey);
      Map saveCommentMap = event.saveCommentsMap;
      String id = EncryptData.encryptAESPrivateKey(qmId, privateKey);
      saveCommentMap['incidentid'] = id;
      saveCommentMap['status'] = nextStatus;
      if (saveCommentMap['comments'] == null ||
          saveCommentMap['comments'].isEmpty) {
        emit(QualityManagementCommentsNotSaved(
            commentsNotSaved: DatabaseUtil.getText('CommentsInsert')));
      } else {
        Map saveCommentsMap = {
          "userid": userid,
          "incidentid": saveCommentMap['incidentid'],
          "hashcode": hashCode,
          "status": (saveCommentMap['status'] == null ||
                  saveCommentMap['status'].isEmpty)
              ? ''
              : saveCommentMap['status'],
          "comments": saveCommentMap['comments'],
          "classification": saveCommentMap['classification'] ?? ''
        };
        SaveIncidentAndQMCommentsModel saveIncidentAndQMCommentsModel =
            await _qualityManagementRepository.saveComments(saveCommentsMap);
        if (saveIncidentAndQMCommentsModel.status == 200) {
          commentId = saveIncidentAndQMCommentsModel.message;
          emit(QualityManagementCommentsSaved(
              saveIncidentAndQMCommentsModel: saveIncidentAndQMCommentsModel,
              saveIncidentAndQMCommentsFilesModel:
                  saveIncidentAndQMCommentsFilesModel,
              qmId: saveCommentMap['incidentid']));
          if (saveCommentMap['filenames'] != null) {
            add(SaveQualityManagementCommentsFiles(
                saveCommentsMap: saveCommentMap,
                saveIncidentAndQMCommentsModel:
                    saveIncidentAndQMCommentsModel));
          }
        } else {
          emit(QualityManagementCommentsNotSaved(
              commentsNotSaved:
                  DatabaseUtil.getText('some_unknown_error_please_try_again')));
        }
      }
    } catch (e) {
      emit(QualityManagementCommentsNotSaved(commentsNotSaved: e.toString()));
    }
  }

  FutureOr<void> _saveCommentsFile(SaveQualityManagementCommentsFiles event,
      Emitter<QualityManagementStates> emit) async {
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userid = await _customerCache.getUserId(CacheKeys.userId);
      String? privateKey = await _customerCache.getApiKey(CacheKeys.apiKey);
      Map saveFilesMap = event.saveCommentsMap;
      String id = EncryptData.encryptAESPrivateKey(qmId, privateKey);
      saveFilesMap['incidentId'] = id;
      Map saveCommentsFilesMap = {
        "userid": userid,
        "incidentid": saveFilesMap['incidentId'],
        "commentid": commentId,
        "filenames": saveFilesMap['filenames'],
        "hashcode": hashCode
      };
      SaveIncidentAndQMCommentsFilesModel saveIncidentAndQMCommentsFilesModel =
          await _qualityManagementRepository
              .saveCommentsFile(saveCommentsFilesMap);
      if (saveIncidentAndQMCommentsFilesModel.status == 200) {
        emit(QualityManagementCommentsSaved(
            saveIncidentAndQMCommentsModel:
                event.saveIncidentAndQMCommentsModel,
            saveIncidentAndQMCommentsFilesModel:
                saveIncidentAndQMCommentsFilesModel,
            qmId: saveFilesMap['incidentId']));
      } else {
        emit(QualityManagementCommentsNotSaved(
            commentsNotSaved:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(QualityManagementCommentsNotSaved(commentsNotSaved: e.toString()));
    }
  }

  FutureOr<void> _generatePdf(GenerateQualityManagementPDF event,
      Emitter<QualityManagementStates> emit) async {
    try {
      emit(GeneratingQualityManagementPDF());
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? aipKey = await _customerCache.getApiKey(CacheKeys.apiKey);
      String? privateKey = await _customerCache.getApiKey(CacheKeys.apiKey);
      String id = EncryptData.encryptAESPrivateKey(qmId, privateKey);
      final PdfGenerationModel pdfGenerationModel =
          await _qualityManagementRepository.generatePdf(id, hashCode!);
      String pdfLink =
          EncryptData.encryptAESPrivateKey(pdfGenerationModel.message, aipKey);
      if (pdfGenerationModel.status == 200) {
        emit(QualityManagementPDFGenerated(
            pdfGenerationModel: pdfGenerationModel, pdfLink: pdfLink));
      } else {
        emit(QualityManagementPDFGenerationFailed(
            pdfNoteGenerated:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(
          QualityManagementPDFGenerationFailed(pdfNoteGenerated: e.toString()));
      rethrow;
    }
  }

  FutureOr<void> _fetchClassification(
      FetchQualityManagementClassificationValue event,
      Emitter<QualityManagementStates> emit) async {
    emit(FetchingQualityManagementClassificationValue());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      final FetchQualityManagementClassificationModel
          fetchQualityManagementClassificationModel =
          await _qualityManagementRepository.fetchClassification(hashCode!);
      if (fetchQualityManagementClassificationModel.status == 200) {
        emit(QualityManagementClassificationValueFetched(
            fetchQualityManagementClassificationModel:
                fetchQualityManagementClassificationModel,
            classificationId: ''));
        add(SelectQualityManagementClassification(
            classificationId: '',
            fetchQualityManagementClassificationModel:
                fetchQualityManagementClassificationModel));
      } else {
        emit(QualityManagementClassificationValueNotFetched(
            classificationNotFetched:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(QualityManagementClassificationValueNotFetched(
          classificationNotFetched: e.toString()));
      rethrow;
    }
  }

  _selectClassification(SelectQualityManagementClassification event,
      Emitter<QualityManagementStates> emit) {
    emit(QualityManagementClassificationValueFetched(
        fetchQualityManagementClassificationModel:
            event.fetchQualityManagementClassificationModel,
        classificationId: event.classificationId));
  }
}
