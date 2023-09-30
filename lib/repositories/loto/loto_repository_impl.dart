import 'package:toolkit/data/models/loto/fetch_loto_assign_workforce_model.dart';
import 'package:toolkit/data/models/loto/loto_details_model.dart';
import 'package:toolkit/data/models/loto/loto_list_model.dart';
import 'package:toolkit/data/models/loto/loto_master_model.dart';
import 'package:toolkit/data/models/loto/save_assign_workforce_model.dart';

import '../../data/models/loto/fetch_loto_assign_team_model.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';
import 'loto_repository.dart';

class LotoRepositoryImpl extends LotoRepository {
  @override
  Future<FetchLotoListModel> fetchLotoListRepo(
      int pageNo, String hashCode, String userId, String filter) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}loto/get?pageno=$pageNo&hashcode=$hashCode&filter=$filter&userid=$userId");
    return FetchLotoListModel.fromJson(response);
  }

  @override
  Future<FetchLotoMasterModel> fetchLotoMasterRepo(String hashCode) async {
    final response = await DioClient()
        .get("${ApiConstants.baseUrl}loto/getmaster?hashcode=$hashCode");
    return FetchLotoMasterModel.fromJson(response);
  }

  @override
  Future<FetchLotoDetailsModel> fetchLotoDetailsRepo(
      String hashCode, String lotoId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}loto/getloto?lotoid=$lotoId&hashcode=$hashCode");
    return FetchLotoDetailsModel.fromJson(response);
  }

  @override
  Future<FetchLotoAssignWorkforceModel> fetchLotoAssignWorkforceModel(
      String hashCode,
      String lotoId,
      int pageNo,
      String name,
      int isRemove) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}loto/getworkforceforassign?pageno=$pageNo&hashcode=$hashCode&lotoid=$lotoId&name=$name&isremove=$isRemove");
    return FetchLotoAssignWorkforceModel.fromJson(response);
  }

  @override
  Future<FetchLotoAssignTeamModel> fetchLotoAssignTeam(String hashCode,
      String lotoId, int pageNo, String name, int isRemove) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}/loto/getteamforassign?pageno=$pageNo&hashcode=$hashCode&lotoid=$lotoId&name=$name&isremove=$isRemove");
    return FetchLotoAssignTeamModel.fromJson(response);
  }

  @override
  Future<SaveLotoAssignWorkforceModel> saveLotoAssignWorkforceModel(
      Map lotoAssignWorkforceMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}loto/assignworkforce", lotoAssignWorkforceMap);
    return SaveLotoAssignWorkforceModel.fromJson(response);
  }
}
