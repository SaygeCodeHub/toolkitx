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
