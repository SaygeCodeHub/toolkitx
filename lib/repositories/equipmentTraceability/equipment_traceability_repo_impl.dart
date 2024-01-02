import 'package:toolkit/data/models/equipmentTraceability/fetch_search_equipment_model.dart';

import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';
import 'equipment_traceability_repo.dart';

class EquipmentTraceabilityRepoImpl extends EquipmentTraceabilityRepo {
  @override
  Future<FetchSearchEquipmentModel> fetchSearchEquipment(
      int pageNo, String hashCode, String userId, String filter) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}equipment/getallocated?pageno=$pageNo&userid=$userId&hashcode=$hashCode&filter=$filter");
    return FetchSearchEquipmentModel.fromJson(response);
  }
}