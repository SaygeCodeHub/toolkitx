part of 'equipment_traceability_bloc.dart';

abstract class EquipmentTraceabilityState {}

class EquipmentTraceabilityInitial extends EquipmentTraceabilityState {}

class SearchEquipmentListFetching extends EquipmentTraceabilityState {}

class SearchEquipmentListFetched extends EquipmentTraceabilityState {
  final List<SearchEquipmentDatum> data;
  final Map filtersMap;

  SearchEquipmentListFetched({required this.data, required this.filtersMap});
}

class SearchEquipmentListNotFetched extends EquipmentTraceabilityState {
  final String errorMessage;

  SearchEquipmentListNotFetched({required this.errorMessage});
}

class EquipmentSetParameterFetching extends EquipmentTraceabilityState {}

class EquipmentSetParameterFetched extends EquipmentTraceabilityState {
  final FetchEquipmentSetParameterModel fetchEquipmentSetParameterModel;

  EquipmentSetParameterFetched({required this.fetchEquipmentSetParameterModel});
}

class EquipmentSetParameterNotFetched extends EquipmentTraceabilityState {
  final String errorMessage;

  EquipmentSetParameterNotFetched({required this.errorMessage});
}

class SearchEquipmentDetailsFetching extends EquipmentTraceabilityState {}

class SearchEquipmentDetailsFetched extends EquipmentTraceabilityState {
  final FetchSearchEquipmentDetailsModel fetchSearchEquipmentDetailsModel;
  final List popUpMenuItems;
  final bool showPopMenu;
  final String clientId;

  SearchEquipmentDetailsFetched(
      {required this.popUpMenuItems,
      required this.showPopMenu,
      required this.fetchSearchEquipmentDetailsModel,
      required this.clientId});
}

class SearchEquipmentDetailsNotFetched extends EquipmentTraceabilityState {
  final String errorMessage;

  SearchEquipmentDetailsNotFetched({required this.errorMessage});
}

class EquipmentImageSaving extends EquipmentTraceabilityState {}

class EquipmentImageSaved extends EquipmentTraceabilityState {
  final SaveEquipmentImagesModel saveEquipmentImagesModel;

  EquipmentImageSaved({required this.saveEquipmentImagesModel});
}

class EquipmentImageNotSaved extends EquipmentTraceabilityState {
  final String errorMessage;

  EquipmentImageNotSaved({required this.errorMessage});
}

class CustomParameterSaving extends EquipmentTraceabilityState {}

class CustomParameterSaved extends EquipmentTraceabilityState {}

class CustomParameterNotSaved extends EquipmentTraceabilityState {
  final String errorMessage;

  CustomParameterNotSaved({required this.errorMessage});
}

class EquipmentLocationSaving extends EquipmentTraceabilityState {}

class EquipmentLocationSaved extends EquipmentTraceabilityState {}

class EquipmentLocationNotSaved extends EquipmentTraceabilityState {
  final String errorMessage;

  EquipmentLocationNotSaved({required this.errorMessage});
}

class EquipmentByCodeFetching extends EquipmentTraceabilityState {}

class EquipmentByCodeFetched extends EquipmentTraceabilityState {
  final FetchEquipmentByCodeModel fetchEquipmentByCodeModel;
  final List equipmentList;

  EquipmentByCodeFetched(
      {required this.fetchEquipmentByCodeModel, required this.equipmentList});
}

class EquipmentByCodeNotFetched extends EquipmentTraceabilityState {
  final String errorMessage;

  EquipmentByCodeNotFetched({required this.errorMessage});
}

class MyRequestFetching extends EquipmentTraceabilityState {}

class MyRequestFetched extends EquipmentTraceabilityState {
  final FetchMyRequestModel fetchMyRequestModel;
  final List popUpMenuItems;

  MyRequestFetched(
      {required this.fetchMyRequestModel, required this.popUpMenuItems});
}

class MyRequestNotFetched extends EquipmentTraceabilityState {
  final String errorMessage;

  MyRequestNotFetched({required this.errorMessage});
}

class TransferTypeSelected extends EquipmentTraceabilityState {
  final String transferType;
  final String transferValue;

  TransferTypeSelected(
      {required this.transferType, required this.transferValue});
}

class WarehouseSelected extends EquipmentTraceabilityState {
  final Map warehouseMap;

  WarehouseSelected({required this.warehouseMap});
}

class EquipmentWareHouseFetching extends EquipmentTraceabilityState {}

class EquipmentWareHouseFetched extends EquipmentTraceabilityState {
  final FetchWarehouseModel fetchWarehouseModel;

  EquipmentWareHouseFetched({required this.fetchWarehouseModel});
}

class EquipmentWareHouseNotFetched extends EquipmentTraceabilityState {
  final String errorMessage;

  EquipmentWareHouseNotFetched({required this.errorMessage});
}

class WarehousePositionsSelected extends EquipmentTraceabilityState {
  final Map positionsMap;

  WarehousePositionsSelected({required this.positionsMap});
}

class WarehousePositionsFetching extends EquipmentTraceabilityState {}

class WarehousePositionsFetched extends EquipmentTraceabilityState {
  final FetchWarehousePositionsModel fetchWarehousePositionsModel;

  WarehousePositionsFetched({required this.fetchWarehousePositionsModel});
}

class WarehousePositionsNotFetched extends EquipmentTraceabilityState {
  final String errorMessage;

  WarehousePositionsNotFetched({required this.errorMessage});
}

class EmployeeSelected extends EquipmentTraceabilityState {
  final Map employeeMap;

  EmployeeSelected({required this.employeeMap});
}

class EmployeeFetching extends EquipmentTraceabilityState {}

class EmployeeFetched extends EquipmentTraceabilityState {
  final FetchEmployeesModel fetchEmployeesModel;

  EmployeeFetched({required this.fetchEmployeesModel});
}

class EmployeeNotFetched extends EquipmentTraceabilityState {
  final String errorMessage;

  EmployeeNotFetched({required this.errorMessage});
}
