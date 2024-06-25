import 'package:equatable/equatable.dart';

import '../../../../data/models/checklist/workforce/workforce_fetch_comment_model.dart';
import '../../../../data/models/checklist/workforce/workforce_save_comment_model.dart';

abstract class WorkForceCheckListCommentStates extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CheckListCommentsInitial extends WorkForceCheckListCommentStates {}

class CheckListFetchingComment extends WorkForceCheckListCommentStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CheckListCommentFetched extends WorkForceCheckListCommentStates {
  final GetQuestionCommentsModel getQuestionCommentsModel;

  CheckListCommentFetched({required this.getQuestionCommentsModel});

  @override
  List<Object?> get props => [getQuestionCommentsModel];
}

class CheckListCommentNotFetched extends WorkForceCheckListCommentStates {
  final String quesResponseId;

  CheckListCommentNotFetched({required this.quesResponseId});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class CheckListSavingComment extends WorkForceCheckListCommentStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CheckListCommentSaved extends WorkForceCheckListCommentStates {
  final SaveQuestionCommentsModel saveQuestionCommentsModel;

  CheckListCommentSaved({required this.saveQuestionCommentsModel});

  @override
  List<Object?> get props => [saveQuestionCommentsModel];
}

class CheckListCommentNotSaved extends WorkForceCheckListCommentStates {
  final String message;

  CheckListCommentNotSaved({required this.message});

  @override
  List<Object?> get props => throw UnimplementedError();
}
