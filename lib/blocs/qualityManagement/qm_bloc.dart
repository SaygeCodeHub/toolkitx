import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_events.dart';
import 'package:toolkit/blocs/qualityManagement/qm_states.dart';
import 'package:toolkit/repositories/qualityManagement/qm_repository.dart';
import '../../../../../data/cache/customer_cache.dart';
import '../../../../di/app_module.dart';
import '../../../data/cache/cache_keys.dart';
import '../../data/models/qualityManagement/fetch_qm_details_model.dart';
import '../../data/models/qualityManagement/fetch_qm_list_model.dart';
import '../../data/models/qualityManagement/fetch_qm_master_model.dart';
import '../../data/models/qualityManagement/save_new_qm_reporting_model.dart';
import '../../data/models/qualityManagement/save_qm_photos_model.dart';
import '../../utils/database_utils.dart';

class QualityManagementBloc
    extends Bloc<QualityManagementEvent, QualityManagementStates> {
  final QualityManagementRepository _qualityManagementRepository =
      getIt<QualityManagementRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  FetchQualityManagementMasterModel fetchQualityManagementMasterModel =
      FetchQualityManagementMasterModel();
  Map filters = {};
  String roleId = '';
  int incidentTabIndex = 0;
  Map reportNewQAMap = {};
  String selectSiteName = '';
  String newQmId = '';

  QualityManagementStates get initialState => QualityManagementInitial();

  QualityManagementBloc() : super(QualityManagementInitial()) {
    on<FetchQualityManagementList>(_fetchList);
    on<FetchQualityManagementDetails>(_fetchDetails);
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
      incidentTabIndex = event.initialIndex;
      FetchQualityManagementDetailsModel fetchQualityManagementDetailsModel =
          await _qualityManagementRepository.fetchQualityManagementDetails(
              event.qmId, hashCode!, userId!, '');
      emit(QualityManagementDetailsFetched(
          fetchQualityManagementDetailsModel:
              fetchQualityManagementDetailsModel,
          clientId: hashKey!));
    } catch (e) {
      emit(QualityManagementDetailsNotFetched(detailsNotFetched: e.toString()));
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
