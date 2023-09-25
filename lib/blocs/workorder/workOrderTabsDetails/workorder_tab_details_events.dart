import '../../../data/models/workorder/fetch_workorder_details_model.dart';

abstract class WorkOrderTabsDetailsEvent {}

class WorkOrderDetails extends WorkOrderTabsDetailsEvent {
  final String workOrderId;
  final int initialTabIndex;

  WorkOrderDetails({required this.initialTabIndex, required this.workOrderId});
}

class WorkOrderToggleSwitchIndex extends WorkOrderTabsDetailsEvent {
  final int toggleIndex;
  final FetchWorkOrderTabDetailsModel fetchWorkOrderDetailsModel;
  final int tabInitialIndex;

  WorkOrderToggleSwitchIndex(
      {required this.fetchWorkOrderDetailsModel,
      required this.tabInitialIndex,
      required this.toggleIndex});
}

class SelectWorkOrderCompanyOptions extends WorkOrderTabsDetailsEvent {
  final String companyId;
  final String companyName;

  SelectWorkOrderCompanyOptions(
      {required this.companyId, required this.companyName});
}

class SelectWorkOrderLocationOptions extends WorkOrderTabsDetailsEvent {
  final String locationId;
  final String locationName;

  SelectWorkOrderLocationOptions(
      {required this.locationId, required this.locationName});
}

class SelectWorkOrderTypeOptions extends WorkOrderTabsDetailsEvent {
  final String typeId;
  final String typeName;

  SelectWorkOrderTypeOptions({required this.typeId, required this.typeName});
}

class WorkOrderItemTabDeleteItem extends WorkOrderTabsDetailsEvent {
  final String itemId;

  WorkOrderItemTabDeleteItem({required this.itemId});
}

class WorkOrderDeleteDocument extends WorkOrderTabsDetailsEvent {
  final String docId;

  WorkOrderDeleteDocument({required this.docId});
}

class SelectWorkOrderPriorityOptions extends WorkOrderTabsDetailsEvent {
  final String priorityId;
  final String priorityValue;

  SelectWorkOrderPriorityOptions(
      {required this.priorityId, required this.priorityValue});
}

class SelectWorkOrderCategoryOptions extends WorkOrderTabsDetailsEvent {
  final String categoryId;
  final String categoryName;

  SelectWorkOrderCategoryOptions(
      {required this.categoryId, required this.categoryName});
}

class SelectWorkOrderOriginationOptions extends WorkOrderTabsDetailsEvent {
  final String originationId;
  final String originationName;

  SelectWorkOrderOriginationOptions(
      {required this.originationId, required this.originationName});
}

class SelectWorkOrderCostCenterOptions extends WorkOrderTabsDetailsEvent {
  final String costCenterId;
  final String costCenterValue;

  SelectWorkOrderCostCenterOptions(
      {required this.costCenterId, required this.costCenterValue});
}

class SaveSimilarAndNewWorkOrder extends WorkOrderTabsDetailsEvent {
  final Map workOrderDetailsMap;

  SaveSimilarAndNewWorkOrder({required this.workOrderDetailsMap});
}

class UpdateWorkOrderDetails extends WorkOrderTabsDetailsEvent {
  final Map updateWorkOrderDetailsMap;

  UpdateWorkOrderDetails({required this.updateWorkOrderDetailsMap});
}

class SelectSafetyMeasureOptions extends WorkOrderTabsDetailsEvent {
  final String safetyMeasureId;
  final List safetyMeasureIdList;
  final List safetyMeasureNameList;
  final String safetyMeasureName;

  SelectSafetyMeasureOptions(
      {required this.safetyMeasureName,
      required this.safetyMeasureNameList,
      required this.safetyMeasureId,
      required this.safetyMeasureIdList});
}

class SelectSpecialWorkOptions extends WorkOrderTabsDetailsEvent {
  final String specialWorkId;
  final String specialWorkName;
  final List specialWorkIdList;
  final List specialWorkNameList;

  SelectSpecialWorkOptions(
      {required this.specialWorkId,
      required this.specialWorkName,
      required this.specialWorkIdList,
      required this.specialWorkNameList});
}

class ManageWorkOrderDownTime extends WorkOrderTabsDetailsEvent {
  final Map manageDownTimeMap;

  ManageWorkOrderDownTime({required this.manageDownTimeMap});
}

class WorkOrderSelectVendorOption extends WorkOrderTabsDetailsEvent {
  final String vendorName;

  WorkOrderSelectVendorOption({required this.vendorName});
}

class WorkOrderSelectCurrencyOption extends WorkOrderTabsDetailsEvent {
  final String currencyName;

  WorkOrderSelectCurrencyOption({required this.currencyName});
}

class ManageWorkOrderMiscCost extends WorkOrderTabsDetailsEvent {
  final Map manageMisCostMap;

  ManageWorkOrderMiscCost({required this.manageMisCostMap});
}

class AcceptWorkOrder extends WorkOrderTabsDetailsEvent {
  final String workOrderId;

  AcceptWorkOrder({required this.workOrderId});
}

class HoldWorkOrder extends WorkOrderTabsDetailsEvent {
  final String workOrderId;

  HoldWorkOrder({required this.workOrderId});
}

class FetchWorkOrderSingleDownTime extends WorkOrderTabsDetailsEvent {
  final String downTimeId;

  FetchWorkOrderSingleDownTime({required this.downTimeId});
}

class FetchAssignWorkForceList extends WorkOrderTabsDetailsEvent {}

class RejectWorkOrder extends WorkOrderTabsDetailsEvent {
  final String workOrderId;

  RejectWorkOrder({required this.workOrderId});
}
