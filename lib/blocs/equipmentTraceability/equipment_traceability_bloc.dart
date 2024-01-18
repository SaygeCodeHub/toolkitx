import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/equipmentTraceability/equipment_save_location_model.dart';
import 'package:toolkit/data/models/equipmentTraceability/fetch_employees_model.dart';
import 'package:toolkit/data/models/equipmentTraceability/fetch_equipment_by_code_model.dart';
import 'package:toolkit/data/models/equipmentTraceability/fetch_equipment_set_parameter_model.dart';
import 'package:toolkit/data/models/equipmentTraceability/fetch_search_equipment_model.dart';
import 'package:toolkit/data/models/equipmentTraceability/fetch_warehouse_model.dart';
import 'package:toolkit/data/models/equipmentTraceability/fetch_warehouse_positions_model.dart';
import 'package:toolkit/data/models/equipmentTraceability/save_custom_parameter_model.dart';
import 'package:toolkit/data/models/equipmentTraceability/send_transfer_rquest_model.dart';
import 'package:toolkit/repositories/equipmentTraceability/equipment_traceability_repo.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/equipmentTraceability/fetch_my_request_model.dart';
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
    on<FetchMyRequest>(_fetchMyRequest);
    on<SelectTransferTypeName>(_selectTransferType);
    on<SelectWarehouse>(_selectWarehouse);
    on<FetchWarehouse>(_fetchWarehouse);
    on<SelectWarehousePositions>(_selectWarehousePositions);
    on<FetchWarehousePositions>(_fetchWarehousePositions);
    on<SelectEmployee>(_selectEmployee);
    on<FetchEmployee>(_fetchEmployee);
    on<SendTransferRequest>(_sendTransferRequest);
  }

  Map filters = {};
  bool hasReachedMax = false;
  bool requestReachedMax = false;
  List<SearchEquipmentDatum> searchEquipmentDatum = [];
  List<MyRequestTransfer> myRequestData = [];
  String equipmentId = "";
  String code = "";
  String transferValue = "";
  String personId = "";
  String positionId = "";
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
      if (fetchEquipmentByCodeModel.status == 200) {
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
            "currentitemcount": 0,
            "usercount": 0
          });
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

  Future<FutureOr<void>> _fetchMyRequest(
      FetchMyRequest event, Emitter<EquipmentTraceabilityState> emit) async {
    emit(MyRequestFetching());
    try {
      List popUpMenuItems = [
        DatabaseUtil.getText('approve'),
        DatabaseUtil.getText('Reject'),
        DatabaseUtil.getText('Cancel')
      ];
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      FetchMyRequestModel fetchMyRequestModel = await _equipmentTraceabilityRepo
          .fetchMyRequest(event.pageNo, userId, hashCode);
      if (fetchMyRequestModel.status == 200) {
        emit(MyRequestFetched(
            fetchMyRequestModel: fetchMyRequestModel,
            popUpMenuItems: popUpMenuItems));
      } else {
        emit(MyRequestNotFetched(errorMessage: fetchMyRequestModel.message));
      }
    } catch (e) {
      emit(MyRequestNotFetched(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _selectTransferType(
      SelectTransferTypeName event, Emitter<EquipmentTraceabilityState> emit) {
    emit(TransferTypeSelected(
        transferType: event.transferType, transferValue: event.transferValue));
    transferValue = event.transferValue;
  }

  Future<FutureOr<void>> _selectWarehouse(
      SelectWarehouse event, Emitter<EquipmentTraceabilityState> emit) async {
    emit(WarehouseSelected(warehouseMap: event.warehouseMap));
  }

  Future<FutureOr<void>> _fetchWarehouse(
      FetchWarehouse event, Emitter<EquipmentTraceabilityState> emit) async {
    emit(EquipmentWareHouseFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      FetchWarehouseModel fetchWarehouseModel =
          await _equipmentTraceabilityRepo.fetchWarehouse(hashCode);
      if (fetchWarehouseModel.status == 200) {
        emit(EquipmentWareHouseFetched(
            fetchWarehouseModel: fetchWarehouseModel));
      } else {
        emit(EquipmentWareHouseNotFetched(
            errorMessage: fetchWarehouseModel.message));
      }
    } catch (e) {
      emit(EquipmentWareHouseNotFetched(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _selectWarehousePositions(SelectWarehousePositions event,
      Emitter<EquipmentTraceabilityState> emit) {
    emit(WarehousePositionsSelected(positionsMap: event.positionsMap));
    positionId = event.positionsMap['positionid'];
    add(FetchWarehousePositions());
  }

  Future<FutureOr<void>> _fetchWarehousePositions(FetchWarehousePositions event,
      Emitter<EquipmentTraceabilityState> emit) async {
    emit(WarehousePositionsFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      FetchWarehousePositionsModel fetchWarehousePositionsModel =
          await _equipmentTraceabilityRepo.fetchWarehousePositions(
              transferValue, hashCode);
      if (fetchWarehousePositionsModel.status == 200) {
        emit(WarehousePositionsFetched(
            fetchWarehousePositionsModel: fetchWarehousePositionsModel));
      } else {
        emit(WarehousePositionsNotFetched(
            errorMessage: fetchWarehousePositionsModel.message));
      }
    } catch (e) {
      emit(WarehousePositionsNotFetched(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _selectEmployee(
      SelectEmployee event, Emitter<EquipmentTraceabilityState> emit) {
    emit(EmployeeSelected(employeeMap: event.employeeMap));
    personId = event.employeeMap['employeeid'];
  }

  Future<FutureOr<void>> _fetchEmployee(
      FetchEmployee event, Emitter<EquipmentTraceabilityState> emit) async {
    emit(EmployeeFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      FetchEmployeesModel fetchEmployeesModel =
          await _equipmentTraceabilityRepo.fetchEmployees(hashCode);
      if (fetchEmployeesModel.status == 200) {
        emit(EmployeeFetched(fetchEmployeesModel: fetchEmployeesModel));
      } else {
        emit(EmployeeNotFetched(errorMessage: fetchEmployeesModel.message));
      }
    } catch (e) {
      emit(EmployeeNotFetched(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _sendTransferRequest(SendTransferRequest event,
      Emitter<EquipmentTraceabilityState> emit) async {
    emit(TransferRequestSending());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      Map transferRequestMap = {
        "hashcode": hashCode,
        "transferto": transferValue,
        "positionid": transferValue == '1' ? positionId : '',
        "personid": transferValue == '2' ? personId : '',
        "userid": userId,
        "equipmentlist": equipmentList
      };
      SendTransferRequestModel sendTransferRequestModel =
          await _equipmentTraceabilityRepo
              .sendTransferRequest(transferRequestMap);
      if (sendTransferRequestModel.status == 200) {
        emit(TransferRequestSent());
      } else {
        emit(TransferRequestNotSent(
            errorMessage: sendTransferRequestModel.message));
      }
    } catch (e) {
      emit(TransferRequestNotSent(errorMessage: e.toString()));
    }
  }
}
