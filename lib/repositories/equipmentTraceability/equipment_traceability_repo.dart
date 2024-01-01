import 'package:toolkit/data/models/equipmentTraceability/fetch_search_equipment_details_model.dart';
import 'package:toolkit/data/models/equipmentTraceability/fetch_search_equipment_model.dart';

abstract class EquipmentTraceabilityRepo {
  Future<FetchSearchEquipmentModel> fetchSearchEquipment(
      int pageNo, String hashCode, String userId, String filter);

  Future<FetchSearchEquipmentDetailsModel> fetchDetailsEquipment(
      String hashCode, String equipmentId, String userId);
}
