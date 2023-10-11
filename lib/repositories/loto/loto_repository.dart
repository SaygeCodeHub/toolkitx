import 'package:toolkit/data/models/loto/apply_loto_model.dart';
import 'package:toolkit/data/models/loto/fetch_loto_assign_workforce_model.dart';
import 'package:toolkit/data/models/loto/assign_workforce_for_remove_model.dart';
import 'package:toolkit/data/models/loto/loto_details_model.dart';
import 'package:toolkit/data/models/loto/save_assign_workforce_model.dart';
import 'package:toolkit/data/models/loto/start_loto_model.dart';

import '../../data/models/loto/accept_loto_model.dart';
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

  Future<AssignWorkForceForRemoveModel> assignWorkforceRemove(
      Map workforceRemoveMap);

  Future<FetchLotoAssignWorkforceModel> fetchLotoAssignWorkforceModel(
      String hashCode, String lotoId, int pageNo, String name, String isRemove);

  Future<FetchLotoAssignTeamModel> fetchLotoAssignTeam(
      String hashCode, String lotoId, int pageNo, String name, int isRemove);

  Future<SaveLotoAssignWorkforceModel> saveLotoAssignWorkforceModel(
      Map lotoAssignWorkforceMap);

  Future<ApplyLotoModel> applyLotoRepo(Map applyLotoMap);

  Future<AcceptLotoModel> acceptLotoRepo(Map acceptLotoMap);

  Future<StartLotoModel> startLotoRepo(Map startLotoMap);
}
