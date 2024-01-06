import 'package:toolkit/data/models/equipmentTraceability/fetch_search_equipment_details_model.dart';
import 'package:toolkit/data/models/equipmentTraceability/fetch_search_equipment_model.dart';
import 'package:toolkit/data/models/equipmentTraceability/fetch_equipment_set_parameter_model.dart';
import 'package:toolkit/data/models/equipmentTraceability/save_custom_parameter_model.dart';

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

  @override
  Future<FetchEquipmentSetParameterModel> fetchEquipmentSetParameter(
      String hashCode, String equipmentId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}equipment/getcustomparameters?hashcode=$hashCode&equipmentid=$equipmentId");
    return FetchEquipmentSetParameterModel.fromJson(response);
  }

  @override
  Future<FetchSearchEquipmentDetailsModel> fetchDetailsEquipment(
      String hashCode, String equipmentId, String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}equipment/getequipment?hashcode=$hashCode&equipmentid=$equipmentId&userid=$userId");
    return FetchSearchEquipmentDetailsModel.fromJson(response);
  }

  @override
  Future<SaveCustomParameterModel> saveCustomParameter(
      Map saveCustomParameterMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}equipment/savecustomparameter",
        saveCustomParameterMap);
    return SaveCustomParameterModel.fromJson(response);
  }
}
