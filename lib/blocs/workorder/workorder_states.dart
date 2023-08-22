import '../../data/models/workorder/fetch_workorder_master_model.dart';
import '../../data/models/workorder/fetch_workorders_model.dart';

abstract class WorkOrderStates {}

class WorkOrderInitial extends WorkOrderStates {}

class FetchingWorkOrders extends WorkOrderStates {}

class WorkOrdersFetched extends WorkOrderStates {
  final FetchWorkOrdersModel fetchWorkOrdersModel;
  final List<WorkOrderDatum> data;
  final bool hasReachedMax;

  WorkOrdersFetched({required this.data,
      required this.fetchWorkOrdersModel,
      required this.hasReachedMax});
}

class WorkOrdersNotFetched extends WorkOrderStates {
  final String listNotFetched;

  WorkOrdersNotFetched({required this.listNotFetched});
}

class FetchingWorkOrderMaster extends WorkOrderStates {}

class WorkOrderMasterFetched extends WorkOrderStates {
  final FetchWorkOrdersMasterModel fetchWorkOrdersMasterModel;

  WorkOrderMasterFetched({required this.fetchWorkOrdersMasterModel});
}

class WorkOrderMasterNotFetched extends WorkOrderStates {
  final String masterNotFetched;

  WorkOrderMasterNotFetched({required this.masterNotFetched});
}
