abstract class WorkOrderEvents {}

class FetchWorkOrders extends WorkOrderEvents {
  final int pageNo;
  final bool isFromHome;

  FetchWorkOrders({required this.isFromHome, required this.pageNo});
}

class FetchWorkOrderMaster extends WorkOrderEvents {}

class SelectWorkOrderTypeFilter extends WorkOrderEvents {
  final String value;

  SelectWorkOrderTypeFilter({required this.value});
}

class SelectWorkOrderStatusFilter extends WorkOrderEvents {
  final String id;

  SelectWorkOrderStatusFilter({required this.id});
}

class WorkOrderApplyFilter extends WorkOrderEvents {
  final Map workOrderFilterMap;

  WorkOrderApplyFilter({required this.workOrderFilterMap});
}

class WorkOrderClearFilter extends WorkOrderEvents {}
