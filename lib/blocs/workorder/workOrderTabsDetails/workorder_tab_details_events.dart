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
