part of 'equipment_traceability_bloc.dart';

abstract class EquipmentTraceabilityEvent {}

class FetchSearchEquipmentList extends EquipmentTraceabilityEvent {
  final int pageNo;
  final bool isFromHome;

  FetchSearchEquipmentList({required this.pageNo, required this.isFromHome});
}

class ApplySearchEquipmentFilter extends EquipmentTraceabilityEvent {
  final Map searchEquipmentFilterMap;

  ApplySearchEquipmentFilter({required this.searchEquipmentFilterMap});
}

class ClearSearchEquipmentFilter extends EquipmentTraceabilityEvent {}