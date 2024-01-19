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

class FetchMyRequest extends EquipmentTraceabilityEvent {
  final int pageNo;

  FetchMyRequest({required this.pageNo});
}

class SelectTransferTypeName extends EquipmentTraceabilityEvent {
  final String transferType;
  final String transferValue;

  SelectTransferTypeName(
      {required this.transferType, required this.transferValue});
}

class SelectWarehouse extends EquipmentTraceabilityEvent {
  final Map warehouseMap;

  SelectWarehouse({required this.warehouseMap});
}

class FetchWarehouse extends EquipmentTraceabilityEvent {}

class SelectWarehousePositions extends EquipmentTraceabilityEvent {
  final Map positionsMap;

  SelectWarehousePositions({required this.positionsMap});
}

class FetchWarehousePositions extends EquipmentTraceabilityEvent {}

class SelectEmployee extends EquipmentTraceabilityEvent {
  final Map employeeMap;

  SelectEmployee({required this.employeeMap});
}

class FetchEmployee extends EquipmentTraceabilityEvent {}

class SendTransferRequest extends EquipmentTraceabilityEvent {
  SendTransferRequest();
}

class SelectWorkOrderEquipment extends EquipmentTraceabilityEvent {
  final Map workOrderEquipmentMap;

  SelectWorkOrderEquipment({required this.workOrderEquipmentMap});
}

class ApproveTransferRequest extends EquipmentTraceabilityEvent {
  final String requestId;

  ApproveTransferRequest({required this.requestId});
}

class SelectSearchEquipment extends EquipmentTraceabilityEvent {
  final bool isChecked;

  SelectSearchEquipment({required this.isChecked});
}
