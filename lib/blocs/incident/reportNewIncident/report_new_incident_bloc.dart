import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_events.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_states.dart';
import 'package:toolkit/data/models/incident/fetch_incident_location_model.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../../../data/cache/customer_cache.dart';
import '../../../../di/app_module.dart';
import '../../../data/cache/cache_keys.dart';
import '../../../data/models/incident/fetch_incident_master_model.dart';
import '../../../data/models/incident/save_report_new_incident_model.dart';
import '../../../data/models/incident/save_report_new_incident_photos_model.dart';
import '../../../repositories/incident/incident_repository.dart';

class ReportNewIncidentBloc
    extends Bloc<ReportNewIncidentEvent, ReportNewIncidentStates> {
  final IncidentRepository _incidentRepository = getIt<IncidentRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  FetchIncidentMasterModel fetchIncidentMasterModel =
      FetchIncidentMasterModel();
  Map reportNewIncidentMap = {};
  String selectSiteName = '';
  String incidentId = '';
  int imageIndex = 0;
  String selectedAsset = '';
  List<LocationDatum> locationList = [];
  int siteId = 0;

  ReportNewIncidentStates get initialState => ReportNewIncidentInitial();

  ReportNewIncidentBloc() : super(ReportNewIncidentInitial()) {
    on<FetchIncidentMaster>(_fetchIncidentCategory);
    on<SelectIncidentCategory>(_selectIncidentCategory);
    on<ReportNewIncidentAnonymousExpansionChange>(_reportIncidentAnonymously);
    on<ReportNewIncidentContractorListChange>(_reportIncidentContractor);
    on<ReportIncidentSiteListChange>(_reportIncidentSite);
    on<ReportNewIncidentLocationChange>(_reportIncidentLocation);
    on<ReportNewIncidentAuthorityExpansionChange>(_reportIncidentAuthority);
    on<ReportNewIncidentDateTimeDescriptionValidation>(_dateTimeDescValidation);
    on<ReportNewIncidentSiteLocationValidation>(_siteLocationValidation);
    on<ReportNewIncidentCustomInfoFieldFetch>(_reportIncidentCustomInfoFetch);
    on<ReportNewIncidentCustomInfoFiledExpansionChange>(
        _reportIncidentCustomInfo);
    on<SaveReportNewIncident>(_saveIncident);
    on<SaveReportNewIncidentPhotos>(_saveIncidentPhotos);
    on<FetchIncidentInjuredPerson>(_fetchIncidentInjuredPersonDetails);
    on<IncidentRemoveInjuredPersonDetails>(_removeInjuredPerson);
    on<FetchIncidentLocations>(_fetchIncidentLocations);
    on<SelectLocationId>(_selectLocationId);
    on<FetchIncidentAssetsList>(_fetchIncidentAssetsList);
  }

  FutureOr<void> _fetchIncidentCategory(
      FetchIncidentMaster event, Emitter<ReportNewIncidentStates> emit) async {
    emit(FetchingIncidentMaster());
    try {
      List categories = [];
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      fetchIncidentMasterModel =
          await _incidentRepository.fetchIncidentMaster(hashCode, event.role);
      fetchIncidentMasterModel.incidentMasterDatum![0].insert(
          0,
          IncidentMasterDatum.fromJson(
              {"name": DatabaseUtil.getText('Other')}));
      fetchIncidentMasterModel.incidentMasterDatum![1].insert(
          0,
          IncidentMasterDatum.fromJson(
              {"location": DatabaseUtil.getText('Other')}));
      if (event.categories != "null") {
        categories = event.categories.toString().replaceAll(" ", "").split(',');
      }
      add(SelectIncidentCategory(
          multiSelectList: categories, selectedCategory: ''));
    } catch (e) {
      emit(IncidentMasterNotFetched());
    }
  }

  _selectIncidentCategory(SelectIncidentCategory event,
      Emitter<ReportNewIncidentStates> emit) async {
    String? clientId = await _customerCache.getClientId(CacheKeys.clientId);
    List showCategory = [];
    showCategory = [
      {
        'title': fetchIncidentMasterModel.incidentMasterDatum![2][0].typename,
        'items': [
          for (int i = 0;
              i < fetchIncidentMasterModel.incidentMasterDatum![2].length;
              i++)
            fetchIncidentMasterModel.incidentMasterDatum![2][i]
        ]
      },
      {
        'title': fetchIncidentMasterModel.incidentMasterDatum![3][0].typename,
        'items': [
          for (int i = 0;
              i < fetchIncidentMasterModel.incidentMasterDatum![3].length;
              i++)
            fetchIncidentMasterModel.incidentMasterDatum![3][i]
        ]
      },
      {
        'title': fetchIncidentMasterModel.incidentMasterDatum![4][0].typename,
        'items': [
          for (int i = 0;
              i < fetchIncidentMasterModel.incidentMasterDatum![4].length;
              i++)
            fetchIncidentMasterModel.incidentMasterDatum![4][i]
        ]
      },
      {
        'title': fetchIncidentMasterModel.incidentMasterDatum![5][0].typename,
        'items': [
          for (int i = 0;
              i < fetchIncidentMasterModel.incidentMasterDatum![5].length;
              i++)
            fetchIncidentMasterModel.incidentMasterDatum![5][i]
        ]
      },
      {
        'title': fetchIncidentMasterModel.incidentMasterDatum![6][0].typename,
        'items': [
          for (int i = 0;
              i < fetchIncidentMasterModel.incidentMasterDatum![6].length;
              i++)
            fetchIncidentMasterModel.incidentMasterDatum![6][i]
        ]
      }
    ];
    List selectedCategoryList = List.from(event.multiSelectList);
    if (event.selectedCategory != '') {
      if (event.multiSelectList.contains(event.selectedCategory) != true) {
        selectedCategoryList.add(event.selectedCategory);
      } else {
        selectedCategoryList.remove(event.selectedCategory);
      }
    }
    emit(IncidentMasterFetched(
        fetchIncidentMasterModel: fetchIncidentMasterModel,
        categoryList: showCategory,
        categorySelectedList: selectedCategoryList,
        imageIndex: imageIndex,
        clientId: clientId!));
  }

  _reportIncidentAnonymously(ReportNewIncidentAnonymousExpansionChange event,
      Emitter<ReportNewIncidentStates> emit) {
    Map reportAnonymousMap = {
      "1": DatabaseUtil.getText('Yes'),
      "2": DatabaseUtil.getText('No'),
    };
    emit(ReportNewIncidentAnonymousSelected(
        reportAnonymousId: event.reportIncidentAnonymousId,
        reportAnonymousMap: reportAnonymousMap));
  }

  _reportIncidentContractor(ReportNewIncidentContractorListChange event,
      Emitter<ReportNewIncidentStates> emit) {
    emit(ReportNewIncidentContractorSelected(
        fetchIncidentMasterModel: fetchIncidentMasterModel,
        selectContractorId: event.selectContractorId,
        selectContractorName: event.selectContractorName));
  }

  _reportIncidentSite(ReportIncidentSiteListChange event,
      Emitter<ReportNewIncidentStates> emit) {
    selectSiteName = event.selectSiteName;
    emit(ReportNewIncidentSiteSelected(
        fetchIncidentMasterModel: fetchIncidentMasterModel,
        selectSiteName: event.selectSiteName));

    if (event.siteId != 0) {
      siteId = event.siteId;
      add(FetchIncidentLocations(siteId: event.siteId, event.locationId));
    }
  }

  _reportIncidentLocation(ReportNewIncidentLocationChange event,
      Emitter<ReportNewIncidentStates> emit) {
    event.selectLocationName;
    emit(ReportNewIncidentLocationSelected(
        fetchIncidentMasterModel: fetchIncidentMasterModel,
        selectLocationName: event.selectLocationName));
  }

  _reportIncidentAuthority(ReportNewIncidentAuthorityExpansionChange event,
      Emitter<ReportNewIncidentStates> emit) {
    Map reportAuthorityMap = {
      "1": DatabaseUtil.getText('Yes'),
      "2": DatabaseUtil.getText('No'),
    };
    emit(ReportNewIncidentAuthoritySelected(
        reportIncidentAuthorityId: event.reportIncidentAuthorityId,
        reportIncidentAuthorityMap: reportAuthorityMap));
  }

  _dateTimeDescValidation(ReportNewIncidentDateTimeDescriptionValidation event,
      Emitter<ReportNewIncidentStates> emit) {
    reportNewIncidentMap = event.reportNewIncidentMap;
    if (reportNewIncidentMap['eventdatetime'] == null ||
        reportNewIncidentMap['description'] == null ||
        reportNewIncidentMap['companyid'] == '') {
      emit(ReportNewIncidentDateTimeDescValidated(
          dateTimeDescValidationMessage:
              StringConstants.kDateTimeDescriptionContractorIsNotEmpty));
    } else {
      emit(ReportNewIncidentDateTimeDescValidationComplete());
    }
  }

  _siteLocationValidation(ReportNewIncidentSiteLocationValidation event,
      Emitter<ReportNewIncidentStates> emit) {
    reportNewIncidentMap = event.reportNewIncidentMap;
    if (reportNewIncidentMap['site_name'] == '' &&
        reportNewIncidentMap['location_name'] == '') {
      emit(ReportNewIncidentSiteLocationValidated(
          siteLocationValidationMessage:
              DatabaseUtil.getText('SiteLocationCompulsory')));
    } else {
      emit(ReportNewIncidentSiteLocationValidationComplete());
    }
  }

  _reportIncidentCustomInfoFetch(ReportNewIncidentCustomInfoFieldFetch event,
      Emitter<ReportNewIncidentStates> emit) {
    emit(ReportNewIncidentCustomFieldFetched(
        fetchIncidentMasterModel: fetchIncidentMasterModel));
  }

  _reportIncidentCustomInfo(
      ReportNewIncidentCustomInfoFiledExpansionChange event,
      Emitter<ReportNewIncidentStates> emit) {
    emit(ReportNewIncidentCustomFieldSelected(
        fetchIncidentMasterModel: fetchIncidentMasterModel,
        reportIncidentCustomInfoOptionId:
            event.reportIncidentCustomInfoOptionId!));
  }

  FutureOr<void> _saveIncident(SaveReportNewIncident event,
      Emitter<ReportNewIncidentStates> emit) async {
    emit(ReportNewIncidentSaving());
    try {
      reportNewIncidentMap = event.reportNewIncidentMap;
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userType = await _customerCache.getUserType(CacheKeys.userType);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      if (reportNewIncidentMap['responsible_person'] == '1') {
        userId = '-1';
      }
      Map addNewIncidentMap = {
        "eventdatetime": reportNewIncidentMap['eventdatetime'],
        "description": reportNewIncidentMap['description'],
        "responsible_person":
            (reportNewIncidentMap['responsible_person'] == null)
                ? ""
                : reportNewIncidentMap['responsible_person'],
        "site_name": reportNewIncidentMap['site_name'],
        "location_name": reportNewIncidentMap['location_name'],
        "reporteddatetime": (reportNewIncidentMap['reporteddatetime'] == null)
            ? ""
            : reportNewIncidentMap['reporteddatetime'],
        "assetid": reportNewIncidentMap['assetid'],
        "category": reportNewIncidentMap['category'],
        "createduserby": (userType == '1') ? userId : '0',
        "createdworkforceby": (userType == '2') ? userId : '0',
        "hashcode": hashCode,
        "role": event.role,
        "identity": reportNewIncidentMap['identity'],
        "companyid": reportNewIncidentMap['companyid'],
        "persons": (reportNewIncidentMap['persons'] == null)
            ? []
            : reportNewIncidentMap['persons'],
        "customfields": (reportNewIncidentMap['customfields'] == null)
            ? []
            : (reportNewIncidentMap['customfields'].toString().contains("{},"))
                ? reportNewIncidentMap['customfields']
                    .toString()
                    .replaceAll("{}", "")
                    .replaceAll(",", "")
                    .replaceAll(" ", "")
                : reportNewIncidentMap['customfields']
      };
      SaveReportNewIncidentModel saveReportNewIncidentModel =
          await _incidentRepository.saveIncident(addNewIncidentMap);
      if (saveReportNewIncidentModel.status == 200) {
        incidentId = saveReportNewIncidentModel.message;
      } else {
        emit(ReportNewIncidentNotSaved(
            incidentNotSavedMessage:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
      (reportNewIncidentMap['ImageString'] != null)
          ? add(SaveReportNewIncidentPhotos(
              reportNewIncidentMap: reportNewIncidentMap))
          : null;
      emit(ReportNewIncidentSaved(
          saveReportNewIncidentModel: saveReportNewIncidentModel));
    } catch (e) {
      emit(ReportNewIncidentNotSaved(
          incidentNotSavedMessage:
              DatabaseUtil.getText('some_unknown_error_please_try_again')));
    }
  }

  FutureOr<void> _saveIncidentPhotos(SaveReportNewIncidentPhotos event,
      Emitter<ReportNewIncidentStates> emit) async {
    try {
      reportNewIncidentMap = event.reportNewIncidentMap;
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      Map saveIncidentPhotosMap = {
        "incidentid": incidentId,
        "filenames": reportNewIncidentMap['ImageString'],
        "hashcode": hashCode
      };
      SaveReportNewIncidentPhotosModel saveReportNewIncidentPhotosModel =
          await _incidentRepository.saveIncidentPhotos(saveIncidentPhotosMap);
      emit(ReportNewIncidentPhotoSaved(
          saveReportNewIncidentPhotosModel: saveReportNewIncidentPhotosModel));
    } catch (e) {
      emit(ReportNewIncidentNotSaved(incidentNotSavedMessage: e.toString()));
    }
  }

  _fetchIncidentInjuredPersonDetails(
      FetchIncidentInjuredPerson event, Emitter<ReportNewIncidentStates> emit) {
    emit(ReportNewIncidentInjuredPersonDetailsFetched(
        injuredPersonDetailsList: event.injuredPersonDetailsList));
  }

  _removeInjuredPerson(IncidentRemoveInjuredPersonDetails event,
      Emitter<ReportNewIncidentStates> emit) {
    event.injuredPersonDetailsList.removeAt(event.index!);
    emit(ReportNewIncidentInjuredPersonDetailsFetched(
        injuredPersonDetailsList: event.injuredPersonDetailsList));
  }

  Future<FutureOr<void>> _fetchIncidentLocations(FetchIncidentLocations event,
      Emitter<ReportNewIncidentStates> emit) async {
    locationList.clear();
    emit(IncidentLocationsFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      FetchIncidentLocationModel fetchIncidentLocationModel =
          await _incidentRepository.fetchIncidentLocation(
              hashCode, event.siteId);
      if (fetchIncidentLocationModel.status == 200) {
        emit(IncidentLocationsFetched(
            fetchIncidentLocationModel: fetchIncidentLocationModel));
        locationList.addAll(fetchIncidentLocationModel.data);
        if (event.locationId.isNotEmpty) {
          add(SelectLocationId(locationId: event.locationId));
        }
      } else {
        emit(IncidentLocationsNotFetched(
            errorMessage: fetchIncidentLocationModel.message));
      }
    } catch (e) {
      emit(IncidentLocationsNotFetched(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _selectLocationId(
      SelectLocationId event, Emitter<ReportNewIncidentStates> emit) {
    try {
      if (event.locationId != '') {
        if (locationList.isNotEmpty) {
          int locId = (event.locationId.runtimeType == String)
              ? int.parse(event.locationId)
              : event.locationId;
          var location =
              locationList.firstWhere((location) => location.id == locId);
          List<Asset> assetList = [];
          if (location.assets.isNotEmpty) {
            assetList = List<Asset>.from(location.assets);
            add(FetchIncidentAssetsList(
                assetList: assetList, selectedAsset: selectedAsset));
          } else {
            selectedAsset = '';
            add(FetchIncidentAssetsList(assetList: [], selectedAsset: ''));
          }
        }
      } else {
        selectedAsset = '';
        add(ReportNewIncidentLocationChange(selectLocationName: ''));
        emit(IncidentAssetListFetched(assetList: []));
      }
    } catch (e) {
      rethrow;
    }
  }

  FutureOr<void> _fetchIncidentAssetsList(
      FetchIncidentAssetsList event, Emitter<ReportNewIncidentStates> emit) {
    emit(IncidentAssetListFetched(assetList: event.assetList));
  }
}
