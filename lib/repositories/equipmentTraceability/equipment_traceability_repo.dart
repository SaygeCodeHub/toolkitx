import 'package:toolkit/data/models/equipmentTraceability/fetch_search_equipment_details_model.dart';
import 'package:toolkit/data/models/equipmentTraceability/fetch_search_equipment_model.dart';

import '../../data/models/equipmentTraceability/fetch_equipment_set_parameter_model.dart';

abstract class EquipmentTraceabilityRepo {
  Future<FetchSearchEquipmentModel> fetchSearchEquipment(
      int pageNo, String hashCode, String userId, String filter);

  Future<FetchEquipmentSetParameterModel> fetchEquipmentSetParameter(
      String hashCode,String equipmentId);

  Future<FetchSearchEquipmentDetailsModel> fetchDetailsEquipment(
      String hashCode, String equipmentId, String userId);
}
