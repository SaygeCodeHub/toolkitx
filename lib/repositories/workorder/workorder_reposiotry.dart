import '../../data/models/workorder/fetch_workorder_master_model.dart';
import '../../data/models/workorder/fetch_workorders_model.dart';

abstract class WorkOrderRepository {
  Future<FetchWorkOrdersModel> fetchWorkOrders(
      int pageNo, String hashCode, String filter);

  Future<FetchWorkOrdersMasterModel> fetchWorkOrderMaster(
      String hashCode, String userId);
}
