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
  int incidentTabIndex = 0;
  String commentId = '';

  QualityManagementStates get initialState => QualityManagementInitial();

  QualityManagementBloc() : super(QualityManagementInitial()) {
    on<FetchQualityManagementList>(_fetchList);
    on<FetchQualityManagementDetails>(_fetchDetails);
    on<SelectQualityManagementClassification>(_selectClassification);
    on<SaveQualityManagementComments>(_saveComments);
    on<SaveQualityManagementCommentsFiles>(_saveCommentsFile);
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
      incidentTabIndex = event.initialIndex;
      FetchQualityManagementDetailsModel fetchQualityManagementDetailsModel =
          await _qualityManagementRepository.fetchQualityManagementDetails(
              event.qmId, hashCode!, userId!, '');
      if (fetchQualityManagementDetailsModel.data.canEdit == '1') {
        popUpMenuItems.add(DatabaseUtil.getText('EditIncident'));
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

  _selectClassification(SelectQualityManagementClassification event,
      Emitter<QualityManagementStates> emit) {
    emit(QualityManagementClassificationSelected(
        classificationId: event.classificationId));
  }

  FutureOr<void> _saveComments(SaveQualityManagementComments event,
      Emitter<QualityManagementStates> emit) async {
    emit(QualityManagementSavingComments());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userid = await _customerCache.getUserId(CacheKeys.userId);
      String? privateKey = await _customerCache.getApiKey(CacheKeys.apiKey);
      Map saveCommentMap = event.saveCommentsMap;
      String id = EncryptData.encryptAESPrivateKey(
          saveCommentMap['incidentId'], privateKey);
      saveCommentMap['incidentid'] = id;
      if (saveCommentMap['comments'] == null ||
          saveCommentMap['comments'].isEmpty) {
        emit(QualityManagementCommentsNotSaved(
            commentsNotSaved: DatabaseUtil.getText('CommentsInsert')));
      } else {
        Map saveCommentsMap = {
          "userid": userid,
          "incidentid": saveCommentMap['incidentid'],
          "hashcode": hashCode,
          "status": saveCommentMap['status'] ?? '',
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
      String id = EncryptData.encryptAESPrivateKey(
          saveFilesMap['incidentId'], privateKey);
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
}
