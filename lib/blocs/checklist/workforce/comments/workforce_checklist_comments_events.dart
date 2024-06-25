abstract class WorkForceCheckListCommentsEvent {}

class CheckListFetchComment extends WorkForceCheckListCommentsEvent {
  final String questionResponseId;

  CheckListFetchComment({required this.questionResponseId});
}

class CheckListSaveComment extends WorkForceCheckListCommentsEvent {
  final Map saveQuestionCommentMap;

  CheckListSaveComment({required this.saveQuestionCommentMap});
}
