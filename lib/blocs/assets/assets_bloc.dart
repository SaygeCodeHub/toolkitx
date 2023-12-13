import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/assets/add_manage_document_model.dart';
import 'package:toolkit/data/models/assets/assets_add_comments_model.dart';
import 'package:toolkit/data/models/assets/assets_delete_document_model.dart';
import 'package:toolkit/data/models/assets/assets_delete_downtime_model.dart';
import 'package:toolkit/data/models/assets/assets_list_model.dart';
import 'package:toolkit/data/models/assets/fetch_add_assets_document_model.dart';
import 'package:toolkit/data/models/assets/fetch_asset_single_downtime_model.dart';
import 'package:toolkit/data/models/assets/fetch_assets_comment_model.dart';
import 'package:toolkit/data/models/assets/save_assets_downtime_model.dart';
import 'package:toolkit/data/models/assets/save_assets_report_failure_model.dart';
import 'package:toolkit/data/models/assets_get_downtime_model.dart';
import 'package:toolkit/repositories/assets/assets_repository.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/assets/assets_details_model.dart';
import '../../data/models/assets/assets_master_model.dart';
import '../../data/models/assets/fetch_assets_document_model.dart';
import '../../data/models/assets/save_assets_meter_reading_model.dart';
import '../../di/app_module.dart';
import '../../screens/assets/widgets/assets_add_and_edit_downtime_screen.dart';
import '../../utils/database_utils.dart';

part 'assets_event.dart';
part 'assets_state.dart';

class AssetsBloc extends Bloc<AssetsEvent, AssetsState> {
  final AssetsRepository _assetsRepository = getIt<AssetsRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  AssetsState get initialState => AssetsInitial();

  AssetsBloc() : super(AssetsInitial()) {
    on<FetchAssetsList>(_fetchAssetsList);
    on<FetchAssetsDetails>(_fetchAssetsDetails);
    on<FetchAssetsMaster>(_fetchAssetsMaster);
    on<SelectAssetsLocation>(_selectAssetsLocation);
    on<SelectAssetsStatus>(_selectAssetsStatus);
    on<SelectAssetsSite>(_selectAssetsSite);
    on<ApplyAssetsFilter>(_applyAssetsFilter);
    on<ClearAssetsFilter>(_clearAssetsFilter);
    on<FetchAssetsGetDownTime>(_fetchAssetsGetDownTime);
    on<SaveAssetsDownTime>(_saveAssetsDownTime);
    on<DeleteAssetsDownTime>(_deleteAssetsDownTime);
    on<FetchAssetsManageDocument>(_fetchAssetsManageDocument);
    on<FetchAssetsSingleDowntime>(_fetchAssetsSingleDowntime);
    on<FetchAssetsComments>(_fetchAssetsComments);
    on<AddAssetsComments>(_addAssetsComments);
    on<SelectAssetsReportFailureLocation>(_selectAssetsReportFailureLocation);
    on<SelectAssetsFailureCode>(_selectAssetsFailureCode);
    on<SaveAssetsReportFailure>(_saveAssetsReportFailure);
    on<SaveAssetsMeterReading>(_saveAssetsMeterReading);
    on<SelectAssetsMeter>(_selectAssetsMeter);
    on<SelectAssetsRollOver>(_selectAssetsRollOver);
    on<DeleteAssetsDocument>(_deleteAssetsDocument);
    on<FetchAddAssetsDocument>(_fetchAddAssetsDocument);
    on<SelectAssetsDocument>(_selectAssetsDocument);
    on<SelectAssetsDocumentTypeFilter>(_selectAssetsDocumentTypeFilter);
    on<ApplyAssetsDocumentFilter>(_applyAssetsDocumentFilter);
    on<ClearAssetsDocumentFilter>(_clearAssetsDocumentFilter);
    on<AddManageDocument>(_addManageDocument);
  }

  int assetTabIndex = 0;
  List<AssetsListDatum> assetsDatum = [];
  List<AddDocumentDatum> addDocumentDatum = [];
  bool hasReachedMax = false;
  bool hasDocumentReachedMax = false;
  bool isFromAdd = true;
  Map filters = {};
  Map documentFilters = {};
  List assetMasterData = [];
  String selectLocationName = '';
  String selectTypeName = '';
  String assetId = "";

