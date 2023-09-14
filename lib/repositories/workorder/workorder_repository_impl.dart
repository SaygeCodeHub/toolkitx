import 'package:toolkit/data/models/workorder/delete_document_model.dart';
import 'package:toolkit/data/models/workorder/delete_item_tab_item_model.dart';
import 'package:toolkit/data/models/workorder/fetch_workorder_details_model.dart';
import 'package:toolkit/data/models/workorder/fetch_workorder_master_model.dart';

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
}
