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
import '../../data/models/qualityManagement/fetch_qm_details_model.dart';
import '../../data/models/qualityManagement/fetch_qm_list_model.dart';
import '../../data/models/qualityManagement/fetch_qm_master_model.dart';
import '../../data/models/qualityManagement/save_new_qm_reporting_model.dart';
import '../../data/models/qualityManagement/save_qm_photos_model.dart';
import '../../utils/database_utils.dart';
import '../../utils/database_utils.dart';

class QualityManagementBloc
    extends Bloc<QualityManagementEvent, QualityManagementStates> {
  final QualityManagementRepository _qualityManagementRepository =
      getIt<QualityManagementRepository>();
  final SaveIncidentAndQMCommentsFilesModel
      saveIncidentAndQMCommentsFilesModel =
      SaveIncidentAndQMCommentsFilesModel();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  FetchQualityManagementMasterModel fetchQualityManagementMasterModel =
      FetchQualityManagementMasterModel();
  Map filters = {};
  String roleId = '';
  int qmTabIndex = 0;
  Map reportNewQAMap = {};
  String selectSiteName = '';
  String newQmId = '';
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
    on<FetchQualityManagementMaster>(_fetchMaster);
    on<ReportNewQAAnonymously>(_selectAnonymous);
    on<ReportNewQualityManagementContractorListChange>(_reportContractor);
    on<ReportNewQualityManagementDateTimeDescriptionValidation>(
        _dateTimeDescValidation);
    on<ReportQualityManagementSiteListChange>(_selectSite);
    on<ReportNewQualityManagementLocationChange>(_selectLocation);
    on<ReportNewQualityManagementSeverityChange>(_selectSeverity);
    on<ReportNewQualityManagementImpactChange>(_selectImpact);
    on<ReportNewQualityManagementSiteLocationValidation>(
        _siteLocationValidation);
    on<ReportNewQualityManagementFetchCustomInfoField>(_fetchCustomFieldInfo);
    on<ReportNewQualityManagementCustomInfoFiledExpansionChange>(
        _selectCustomFieldInfo);
    on<SaveReportNewQualityManagement>(_saveQualityManagementReporting);
    on<SaveReportNewQualityManagementPhotos>(_saveQualityManagementPhotos);
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
      qmTabIndex = event.initialIndex;
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

  FutureOr<void> _fetchMaster(FetchQualityManagementMaster event,
      Emitter<QualityManagementStates> emit) async {
    emit(FetchingQualityManagementMaster());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      fetchQualityManagementMasterModel = await _qualityManagementRepository
          .fetchQualityManagementMaster(hashCode!, '');
      fetchQualityManagementMasterModel.data![0].insert(
          0, QMMasterDatum.fromJson({"name": DatabaseUtil.getText('Other')}));
      fetchQualityManagementMasterModel.data![1].insert(0,
          QMMasterDatum.fromJson({"location": DatabaseUtil.getText('Other')}));
      emit(QualityManagementMasterFetched(
          fetchQualityManagementMasterModel:
              fetchQualityManagementMasterModel));
    } catch (e) {
      emit(QualityManagementMasterNotFetched(masterNotFetched: e.toString()));
    }
  }

  _selectAnonymous(
      ReportNewQAAnonymously event, Emitter<QualityManagementStates> emit) {
    emit(ReportedNewQAAnonymously(anonymousId: event.anonymousId));
  }

  _reportContractor(ReportNewQualityManagementContractorListChange event,
      Emitter<QualityManagementStates> emit) {
    emit(ReportNewQualityManagementContractorSelected(
        fetchQualityManagementMasterModel: fetchQualityManagementMasterModel,
        selectContractorId: event.selectContractorId,
        selectContractorName: event.selectContractorName));
  }

  _dateTimeDescValidation(
      ReportNewQualityManagementDateTimeDescriptionValidation event,
      Emitter<QualityManagementStates> emit) {
    reportNewQAMap = event.reportNewQAMap;
    if (reportNewQAMap['eventdatetime'] == null &&
        reportNewQAMap['description'] == null) {
      emit(ReportNewQualityManagementDateTimeDescValidated(
          dateTimeDescValidationMessage:
              DatabaseUtil.getText('ReportDateTimeCompulsary')));
    } else {
      emit(ReportNewQualityManagementDateTimeDescValidationComplete());
    }
  }

  _selectSite(ReportQualityManagementSiteListChange event,
      Emitter<QualityManagementStates> emit) {
    selectSiteName = event.selectSiteName;
    emit(ReportNewQualityManagementSiteSelected(
        fetchQualityManagementMasterModel: fetchQualityManagementMasterModel,
        selectSiteName: event.selectSiteName));
  }

  _selectLocation(ReportNewQualityManagementLocationChange event,
      Emitter<QualityManagementStates> emit) {
    emit(ReportNewQualityManagementLocationSelected(
        fetchQualityManagementMasterModel: fetchQualityManagementMasterModel,
        selectLocationName: event.selectLocationName));
  }

  _selectSeverity(ReportNewQualityManagementSeverityChange event,
      Emitter<QualityManagementStates> emit) {
    emit(ReportNewQualityManagementSeveritySelected(
        fetchQualityManagementMasterModel: fetchQualityManagementMasterModel,
        severityId: event.severityId));
  }

  _selectImpact(ReportNewQualityManagementImpactChange event,
      Emitter<QualityManagementStates> emit) {
    emit(ReportNewQualityManagementImpactSelected(
        fetchQualityManagementMasterModel: fetchQualityManagementMasterModel,
        impactId: event.impactId));
  }

  _siteLocationValidation(
      ReportNewQualityManagementSiteLocationValidation event,
      Emitter<QualityManagementStates> emit) {
    reportNewQAMap = event.reportNewQAMap;
    if (reportNewQAMap['site_name'] == '' &&
        reportNewQAMap['location_name'] == '') {
      emit(ReportNewQualityManagementSiteLocationValidated(
          siteLocationValidationMessage:
              DatabaseUtil.getText('SiteLocationCompulsory')));
    } else {
      emit(ReportNewQualityManagementSiteLocationValidationComplete());
    }
  }

  _fetchCustomFieldInfo(ReportNewQualityManagementFetchCustomInfoField event,
      Emitter<QualityManagementStates> emit) {
    emit(ReportNewQualityManagementCustomFieldFetched(
        fetchQualityManagementMasterModel: fetchQualityManagementMasterModel));
  }

  _selectCustomFieldInfo(
      ReportNewQualityManagementCustomInfoFiledExpansionChange event,
      Emitter<QualityManagementStates> emit) {
    emit(ReportNewQualityManagementCustomFieldSelected(
        fetchQualityManagementMasterModel: fetchQualityManagementMasterModel,
        reportQMCustomInfoOptionId: event.reportQMCustomInfoOptionId!));
  }

  FutureOr<void> _saveQualityManagementReporting(
      SaveReportNewQualityManagement event,
      Emitter<QualityManagementStates> emit) async {
    emit(ReportNewQualityManagementSaving());
    try {
      reportNewQAMap = event.reportNewQAMap;
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userType = await _customerCache.getUserType(CacheKeys.userType);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map saveReportNewQMMap = {
        "eventdatetime": reportNewQAMap['eventdatetime'],
        "description": reportNewQAMap['description'],
        "responsible_person": reportNewQAMap['responsible_person'] ?? '',
        "site": reportNewQAMap['site'] ?? '',
        "location": reportNewQAMap['location'] ?? '',
        "role": "",
        "site_name": reportNewQAMap['site_name'],
        "location_name": reportNewQAMap['location_name'],
        "companyid": reportNewQAMap['companyid'] ?? '',
        "severity": reportNewQAMap['severity'] ?? '',
        "impact": reportNewQAMap['impact'] ?? '',
        "customfields": reportNewQAMap['customfields'] ?? '',
        "createduserby": (userType == '1') ? userId : '0',
        "createdworkforceby": (userType == '2') ? userId : '0',
        "hashcode": hashCode
      };
      SaveNewQualityManagementReportingModel
          saveNewQualityManagementReportingModel =
          await _qualityManagementRepository
              .saveNewQMReporting(saveReportNewQMMap);
      if (saveNewQualityManagementReportingModel.status == 200) {
        newQmId = saveNewQualityManagementReportingModel.message;
      } else {
        emit(ReportNewQualityManagementNotSaved(
            qualityManagementNotSavedMessage:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
      (reportNewQAMap['filenames'] != null)
          ? add(SaveReportNewQualityManagementPhotos(
              reportNewQAMap: reportNewQAMap))
          : null;
      emit(ReportNewQualityManagementSaved(
          saveNewQualityManagementReporting:
              saveNewQualityManagementReportingModel));
    } catch (e) {
      emit(ReportNewQualityManagementNotSaved(
          qualityManagementNotSavedMessage:
              DatabaseUtil.getText('some_unknown_error_please_try_again')));
    }
  }

  FutureOr<void> _saveQualityManagementPhotos(
      SaveReportNewQualityManagementPhotos event,
      Emitter<QualityManagementStates> emit) async {
    try {
      reportNewQAMap = event.reportNewQAMap;
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      Map saveQMPhotosMap = {
        "incidentid": newQmId,
        "filenames": reportNewQAMap['filenames'],
        "hashcode": hashCode
      };
      SaveQualityManagementPhotos saveQualityManagementPhotos =
          await _qualityManagementRepository
              .saveQualityManagementPhotos(saveQMPhotosMap);
      emit(ReportNewQualityManagementPhotoSaved(
          saveQualityManagementPhotos: saveQualityManagementPhotos));
    } catch (e) {
      emit(ReportNewQualityManagementNotSaved(
          qualityManagementNotSavedMessage: e.toString()));
    }
  }
}
