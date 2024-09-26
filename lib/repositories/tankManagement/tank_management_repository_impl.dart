import 'dart:convert';

import 'package:toolkit/data/models/tankManagement/fetch_nomination_checklist_model.dart';
import 'package:toolkit/data/models/tankManagement/fetch_tank_checklist_comments_model.dart';
import 'package:toolkit/data/models/tankManagement/fetch_tank_management_details_model.dart';
import 'package:toolkit/data/models/tankManagement/fetch_tank_management_list_module.dart';
import 'package:toolkit/data/models/tankManagement/fetch_tms_nomination_data_model.dart';
import 'package:toolkit/data/models/tankManagement/save_tank_questions_comments_model.dart';
import 'package:toolkit/repositories/tankManagement/tank_management_repository.dart';

import '../../data/models/tankManagement/fetch_tank_checklist_question_model.dart';
import '../../data/models/tankManagement/submit_nomination_checklist_model.dart';
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
    print(
        'fetchTankManagementDetails ${"${ApiConstants.baseUrl}nomination/getnomination?nominationid=$nominationId&hashcode=$hashCode"}');
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}nomination/getnomination?nominationid=$nominationId&hashcode=$hashCode");
    return FetchTankManagementDetailsModel.fromJson(response);
  }

  @override
  Future<FetchTmsNominationDataModel> fetchTmsNominationData(
      String nominationId, String hashCode) async {
    print(
        'fetchTmsNominationData ${"${ApiConstants.baseUrl}nomination/gettmsnominationdata?nominationid=$nominationId&hashcode=$hashCode"}');
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}nomination/gettmsnominationdata?nominationid=$nominationId&hashcode=$hashCode");
    return FetchTmsNominationDataModel.fromJson(response);
  }

  @override
  Future<FetchNominationChecklistModel> fetchNominationChecklist(
      String nominationId, String hashCode, String userId) async {
    print(
        'fetchTmsNominationData ${"${ApiConstants.baseUrl}nomination/gettmsnominationdata?nominationid=$nominationId&hashcode=$hashCode"}');
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}nomination/getnominationchecklist?nominationid=$nominationId&hashcode=$hashCode&userid=$userId");
    return FetchNominationChecklistModel.fromJson(response);
  }

  @override
  Future<SubmitNominationChecklistModel> saveNominationChecklist(
      Map tankChecklistMap) async {
    print('saveNominationChecklist map ${jsonEncode(tankChecklistMap)}');
    print(
        'saveNominationChecklist url ${"${ApiConstants.baseUrl}nomination/SaveNominationChecklist"}');
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}nomination/SaveNominationChecklist",
        tankChecklistMap);
    return SubmitNominationChecklistModel.fromJson(response);
  }

  @override
  Future<FetchTankChecklistQuestionModel> fetchTankQuestionsList(
      String scheduleId, String userId, String hashCode) async {
    print(
        'fetchTankQuestionsList ${"${ApiConstants.baseUrl}checklist/getquestions?scheduleid=$scheduleId&userid=$userId&hashcode=$hashCode"}');
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/getquestions?scheduleid=$scheduleId&userid=$userId&hashcode=$hashCode");
    return FetchTankChecklistQuestionModel.fromJson(response);
  }

  @override
  Future<FetchTankChecklistCommentsModel> fetchTankChecklistComments(
      String questionId, String hashCode) async {
    print(
        'fetchTankChecklistComments ${"${ApiConstants.baseUrl}checklist/getquestionresponsecomments?queresponseid=$questionId&hashcode=$hashCode"}');
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/getquestionresponsecomments?queresponseid=$questionId&hashcode=$hashCode");
    return FetchTankChecklistCommentsModel.fromJson(response);
  }

  @override
  Future<SaveTankQuestionCommentsModel> saveTankQuestionComments(
      Map tankCommentsMap) async {
    print('saveTankQuestionComments map ${jsonEncode(tankCommentsMap)}');
    print(
        'saveTankQuestionComments url ${"${ApiConstants.baseUrl}checklist/SaveQuestionResponseComments"}');
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}checklist/SaveQuestionResponseComments",
        tankCommentsMap);
    return SaveTankQuestionCommentsModel.fromJson(response);
  }
}
