import 'package:toolkit/data/models/workorder/accpeet_workorder_model.dart';
import 'package:toolkit/data/models/workorder/fetch_assign_parts_model.dart';
import 'package:toolkit/data/models/workorder/workorder_assign_parts_model.dart';

import '../../data/models/workorder/assign_workforce_model.dart';
import '../../data/models/workorder/complete_workOrder_model.dart';
import '../../data/models/workorder/delete_document_model.dart';
import '../../data/models/workorder/delete_item_tab_item_model.dart';
import '../../data/models/workorder/delete_workorder_single_misc_cost_model.dart';
import '../../data/models/workorder/delete_workorder_workforce_model.dart';
import '../../data/models/workorder/fetch_assign_workforce_model.dart';
import '../../data/models/workorder/fetch_workorder_details_model.dart';
import '../../data/models/workorder/fetch_workorder_documents_model.dart';
import '../../data/models/workorder/fetch_workorder_master_model.dart';
import '../../data/models/workorder/fetch_workorder_misc_cost_model.dart';
import '../../data/models/workorder/fetch_workorder_single_downtime_model.dart';
import '../../data/models/workorder/fetch_workorders_model.dart';
import '../../data/models/workorder/hold_workorder_model.dart';
import '../../data/models/workorder/manage_misc_cost_model.dart';
import '../../data/models/workorder/manage_downtime_model.dart';
import '../../data/models/workorder/reject_workorder_model.dart';
import '../../data/models/workorder/save_new_and_similar_workorder_model.dart';
import '../../data/models/workorder/save_workorder_documents_model.dart';
import '../../data/models/workorder/start_workorder_model.dart';
import '../../data/models/workorder/update_workorder_details_model.dart';
import '../../data/models/workorder/workorder_edit_workforce_model.dart';
import '../../data/models/workorder/workorder_save_comments_model.dart';

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

  Future<ManageWorkOrderDownTimeModel> manageDownTime(Map manageDownTimeMap);

  Future<AcceptWorkOrderModel> acceptWorkOrder(Map acceptWorkOrderMap);

  Future<HoldWorkOrderModel> holdWorkOrder(Map holdWorkOrderMap);

  Future<AssignWorkOrderModel> assignWorkForce(Map assignWorkForceMap);

  Future<FetchWorkOrderSingleDownTimeModel> fetchWorkOrderSingleDownTime(
      String hashCode, String downTimeId);

  Future<FetchAssignWorkForceModel> fetchAssignWorkForce(
      int pageNo, String hashCode, String workOrderId, String name);

  Future<RejectWorkOrderModel> rejectWorkOrder(Map rejectWorkOrderMap);

  Future<StartWorkOrderModel> startWorkOrder(Map startWorkOrderMap);

  Future<DeleteWorkOrderSingleMiscCostModel> deleteWorkOrderSingleMiscCost(
      Map deleteMiscCostMap);

  Future<EditWorkOrderWorkForceModel> editWorkForce(Map editWorkForceMap);

  Future<DeleteWorkOrderWorkForceModel> deleteWorkOrderWorkForce(
      Map deleteWorkForceMap);

  Future<SaveWorkOrderCommentsModel> saveWorkOrderComments(
      Map saveWorkOrderCommentsMap);

  Future<SaveWorkOrderDocumentsModel> saveDocuments(Map saveDocumentsMap);

  Future<SaveNewAndSimilarWorkOrderModel> saveNewAndSimilarWorkOrder(
      Map saveNewAndSimilarWorkOrderMap);

  Future<UpdateWorkOrderDetailsModel> updateWorkOrderDetails(
      Map updateWorkOrderDetailsMap);

  Future<FetchAssignPartsModel> fetchAssignPartsModel(
      int pageNo, String hashCode, String workOrderId, String name);

  Future<FetchWorkOrderDocumentsModel> fetchWorkOrderDocuments(int pageNo,
      String hashCode, String workOrderId, String name, String filter);

  Future<FetchWorkOrderSingleMiscCostModel> fetchWorkOrderSingleMiscCost(
      String hashCode, String misCostId);

  Future<WorkorderAssignItemModel> workorderAssignItem(Map assignPartMap);

  Future<CompleteWorkOrderModel> completeWorkOrder(Map completeWorkOrderMap);
}
