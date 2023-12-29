import 'package:toolkit/data/models/equipmentTraceability/fetch_search_equipment_model.dart';

abstract class EquipmentTraceabilityRepo {
  Future<FetchSearchEquipmentModel> fetchSearchEquipment(
      int pageNo, String hashCode, String userId, String filter);
}
