import 'package:toolkit/data/models/workorder/accpeet_workorder_model.dart';
import 'package:toolkit/data/models/workorder/delete_document_model.dart';
import 'package:toolkit/data/models/workorder/delete_item_tab_item_model.dart';
import 'package:toolkit/data/models/workorder/fetch_assign_parts_model.dart';
import 'package:toolkit/data/models/workorder/fetch_assign_workforce_model.dart';
import 'package:toolkit/data/models/workorder/fetch_workorder_details_model.dart';
import 'package:toolkit/data/models/workorder/fetch_workorder_master_model.dart';
import 'package:toolkit/data/models/workorder/hold_workorder_model.dart';
import 'package:toolkit/data/models/workorder/fetch_workorder_single_downtime_model.dart';
import 'package:toolkit/data/models/workorder/manage_misc_cost_model.dart';
import 'package:toolkit/data/models/workorder/manage_downtime_model.dart';
import 'package:toolkit/data/models/workorder/reject_workorder_model.dart';
import 'package:toolkit/data/models/workorder/save_new_and_similar_workorder_model.dart';
import 'package:toolkit/data/models/workorder/update_workorder_details_model.dart';

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
  Future<RejectWorkOrderModel> rejectWorkOrder(Map rejectWorkOrderMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}workorder/rejectworkorder", rejectWorkOrderMap);
    return RejectWorkOrderModel.fromJson(response);
  }
}
