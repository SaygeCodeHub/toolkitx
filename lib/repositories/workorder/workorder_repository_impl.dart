import 'package:toolkit/data/models/workorder/accpeet_workorder_model.dart';
import 'package:toolkit/data/models/workorder/assign_workforce_model.dart';
import 'package:toolkit/data/models/workorder/complete_workorder_model.dart';
import 'package:toolkit/data/models/workorder/delete_document_model.dart';
import 'package:toolkit/data/models/workorder/delete_item_tab_item_model.dart';
import 'package:toolkit/data/models/workorder/delete_workorder_single_misc_cost_model.dart';
import 'package:toolkit/data/models/workorder/delete_workorder_workforce_model.dart';
import 'package:toolkit/data/models/workorder/fetch_assign_parts_model.dart';
import 'package:toolkit/data/models/workorder/fetch_assign_workforce_model.dart';
import 'package:toolkit/data/models/workorder/fetch_workorder_details_model.dart';
import 'package:toolkit/data/models/workorder/fetch_workorder_documents_model.dart';
import 'package:toolkit/data/models/workorder/fetch_workorder_master_model.dart';
import 'package:toolkit/data/models/workorder/fetch_workorder_misc_cost_model.dart';
import 'package:toolkit/data/models/workorder/hold_workorder_model.dart';
import 'package:toolkit/data/models/workorder/fetch_workorder_single_downtime_model.dart';
import 'package:toolkit/data/models/workorder/manage_misc_cost_model.dart';
import 'package:toolkit/data/models/workorder/manage_downtime_model.dart';
import 'package:toolkit/data/models/workorder/reject_workorder_model.dart';
import 'package:toolkit/data/models/workorder/save_new_and_similar_workorder_model.dart';
import 'package:toolkit/data/models/workorder/save_workorder_documents_model.dart';
import 'package:toolkit/data/models/workorder/start_workorder_model.dart';
import 'package:toolkit/data/models/workorder/update_workorder_details_model.dart';
import 'package:toolkit/data/models/workorder/workorder_assign_parts_model.dart';
import 'package:toolkit/data/models/workorder/workorder_edit_workforce_model.dart';
import 'package:toolkit/data/models/workorder/workorder_save_comments_model.dart';

import '../../data/models/workorder/fetch_workorders_model.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';
import 'workorder_reposiotry.dart';

