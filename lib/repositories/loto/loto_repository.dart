import 'package:toolkit/data/models/loto/fetch_loto_assign_workforce_model.dart';
import 'package:toolkit/data/models/loto/loto_details_model.dart';

import '../../data/models/loto/fetch_loto_assign_team_model.dart';
import '../../data/models/loto/loto_list_model.dart';
import '../../data/models/loto/loto_master_model.dart';

abstract class LotoRepository {
  Future<FetchLotoListModel> fetchLotoListRepo(
    int pageNo,
    String hashCode,
    String userId,
    String filter,
  );

  Future<FetchLotoMasterModel> fetchLotoMasterRepo(String hashCode);

  Future<FetchLotoDetailsModel> fetchLotoDetailsRepo(
      String hashCode, String lotoId);

  Future<FetchLotoAssignWorkforceModel> fetchLotoAssignWorkforceModel(
      String hashCode, String lotoId, int pageNo, String name, int isRemove);

  Future<FetchLotoAssignTeamModel> fetchLotoAssignTeam(
      String hashCode, String lotoId, int pageNo, String name, int isRemove);
}
