import '../../data/models/workorder/fetch_workorders_model.dart';

abstract class WorkOrderRepository {
  Future<FetchWorkOrdersModel> fetchWorkOrders(
      int pageNo, String hashCode, String filter);
}
