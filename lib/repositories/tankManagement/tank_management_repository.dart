import 'package:toolkit/data/models/tankManagement/fetch_nomination_checklist_model.dart';
import 'package:toolkit/data/models/tankManagement/fetch_tank_checklist_comments_model.dart';
import 'package:toolkit/data/models/tankManagement/fetch_tank_checklist_question_model.dart';
import 'package:toolkit/data/models/tankManagement/fetch_tank_management_details_model.dart';
import 'package:toolkit/data/models/tankManagement/fetch_tank_management_list_module.dart';
import 'package:toolkit/data/models/tankManagement/save_tank_questions_comments_model.dart';

import '../../data/models/tankManagement/submit_nomination_checklist_model.dart';

abstract class TankManagementRepository {
  Future<FetchTankManagementListModel> fetchTankManagementList(
      int pageNo, String hashCode, String filter, String userId);

  Future<FetchTankManagementDetailsModel> fetchTankManagementDetails(
      String nominationId, String hashCode);

  Future<FetchNominationChecklistModel> fetchNominationChecklist(
      String nominationId, String hashCode, String userId);

  Future<SubmitNominationChecklistModel> saveNominationChecklist(
      Map tankChecklistMap);

  Future<FetchTankChecklistQuestionModel> fetchTankQuestionsList(
      String scheduleId, String userId, String hashCode);

  Future<FetchTankChecklistCommentsModel> fetchTankChecklistComments(
      String questionId, String hashCode);

  Future<SaveTankQuestionCommentsModel> saveTankQuestionComments(
      Map tankCommentsMap);
}
