import 'package:toolkit/data/models/loto/apply_loto_model.dart';
import 'package:toolkit/data/models/loto/delete_loto_workforce_model.dart';
import 'package:toolkit/data/models/loto/assign_team_for_remove_model.dart';
import 'package:toolkit/data/models/loto/fetch_assigned_checklists.dart';
import 'package:toolkit/data/models/loto/fetch_loto_assign_workforce_model.dart';
import 'package:toolkit/data/models/loto/assign_workforce_for_remove_model.dart';
import 'package:toolkit/data/models/loto/fetch_loto_checklist_questions_model.dart';
import 'package:toolkit/data/models/loto/loto_details_model.dart';
import 'package:toolkit/data/models/loto/loto_upload_photos_model.dart';
import 'package:toolkit/data/models/loto/remove_loto_model.dart';
import 'package:toolkit/data/models/loto/save_assign_workforce_model.dart';
import 'package:toolkit/data/models/loto/save_loto_checklist_model.dart';
import 'package:toolkit/data/models/loto/start_loto_model.dart';

import '../../data/models/loto/accept_loto_model.dart';
import '../../data/models/loto/add_loto_comment_model.dart';
import '../../data/models/loto/fetch_loto_assign_team_model.dart';
import '../../data/models/loto/loto_list_model.dart';
import '../../data/models/loto/loto_master_model.dart';
import '../../data/models/loto/reject_loto_model.dart';
import '../../data/models/loto/save_loto_assign_team_model.dart';
import '../../data/models/loto/start_remove_loto_model.dart';

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

  Future<SaveLotoAssignTeamModel> saveLotoAssignTeam(Map lotoAssignTeamMap);

  Future<ApplyLotoModel> applyLotoRepo(Map applyLotoMap);

  Future<AcceptLotoModel> acceptLotoRepo(Map acceptLotoMap);

  Future<RemoveLotoModel> removeLotoRepo(Map removeLotoMap);

  Future<RejectLotoModel> rejectLotoRepo(Map rejectLotoMap);

  Future<StartLotoModel> startLotoRepo(Map startLotoMap);

  Future<StartRemoveLotoModel> startRemoveLotoRepo(Map startRemoveLotoMap);

  Future<AddLotoCommentModel> addLotoCommentRepo(Map addLotoCommentMap);

  Future<LotoUploadPhotosModel> lotoUploadPhotosRepo(Map lotoUploadPhotosMap);

  Future<FetchLotoChecklistQuestionsModel> fetchLotoChecklistQuestions(
      String hashCode, String lotoId, String checklistId, String isRemove);

  Future<SaveLotoChecklistModel> saveLotoChecklist(Map saveLotoChecklistMap);

  Future<FetchLotoAssignedChecklistModel> fetchLotoAssignedChecklist(
      String hashCode, String lotoId, String isRemove);

  Future<AssignTeamForRemoveModel> assignTeamForRemove(
      Map removeAssignTeamForMap);

  Future<DeleteLotoWorkforceModel> deleteWorkforce(Map deleteWorkforceMap);
}
