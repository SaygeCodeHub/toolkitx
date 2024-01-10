import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/equipmentTraceability/equipment_save_location_model.dart';
import 'package:toolkit/data/models/equipmentTraceability/fetch_equipment_by_code_model.dart';
import 'package:toolkit/data/models/equipmentTraceability/fetch_equipment_set_parameter_model.dart';
import 'package:toolkit/data/models/equipmentTraceability/fetch_search_equipment_model.dart';
import 'package:toolkit/data/models/equipmentTraceability/save_custom_parameter_model.dart';
import 'package:toolkit/repositories/equipmentTraceability/equipment_traceability_repo.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/equipmentTraceability/fetch_search_equipment_details_model.dart';
import '../../data/models/equipmentTraceability/save_equipement_images_parameter_model.dart';
import '../../di/app_module.dart';

part 'equipment_traceability_event.dart';

part 'equipment_traceability_state.dart';

class EquipmentTraceabilityBloc
    extends Bloc<EquipmentTraceabilityEvent, EquipmentTraceabilityState> {
  final EquipmentTraceabilityRepo _equipmentTraceabilityRepo =
      getIt<EquipmentTraceabilityRepo>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  EquipmentTraceabilityBloc() : super(EquipmentTraceabilityInitial()) {
    on<FetchSearchEquipmentList>(_fetchSearchEquipmentList);
    on<FetchSearchEquipmentDetails>(_fetchSearchEquipmentDetails);
    on<ApplySearchEquipmentFilter>(_applySearchEquipmentFilter);
    on<ClearSearchEquipmentFilter>(_clearSearchEquipmentFilter);
    on<FetchEquipmentSetParameter>(_fetchEquipmentSetParameter);
    on<SaveCustomParameter>(_saveCustomParameter);
    on<EquipmentSaveImage>(_equipmentSaveImage);
    on<EquipmentSaveLocation>(_equipmentSaveLocation);
    on<FetchEquipmentByCode>(_fetchEquipmentByCode);
    on<SelectSearchEquipment>(_selectSearchEquipment);
  }

  Map filters = {};
  bool hasReachedMax = false;
  List<SearchEquipmentDatum> searchEquipmentDatum = [];
  String equipmentId = "";
  String code = "";
  List answerList = [];
  List equipmentList = [];

  FutureOr<void> _fetchSearchEquipmentList(FetchSearchEquipmentList event,
      Emitter<EquipmentTraceabilityState> emit) async {
    emit(SearchEquipmentListFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      if (event.isFromHome) {
        FetchSearchEquipmentModel fetchSearchEquipmentModel =
            await _equipmentTraceabilityRepo.fetchSearchEquipment(
                event.pageNo, hashCode, userId, '{}');
        searchEquipmentDatum.addAll(fetchSearchEquipmentModel.data);
        hasReachedMax = fetchSearchEquipmentModel.data.isEmpty;
        emit(SearchEquipmentListFetched(
            data: searchEquipmentDatum, filtersMap: {}));
      } else {
        FetchSearchEquipmentModel fetchSearchEquipmentModel =
            await _equipmentTraceabilityRepo.fetchSearchEquipment(
                event.pageNo, hashCode, userId, jsonEncode(filters));
        searchEquipmentDatum.addAll(fetchSearchEquipmentModel.data);
        hasReachedMax = fetchSearchEquipmentModel.data.isEmpty;
        emit(SearchEquipmentListFetched(
            data: searchEquipmentDatum, filtersMap: filters));
      }
    } catch (e) {
      emit(SearchEquipmentListNotFetched(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _fetchSearchEquipmentDetails(FetchSearchEquipmentDetails event,
      Emitter<EquipmentTraceabilityState> emit) async {
    emit(SearchEquipmentDetailsFetching());
    List popUpMenuItems = [
      StringConstants.kTransfer,
      StringConstants.kSetParameter,
      StringConstants.kUploadMedia,
      StringConstants.kSetLocation,
      DatabaseUtil.getText('Cancel'),
    ];
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      String? clientId =
          await _customerCache.getClientId(CacheKeys.clientId) ?? '';
      FetchSearchEquipmentDetailsModel fetchSearchEquipmentDetailsModel =
          await _equipmentTraceabilityRepo.fetchDetailsEquipment(
              hashCode, event.equipmentId, userId);
      equipmentId = event.equipmentId;

      if (fetchSearchEquipmentDetailsModel.status == 200) {
        emit(SearchEquipmentDetailsFetched(
          fetchSearchEquipmentDetailsModel: fetchSearchEquipmentDetailsModel,
          popUpMenuItems: popUpMenuItems,
          showPopMenu: fetchSearchEquipmentDetailsModel.data.cantransfer == "1"
              ? true
              : false,
          clientId: clientId,
        ));
      } else {
        emit(SearchEquipmentDetailsNotFetched(
            errorMessage: fetchSearchEquipmentDetailsModel.message));
      }
    } catch (e) {
      emit(SearchEquipmentListNotFetched(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _applySearchEquipmentFilter(ApplySearchEquipmentFilter event,
      Emitter<EquipmentTraceabilityState> emit) {
    filters = event.searchEquipmentFilterMap;
  }

  FutureOr<void> _clearSearchEquipmentFilter(ClearSearchEquipmentFilter event,
      Emitter<EquipmentTraceabilityState> emit) {
    filters = {};
  }

  Future<FutureOr<void>> _fetchEquipmentSetParameter(
      FetchEquipmentSetParameter event,
      Emitter<EquipmentTraceabilityState> emit) async {
    emit(EquipmentSetParameterFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      FetchEquipmentSetParameterModel fetchEquipmentSetParameterModel =
          await _equipmentTraceabilityRepo.fetchEquipmentSetParameter(
              hashCode, event.equipmentId);
      if (fetchEquipmentSetParameterModel.status == 200) {
        emit(EquipmentSetParameterFetched(
            fetchEquipmentSetParameterModel: fetchEquipmentSetParameterModel));
      } else {
        emit(EquipmentSetParameterNotFetched(
            errorMessage: fetchEquipmentSetParameterModel.message));
      }
    } catch (e) {
      emit(EquipmentSetParameterNotFetched(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _saveCustomParameter(SaveCustomParameter event,
      Emitter<EquipmentTraceabilityState> emit) async {
    emit(CustomParameterSaving());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      Map saveCustomParameterMap = {
        "hashcode": hashCode,
        "userid": userId,
        "answerlist": answerList,
        "equipmentid": event.saveCustomParameterMap["equipmentId"]
      };

      SaveCustomParameterModel saveCustomParameterModel =
          await _equipmentTraceabilityRepo
              .saveCustomParameter(saveCustomParameterMap);
      if (saveCustomParameterModel.status == 200) {
        emit(CustomParameterSaved());
      } else {
        emit(CustomParameterNotSaved(
            errorMessage: saveCustomParameterModel.message));
      }
    } catch (e) {
      emit(CustomParameterNotSaved(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _equipmentSaveImage(EquipmentSaveImage event,
      Emitter<EquipmentTraceabilityState> emit) async {
    emit(EquipmentImageSaving());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map saveImageMap = {
        "userid": userId,
        "notes": event.saveImagesMap["notes"] ?? '',
        "filename": event.saveImagesMap["filename"],
        "equipmentid": equipmentId,
        "hashcode": hashCode
      };
      SaveEquipmentImagesModel saveEquipmentImagesModel =
          await _equipmentTraceabilityRepo
              .saveEquipmentImagesModel(saveImageMap);
      if (saveEquipmentImagesModel.status == 200) {
        emit(EquipmentImageSaved(
            saveEquipmentImagesModel: saveEquipmentImagesModel));
      } else {
        emit(EquipmentImageNotSaved(
            errorMessage: saveEquipmentImagesModel.message));
      }
    } catch (e) {
      emit(EquipmentImageNotSaved(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _equipmentSaveLocation(EquipmentSaveLocation event,
      Emitter<EquipmentTraceabilityState> emit) async {
    emit(EquipmentLocationSaving());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map equipmentSaveLocationMap = {
        "id": equipmentId,
        "userid": userId,
        "hashcode": hashCode,
        "equipmentid": equipmentId,
        "latitude": "",
        "longitude": ""
      };
      EquipmentSaveLocationModel equipmentSaveLocationModel =
          await _equipmentTraceabilityRepo
              .equipmentSaveLocation(equipmentSaveLocationMap);
      if (equipmentSaveLocationModel.status == 200) {
        emit(EquipmentLocationSaved());
      } else {
        emit(EquipmentLocationNotSaved(
            errorMessage: equipmentSaveLocationModel.message));
      }
    } catch (e) {
      emit(EquipmentLocationNotSaved(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchEquipmentByCode(FetchEquipmentByCode event,
      Emitter<EquipmentTraceabilityState> emit) async {
    emit(EquipmentByCodeFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      FetchEquipmentByCodeModel fetchEquipmentByCodeModel =
          await _equipmentTraceabilityRepo.fetchEquipmentByCode(
              hashCode, event.code, userId);
      code = event.code;
      log('BlocCode============>$code');
      if (fetchEquipmentByCodeModel.status == 200) {
        log('here');
        if (equipmentList.indexWhere((element) =>
                element["id"].toString().trim() ==
                fetchEquipmentByCodeModel.data.id.trim()) ==
            -1) {
          equipmentList.add({
            "id": fetchEquipmentByCodeModel.data.id.trim(),
            "equipmentcode":
                fetchEquipmentByCodeModel.data.equipmentcode.trim(),
            "equipmentname":
                fetchEquipmentByCodeModel.data.equipmentname.trim(),
          });
          log("list=============>$equipmentList");

        }

        emit(EquipmentByCodeFetched(
            fetchEquipmentByCodeModel: fetchEquipmentByCodeModel,
            equipmentList: equipmentList));
      } else {
        emit(EquipmentByCodeNotFetched(
            errorMessage: fetchEquipmentByCodeModel.message));
      }
    } catch (e) {
      emit(EquipmentByCodeNotFetched(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _selectSearchEquipment(
      SelectSearchEquipment event, Emitter<EquipmentTraceabilityState> emit) {
    emit(SearchEquipmentSelected(isChecked: event.isChecked));
    log("isCheckedBloc===========>${event.isChecked}");
  }
}
