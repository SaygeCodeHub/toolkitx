abstract class WorkOrderEvents {}

class FetchWorkOrders extends WorkOrderEvents {
  final int pageNo;

  FetchWorkOrders({required this.pageNo});
}

class FetchWorkOrderMaster extends WorkOrderEvents {}