class WorkOrderRepositoryImpl extends WorkOrderRepository {
  @override
  Future<FetchWorkOrdersModel> fetchWorkOrders(
      int pageNo, String hashCode, String filter) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}workorder/get?pageno=$pageNo&hashcode=$hashCode&filter=$filter");
    return FetchWorkOrdersModel.fromJson(response);
  }

  @override
  Future<FetchWorkOrdersMasterModel> fetchWorkOrderMaster(
      String hashCode, String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}workorder/getmaster?hashcode=$hashCode&userid=$userId");
    return FetchWorkOrdersMasterModel.fromJson(response);
  }

  @override
  Future<FetchWorkOrderTabDetailsModel> fetchWorkOrderDetails(
      String hashCode, String workOrderId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}workorder/getworkorder?hashcode=$hashCode&workorderid=$workOrderId");
    return FetchWorkOrderTabDetailsModel.fromJson(response);
  }

  @override
  Future<DeleteItemTabItemModel> deleteItemTabItem(
      Map deleteItemTabItemMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}workorder/deleteplan", deleteItemTabItemMap);
    return DeleteItemTabItemModel.fromJson(response);
  }

  @override
  Future<DeleteDocumentModel> deleteDocument(Map deleteDocumentMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}workorder/deletedocument", deleteDocumentMap);
    return DeleteDocumentModel.fromJson(response);
  }

  @override
  Future<SaveNewAndSimilarWorkOrderModel> saveNewAndSimilarWorkOrder(
      Map saveNewAndSimilarWorkOrderMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}workorder/save", saveNewAndSimilarWorkOrderMap);
    return SaveNewAndSimilarWorkOrderModel.fromJson(response);
  }

  @override
  Future<UpdateWorkOrderDetailsModel> updateWorkOrderDetails(
      Map updateWorkOrderDetailsMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}workorder/update", updateWorkOrderDetailsMap);
    return UpdateWorkOrderDetailsModel.fromJson(response);
  }

  @override
  Future<ManageWorkOrderDownTimeModel> manageDownTime(
      Map manageDownTimeMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}workorder/managedowntime", manageDownTimeMap);
    return ManageWorkOrderDownTimeModel.fromJson(response);
  }

  @override
  Future<ManageWorkOrderMiscCostModel> manageMiscCost(
      Map manageMiscCostMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}workorder/managemisccost", manageMiscCostMap);
    return ManageWorkOrderMiscCostModel.fromJson(response);
  }

  @override
  Future<AcceptWorkOrderModel> acceptWorkOrder(Map acceptWorkOrderMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}workorder/acceptworkorder", acceptWorkOrderMap);
    return AcceptWorkOrderModel.fromJson(response);
  }

  @override
  Future<HoldWorkOrderModel> holdWorkOrder(Map holdWorkOrderMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}workorder/holdworkorder", holdWorkOrderMap);
    return HoldWorkOrderModel.fromJson(response);
  }

  @override
  Future<FetchWorkOrderSingleDownTimeModel> fetchWorkOrderSingleDownTime(
      String hashCode, String downTimeId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}workorder/getsingledowntime?hashcode=$hashCode&downtimeid=$downTimeId");
    return FetchWorkOrderSingleDownTimeModel.fromJson(response);
  }

  @override
  Future<FetchAssignWorkForceModel> fetchAssignWorkForce(
      int pageNo, String hashCode, String workOrderId, String name) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}workorder/getworkforceforassign?pageno=$pageNo&hashcode=$hashCode&workorderid=$workOrderId&name=$name");
    return FetchAssignWorkForceModel.fromJson(response);
  }

  @override
  Future<FetchAssignPartsModel> fetchAssignPartsModel(
      int pageNo, String hashCode, String workOrderId, String name) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}workorder/getitemstoassign?pageno=$pageNo&hashcode=$hashCode&workorderid=$workOrderId&name=$name");
    return FetchAssignPartsModel.fromJson(response);
  }

  @override
  Future<AssignWorkOrderModel> assignWorkForce(Map assignWorkForceMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}workorder/assignworkforce", assignWorkForceMap);
    return AssignWorkOrderModel.fromJson(response);
  }

  @override
  Future<RejectWorkOrderModel> rejectWorkOrder(Map rejectWorkOrderMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}workorder/rejectworkorder", rejectWorkOrderMap);
    return RejectWorkOrderModel.fromJson(response);
  }

  @override
  Future<StartWorkOrderModel> startWorkOrder(Map startWorkOrderMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}workorder/startworkorder", startWorkOrderMap);
    return StartWorkOrderModel.fromJson(response);
  }

  @override
  Future<FetchWorkOrderDocumentsModel> fetchWorkOrderDocuments(int pageNo,
      String hashCode, String workOrderId, String name, String filter) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}workorder/getdocumentsforworkorder?pageno=$pageNo&hashcode=$hashCode&workorderid=$workOrderId&name=$name&filter=$filter");
    return FetchWorkOrderDocumentsModel.fromJson(response);
  }

  @override
  Future<FetchWorkOrderSingleMiscCostModel> fetchWorkOrderSingleMiscCost(
      String hashCode, String misCostId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}workorder/getsinglemisccost?hashcode=$hashCode&misccostid=$misCostId");
    return FetchWorkOrderSingleMiscCostModel.fromJson(response);
  }

  @override
  Future<DeleteWorkOrderSingleMiscCostModel> deleteWorkOrderSingleMiscCost(
      Map deleteMiscCostMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}workorder/deletemisccost", deleteMiscCostMap);
    return DeleteWorkOrderSingleMiscCostModel.fromJson(response);
  }

  @override
  Future<EditWorkOrderWorkForceModel> editWorkForce(
      Map editWorkForceMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}workorder/updateworkforcehours",
        editWorkForceMap);
    return EditWorkOrderWorkForceModel.fromJson(response);
  }

  @override
  Future<SaveWorkOrderCommentsModel> saveWorkOrderComments(
      Map saveWorkOrderCommentsMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}workorder/savecomments",
        saveWorkOrderCommentsMap);
    return SaveWorkOrderCommentsModel.fromJson(response);
  }

  @override
  Future<SaveWorkOrderDocumentsModel> saveDocuments(
      Map saveDocumentsMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}workorder/managedocuments", saveDocumentsMap);
    return SaveWorkOrderDocumentsModel.fromJson(response);
  }

  @override
  Future<DeleteWorkOrderWorkForceModel> deleteWorkOrderWorkForce(
      Map deleteWorkForceMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}workorder/deleteworkforce", deleteWorkForceMap);
    return DeleteWorkOrderWorkForceModel.fromJson(response);
  }

  @override
  Future<WorkorderAssignItemModel> workorderAssignItem(
      Map assignPartMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}workorder/assignitem", assignPartMap);
    return WorkorderAssignItemModel.fromJson(response);
  }

  @override
  Future<CompleteWorkOrderModel> completeWorkOrder(
      Map completeWorkOrderMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}workorder/completeworkorder",
        completeWorkOrderMap);
    return CompleteWorkOrderModel.fromJson(response);
  }
}
