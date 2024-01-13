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

class FetchEquipmentSetParameter extends EquipmentTraceabilityEvent {
  final String equipmentId;

  FetchEquipmentSetParameter({required this.equipmentId});
}

class FetchSearchEquipmentDetails extends EquipmentTraceabilityEvent {
  final String equipmentId;

  FetchSearchEquipmentDetails({required this.equipmentId});
}

class SaveCustomParameter extends EquipmentTraceabilityEvent {
  final Map saveCustomParameterMap;

  SaveCustomParameter({required this.saveCustomParameterMap});
}

class EquipmentSaveImage extends EquipmentTraceabilityEvent {
  final Map saveImagesMap;

  EquipmentSaveImage({required this.saveImagesMap});
}

class EquipmentSaveLocation extends EquipmentTraceabilityEvent {
  final Map equipmentSaveLocationMap;

  EquipmentSaveLocation({required this.equipmentSaveLocationMap});
}

class FetchEquipmentByCode extends EquipmentTraceabilityEvent {
  final String code;

  FetchEquipmentByCode({required this.code});
}

class SelectTransferTypeName extends EquipmentTraceabilityEvent {
  final String transferType;

  SelectTransferTypeName({required this.transferType});
}

class SelectWarehouse extends EquipmentTraceabilityEvent {
  final String id;
  final String warehouse;

  SelectWarehouse({required this.warehouse,required this.id});
}