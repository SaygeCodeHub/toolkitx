import '../../data/models/workforce/workforce_fetch_comment_model.dart';
import '../../data/models/workforce/workforce_list_model.dart';
import '../../data/models/workforce/workforce_questions_list_model.dart';
import '../../data/models/workforce/workforce_save_comment_model.dart';

abstract class WorkForceRepository {
  Future<WorkforceGetCheckListModel> fetchWorkforceList(
      String userId, String hashCode);

  Future<GetQuestionListModel> fetchQuestionsList(
      String scheduleId, String userId, String hashCode);

  Future<GetQuestionCommentsModel> fetchComment(
      String questionResponseId, String hashCode);

  Future<SaveQuestionCommentsModel> saveComment(Map saveQuestionsCommentMap);
}