  Future<FutureOr<void>> _fetchAssetsList(
      FetchAssetsList event, Emitter<AssetsState> emit) async {
    emit(AssetsListFetching());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      if (event.isFromHome == false) {
        FetchAssetsListModel fetchAssetsListModel = await _assetsRepository
            .fetchAssetsListRepo(event.pageNo, hashCode!, "");
        assetsDatum.addAll(fetchAssetsListModel.data);
        hasReachedMax = fetchAssetsListModel.data.isEmpty;
        emit(AssetsListFetched(
            fetchAssetsListModel: fetchAssetsListModel,
            data: fetchAssetsListModel.data,
            hasReachedMax: hasReachedMax,
            filtersMap: {}));
      } else {
        FetchAssetsListModel fetchAssetsListModel = await _assetsRepository
            .fetchAssetsListRepo(event.pageNo, hashCode!, jsonEncode(filters));
        assetsDatum.addAll(fetchAssetsListModel.data);
        hasReachedMax = fetchAssetsListModel.data.isEmpty;
        emit(AssetsListFetched(
            fetchAssetsListModel: fetchAssetsListModel,
            data: fetchAssetsListModel.data,
            hasReachedMax: hasReachedMax,
            filtersMap: filters));
      }
    } catch (e) {
      emit(AssetsListError(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchAssetsDetails(
      FetchAssetsDetails event, Emitter<AssetsState> emit) async {
    assetTabIndex = event.assetTabIndex;
    List popUpMenuItems = [
      StringConstants.kManageDocuments,
      StringConstants.kManageDownTime,
      StringConstants.kManageComment,
      StringConstants.kReportFailure,
      StringConstants.kManageMeterReading,
      DatabaseUtil.getText("Cancel"),
    ];
    emit(AssetsDetailsFetching());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchAssetsDetailsModel fetchAssetsDetailsModel = await _assetsRepository
          .fetchAssetsDetailsRepo(hashCode!, event.assetId);
      emit(AssetsDetailsFetched(
          fetchAssetsDetailsModel: fetchAssetsDetailsModel,
          assetsPopUpMenu: popUpMenuItems,
          showPopUpMenu: true));
    } catch (e) {
      emit(AssetsDetailsError(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchAssetsMaster(
      FetchAssetsMaster event, Emitter<AssetsState> emit) async {
    emit(AssetsMasterFetching());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchAssetsMasterModel fetchAssetsMasterModel =
          await _assetsRepository.fetchAssetsMasterRepo(hashCode!);
      assetMasterData = fetchAssetsMasterModel.data;
      emit(AssetsMasterFetched(
          fetchAssetsMasterModel: fetchAssetsMasterModel,
          assetsMasterMap: filters));
    } catch (e) {
      emit(AssetsMasterError(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _selectAssetsLocation(
      SelectAssetsLocation event, Emitter<AssetsState> emit) {
    emit(AssetsLocationSelected(selectLocationName: event.selectLocationName));
  }

  FutureOr<void> _selectAssetsStatus(
      SelectAssetsStatus event, Emitter<AssetsState> emit) {
    emit(AssetsStatusSelected(id: event.id));
  }

  FutureOr<void> _selectAssetsSite(
      SelectAssetsSite event, Emitter<AssetsState> emit) {
    emit(AssetsSiteSelected(id: event.id));
  }

  FutureOr<void> _applyAssetsFilter(
      ApplyAssetsFilter event, Emitter<AssetsState> emit) {
    filters = {
      "name": event.assetsFilterMap["name"],
      "loc": event.assetsFilterMap["loc"],
      "status": event.assetsFilterMap["status"],
      "site": event.assetsFilterMap["site"],
    };
  }

  FutureOr<void> _clearAssetsFilter(
      ClearAssetsFilter event, Emitter<AssetsState> emit) {
    filters = {};
    add(FetchAssetsList(pageNo: 1, isFromHome: false));
  }

  Future<FutureOr<void>> _fetchAssetsGetDownTime(
      FetchAssetsGetDownTime event, Emitter<AssetsState> emit) async {
    emit(AssetsGetDownTimeFetching());
    try {
      List popUpMenuItems = [
        DatabaseUtil.getText("Edit"),
        DatabaseUtil.getText("Delete"),
        DatabaseUtil.getText("Cancel"),
      ];
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchAssetsDowntimeModel fetchAssetsDowntimeModel =
          await _assetsRepository.fetchAssetsDowntimeRepo(
              event.pageNo, hashCode!, event.assetId);

      emit(AssetsGetDownTimeFetched(
          fetchAssetsDowntimeModel: fetchAssetsDowntimeModel,
          assetsPopUpMenu: popUpMenuItems,
          showPopUpMenu: true));
    } catch (e) {
      emit(AssetsGetDownTimeError(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _saveAssetsDownTime(
      SaveAssetsDownTime event, Emitter<AssetsState> emit) async {
    emit(AssetsDownTimeSaving());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map saveDowntimeMap = {
        "hashcode": hashCode,
        "startdate": event.saveDowntimeMap["startdate"],
        "enddate": event.saveDowntimeMap["enddate"],
        "starttime": event.saveDowntimeMap["starttime"],
        "endtime": event.saveDowntimeMap["endtime"],
        "userid": userId,
        "assetid": assetId,
        "id": event.saveDowntimeMap["downtimeId"] ?? '',
        "note": event.saveDowntimeMap["note"],
      };
      SaveAssetsDowntimeModel saveAssetsDowntimeModel =
          await _assetsRepository.saveAssetsDowntimeRepo(saveDowntimeMap);
      emit(AssetsDownTimeSaved(
          saveAssetsDowntimeModel: saveAssetsDowntimeModel));
    } catch (e) {
      emit(AssetsDownTimeNotSaved(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchAssetsManageDocument(
      FetchAssetsManageDocument event, Emitter<AssetsState> emit) async {
    emit(AssetsGetDocumentFetching());
    try {
      List popUpMenuItems = [
        DatabaseUtil.getText("Delete"),
        DatabaseUtil.getText("Cancel"),
      ];
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchAssetsManageDocumentModel fetchAssetsManageDocumentModel =
          await _assetsRepository.fetchAssetsDocument(
              event.pageNo, hashCode!, event.assetsId);
      emit(AssetsGetDocumentFetched(
          fetchAssetsManageDocumentModel: fetchAssetsManageDocumentModel,
          assetsPopUpMenu: popUpMenuItems,
          showPopUpMenu: true));
    } catch (e) {
      emit(AssetsGetDocumentError(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchAssetsSingleDowntime(
      FetchAssetsSingleDowntime event, Emitter<AssetsState> emit) async {
    emit(AssetsSingleDownTimeFetching());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchAssetSingleDowntimeModel fetchAssetSingleDowntimeModel =
          await _assetsRepository.fetchAssetsSingleDowntimeRepo(
              hashCode!, event.downtimeId);
      AssetsAddAndEditDowntimeScreen.saveDowntimeMap["startdate"] =
          fetchAssetSingleDowntimeModel.data.startdate;
      AssetsAddAndEditDowntimeScreen.saveDowntimeMap["enddate"] =
          fetchAssetSingleDowntimeModel.data.enddate;
      AssetsAddAndEditDowntimeScreen.saveDowntimeMap["starttime"] =
          fetchAssetSingleDowntimeModel.data.starttime;
      AssetsAddAndEditDowntimeScreen.saveDowntimeMap["endtime"] =
          fetchAssetSingleDowntimeModel.data.endtime;
      AssetsAddAndEditDowntimeScreen.saveDowntimeMap["id"] =
          fetchAssetSingleDowntimeModel.data.id;
      AssetsAddAndEditDowntimeScreen.saveDowntimeMap["note"] =
          fetchAssetSingleDowntimeModel.data.note;
      emit(AssetsSingleDownTimeFetched(
          fetchAssetSingleDowntimeModel: fetchAssetSingleDowntimeModel));
    } catch (e) {
      emit(AssetsSingleDownTimeError(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _deleteAssetsDownTime(
      DeleteAssetsDownTime event, Emitter<AssetsState> emit) async {
    emit(AssetsDownTimeDeleting());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      Map deleteDowntimeMap = {
        "downtimeid": event.downtimeId,
        "hashcode": hashCode,
      };
      AssetsDeleteDowntimeModel assetsDeleteDowntimeModel =
          await _assetsRepository.assetsDeleteDowntimeRepo(deleteDowntimeMap);
      emit(AssetsDownTimeDeleted(
          assetsDeleteDowntimeModel: assetsDeleteDowntimeModel));
    } catch (e) {
      emit(AssetsDownTimeNotDeleted(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _fetchAssetsComments(
      FetchAssetsComments event, Emitter<AssetsState> emit) async {
    emit(AssetsCommentsFetching());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? clientId = await _customerCache.getClientId(CacheKeys.clientId);
      FetchAssetsCommentsModel fetchAssetsCommentsModel =
          await _assetsRepository.fetchAssetsCommentsRepo(hashCode!, assetId);
      if (fetchAssetsCommentsModel.status == 200) {
        emit(AssetsCommentsFetched(
            fetchAssetsCommentsModel: fetchAssetsCommentsModel,
            clientId: clientId!));
      }
    } catch (e) {
      emit(AssetsCommentsError(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _addAssetsComments(
      AddAssetsComments event, Emitter<AssetsState> emit) async {
    emit(AssetsCommentsAdding());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map addCommentMap = {
        "userid": userId,
        "assetid": assetId,
        "comments": event.addAssetCommentMap["comments"],
        "files": event.addAssetCommentMap["files"],
        "hashcode": hashCode
      };
      AssetsAddCommentsModel assetsAddCommentsModel =
          await _assetsRepository.assetsAddCommentsRepo(addCommentMap);
      if (assetsAddCommentsModel.status == 200) {
        emit(AssetsCommentsAdded(
            assetsAddCommentsModel: assetsAddCommentsModel));
      }
    } catch (e) {
      emit(AssetsCommentsNotAdded(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _selectAssetsReportFailureLocation(
      SelectAssetsReportFailureLocation event, Emitter<AssetsState> emit) {
    emit(AssetsReportFailureLocationSelected(
        selectLocationName: selectLocationName));
  }

  FutureOr<void> _selectAssetsFailureCode(
      SelectAssetsFailureCode event, Emitter<AssetsState> emit) {
    emit(AssetsFailureCodeSelected(id: event.id));
  }

  Future<FutureOr<void>> _saveAssetsReportFailure(
      SaveAssetsReportFailure event, Emitter<AssetsState> emit) async {
    emit(AssetsReportFailureSaving());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map assetsReportFailureMap = {
        "hashcode": hashCode,
        "failure": event.assetsReportFailureMap['failure'],
        "location": event.assetsReportFailureMap['location'],
        "userid": userId,
        "assetid": assetId
      };
      SaveAssetsReportFailureModel saveAssetsReportFailureModel =
          await _assetsRepository
              .saveAssetsReportFailureRepo(assetsReportFailureMap);
      if (saveAssetsReportFailureModel.status == 200) {
        emit(AssetsReportFailureSaved(
            saveAssetsReportFailureModel: saveAssetsReportFailureModel));
      } else {
        emit(AssetsReportFailureNotSaved(
            errorMessage: saveAssetsReportFailureModel.message));
      }
    } catch (e) {
      emit(AssetsReportFailureNotSaved(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _saveAssetsMeterReading(
      SaveAssetsMeterReading event, Emitter<AssetsState> emit) async {
    emit(AssetsMeterReadingSaving());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map assetsMeterReadingMap = {
        "hashcode": hashCode,
        "date": event.assetsMeterReadingMap["date"],
        "time": event.assetsMeterReadingMap["time"],
        "note": event.assetsMeterReadingMap["note"],
        "reading": event.assetsMeterReadingMap["reading"],
        "meterid": event.assetsMeterReadingMap["meterid"],
        "userid": userId,
        "isrollover": event.assetsMeterReadingMap["isrollover"],
        "assetid": assetId
      };
      SaveAssetsMeterReadingModel saveAssetsMeterReadingModel =
          await _assetsRepository
              .saveAssetsMeterReadingRepo(assetsMeterReadingMap);
      if (saveAssetsMeterReadingModel.status == 200) {
        emit(AssetsMeterReadingSaved(
            saveAssetsMeterReadingModel: saveAssetsMeterReadingModel));
      } else {
        emit(AssetsMeterReadingNotSaved(
            errorMessage: saveAssetsMeterReadingModel.message));
      }
    } catch (e) {
      emit(AssetsMeterReadingNotSaved(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _selectAssetsMeter(
      SelectAssetsMeter event, Emitter<AssetsState> emit) {
    emit(AssetsMeterSelected(id: event.id, meterName: event.meterName));
  }

  FutureOr<void> _selectAssetsRollOver(
      SelectAssetsRollOver event, Emitter<AssetsState> emit) {
    emit(AssetsRollOverSelected(id: event.id, isRollover: event.isRollover));
  }

  Future<FutureOr<void>> _deleteAssetsDocument(
      DeleteAssetsDocument event, Emitter<AssetsState> emit) async {
    emit(AssetsDocumentDeleting());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      Map deleteDocumentMap = {
        "docid": event.documentId,
        "assetid": assetId,
        "hashcode": hashCode
      };
      AssetsDeleteDocumentModel assetsDeleteDocumentModel =
          await _assetsRepository.assetsDeleteDocumentRepo(deleteDocumentMap);
      if (assetsDeleteDocumentModel.status == 200) {
        emit(AssetsDocumentDeleted());
      } else {
        emit(AssetsDownTimeNotDeleted(
            errorMessage: assetsDeleteDocumentModel.message));
      }
    } catch (e) {
      emit(AssetsDownTimeNotDeleted(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchAddAssetsDocument(
      FetchAddAssetsDocument event, Emitter<AssetsState> emit) async {
    emit(AddAssetsDocumentFetching());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      if (event.isFromHome) {
        FetchAddAssetsDocumentModel fetchAddAssetsDocumentModel =
            await _assetsRepository.fetchAddAssetsDocument(
                event.pageNo, hashCode, assetId, '{}');
        hasDocumentReachedMax = fetchAddAssetsDocumentModel.data.isEmpty;
        addDocumentDatum.addAll(fetchAddAssetsDocumentModel.data);
          emit(AddAssetsDocumentFetched(
              fetchAddAssetsDocumentModel: fetchAddAssetsDocumentModel,
              documentFilterMap: {},
              data: fetchAddAssetsDocumentModel.data));
        } else {
          FetchAddAssetsDocumentModel fetchAddAssetsDocumentModel =
              await _assetsRepository.fetchAddAssetsDocument(
                  event.pageNo, hashCode, assetId, jsonEncode(documentFilters));
          hasDocumentReachedMax = fetchAddAssetsDocumentModel.data.isEmpty;
          addDocumentDatum.addAll(fetchAddAssetsDocumentModel.data);
          if (fetchAddAssetsDocumentModel.status == 200) {
            emit(AddAssetsDocumentFetched(
                fetchAddAssetsDocumentModel: fetchAddAssetsDocumentModel,
                documentFilterMap: documentFilters,
                data: fetchAddAssetsDocumentModel.data));
          }
      }
    } catch (e) {
      emit(AddAssetsDocumentNotFetched(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _selectAssetsDocument(
      SelectAssetsDocument event, Emitter<AssetsState> emit) {
    emit(AssetsDocumentSelected(isChecked: event.isChecked));
  }

  Future<FutureOr<void>> _addManageDocument(
      AddManageDocument event, Emitter<AssetsState> emit) async {
    emit(ManageDocumentAdding());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map addDocumentMap = {
        "hashcode": hashCode,
        "assetid": assetId,
        "documents": event.addDocumentMap['documents'],
        "userid": userId
      };
      if (event.addDocumentMap['documents'] == null ||
          event.addDocumentMap['documents'].toString().isEmpty) {
        emit(ManageDocumentNotAdded(errorMessage: 'Please Select Document'));
      } else {
        AddManageDocumentModel addManageDocumentModel =
            await _assetsRepository.addManageDocumentRepo(addDocumentMap);
        if (addManageDocumentModel.status == 200) {
          emit(ManageDocumentAdded());
        } else {
          emit(ManageDocumentNotAdded(
              errorMessage: addManageDocumentModel.message));
        }
      }
    } catch (e) {
      emit(ManageDocumentNotAdded(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _selectAssetsDocumentTypeFilter(
      SelectAssetsDocumentTypeFilter event, Emitter<AssetsState> emit) {
    emit(AssetsDocumentTypeFilterSelected(
        selectedTypeId: event.selectedTypeId,
        selectedTypeName: event.selectedTypeName));
  }

  FutureOr<void> _applyAssetsDocumentFilter(
      ApplyAssetsDocumentFilter event, Emitter<AssetsState> emit) {
    documentFilters = event.assetsDocumentFilterMap;
  }

  FutureOr<void> _clearAssetsDocumentFilter(ClearAssetsDocumentFilter event, Emitter<AssetsState> emit) {
    documentFilters = {};
    }
}
