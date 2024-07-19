import 'package:toolkit/data/models/tankManagement/fetch_nomination_checklist_model.dart';
import 'package:toolkit/data/models/tankManagement/fetch_tank_management_details_model.dart';
import 'package:toolkit/data/models/tankManagement/fetch_tank_management_list_module.dart';
import 'package:toolkit/repositories/tankManagement/tank_management_repository.dart';

import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';

class TankManagementRepositoryImpl extends TankManagementRepository {
  @override
  Future<FetchTankManagementListModel> fetchTankManagementList(
      int pageNo, String hashCode, String filter, String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}nomination/get?pageno=$pageNo&hashcode=$hashCode&filter=$filter&userid=$userId");
    return FetchTankManagementListModel.fromJson(response);
  }

  @override
  Future<FetchTankManagementDetailsModel> fetchTankManagementDetails(
      String nominationId, String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}nomination/getnomination?nominationid=$nominationId&hashcode=$hashCode");
    return FetchTankManagementDetailsModel.fromJson(response);
  }

  @override
  Future<FetchNominationChecklistModel> fetchNominationChecklist(
      String nominationId, String hashCode, String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}nomination/getnominationchecklist?nominationid=$nominationId&hashcode=$hashCode&userid=$userId");
    return FetchNominationChecklistModel.fromJson(response);
  }
}
