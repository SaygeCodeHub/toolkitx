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
}
