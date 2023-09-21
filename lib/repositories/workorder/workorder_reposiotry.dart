import '../../data/models/workorder/delete_document_model.dart';
import '../../data/models/workorder/delete_item_tab_item_model.dart';
import '../../data/models/workorder/fetch_workorder_details_model.dart';
import '../../data/models/workorder/fetch_workorder_master_model.dart';
import '../../data/models/workorder/fetch_workorders_model.dart';
import '../../data/models/workorder/manage_misc_cost_model.dart';
import '../../data/models/workorder/save_new_and_similar_workorder_model.dart';
import '../../data/models/workorder/update_workorder_details_model.dart';

abstract class WorkOrderRepository {
  Future<FetchWorkOrdersModel> fetchWorkOrders(
      int pageNo, String hashCode, String filter);

  Future<FetchWorkOrdersMasterModel> fetchWorkOrderMaster(
      String hashCode, String userId);

  Future<FetchWorkOrderTabDetailsModel> fetchWorkOrderDetails(
      String hashCode, String workOrderId);

  Future<DeleteItemTabItemModel> deleteItemTabItem(Map deleteItemTabItemMap);

  Future<DeleteDocumentModel> deleteDocument(Map deleteDocumentMap);

  Future<ManageWorkOrderMiscCostModel> manageMiscCost(Map manageMiscCostMap);

  Future<SaveNewAndSimilarWorkOrderModel> saveNewAndSimilarWorkOrder(
      Map saveNewAndSimilarWorkOrderMap);

  Future<UpdateWorkOrderDetailsModel> updateWorkOrderDetails(
      Map updateWorkOrderDetailsMap);
}
