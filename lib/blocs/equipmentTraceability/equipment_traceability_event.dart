part of 'equipment_traceability_bloc.dart';

abstract class EquipmentTraceabilityEvent {}

class FetchSearchEquipmentList extends EquipmentTraceabilityEvent {
  final int pageNo;

  FetchSearchEquipmentList({required this.pageNo});
}
