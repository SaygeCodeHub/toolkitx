import '../../../data/models/checklist/workforce/workforce_checklist_save_reject_reason_model.dart';
import '../../../data/models/checklist/workforce/workforce_checklist_submit_answer_model.dart';
import '../../../data/models/checklist/workforce/workforce_fetch_comment_model.dart';
import '../../../data/models/checklist/workforce/workforce_fetch_reject_reason_model.dart';
import '../../../data/models/checklist/workforce/workforce_list_model.dart';
import '../../../data/models/checklist/workforce/workforce_questions_list_model.dart';
import '../../../data/models/checklist/workforce/workforce_save_comment_model.dart';

abstract class WorkForceRepository {
  Future<WorkforceGetCheckListModel> fetchWorkforceList(
      String userId, String hashCode);

  Future<GetQuestionListModel> fetchQuestionsList(
      String scheduleId, String userId, String hashCode);

  Future<GetQuestionCommentsModel> fetchComment(
      String questionResponseId, String hashCode);

  Future<SaveQuestionCommentsModel> saveComment(Map saveQuestionsCommentMap);

  Future<GetCheckListRejectReasonsModel> fetchChecklistRejectReason(
      String hashCode);

  Future<PostRejectReasonsModel> saveRejectReasons(Map saveRejectReasonsMap);

  Future<SubmitQuestionModel> submitAnswer(Map submitAnswerMap);
}
