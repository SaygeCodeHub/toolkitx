part of 'loto_details_bloc.dart';

abstract class LotoDetailsState {}

class LotoDetailsInitial extends LotoDetailsState {}

class LotoDetailsFetching extends LotoDetailsState {}

class LotoDetailsFetched extends LotoDetailsState {
  final FetchLotoDetailsModel fetchLotoDetailsModel;
  final String clientId;
  final bool showPopUpMenu;
  final List lotoPopUpMenuList;

  LotoDetailsFetched({
    required this.fetchLotoDetailsModel,
    required this.showPopUpMenu,
    required this.lotoPopUpMenuList,
    required this.clientId,
  });
}

class LotoDetailsNotFetched extends LotoDetailsState {
  final String getError;

  LotoDetailsNotFetched({required this.getError});
}

class AssignWorkforceRemoving extends LotoDetailsState {}

class AssignWorkforceRemoved extends LotoDetailsState {
  final AssignWorkForceForRemoveModel assignWorkForceForRemoveModel;

  AssignWorkforceRemoved({required this.assignWorkForceForRemoveModel});
}

class AssignWorkforceRemoveError extends LotoDetailsState {
  final String getError;

  AssignWorkforceRemoveError({required this.getError});
}

class LotoAssignWorkforceFetching extends LotoDetailsState {}

class LotoAssignWorkforceFetched extends LotoDetailsState {
  final FetchLotoAssignWorkforceModel fetchLotoAssignWorkforceModel;

  LotoAssignWorkforceFetched({required this.fetchLotoAssignWorkforceModel});
}

class LotoAssignWorkforceError extends LotoDetailsState {
  final String getError;

  LotoAssignWorkforceError({required this.getError});
}

class LotoAssignWorkforceSearched extends LotoDetailsState {
  final bool isWorkforceSearched;

  LotoAssignWorkforceSearched({required this.isWorkforceSearched});
}

class LotoAssignWorkforceSaving extends LotoDetailsState {}

class LotoAssignWorkforceSaved extends LotoDetailsState {
  final SaveLotoAssignWorkforceModel saveLotoAssignWorkforceModel;

  LotoAssignWorkforceSaved({required this.saveLotoAssignWorkforceModel});
}

class LotoAssignWorkforceNotSaved extends LotoDetailsState {
  final String getError;

  LotoAssignWorkforceNotSaved({required this.getError});
}

class LotoAssignTeamSaving extends LotoDetailsState {}

class LotoAssignTeamSaved extends LotoDetailsState {
  final SaveLotoAssignTeamModel saveLotoAssignTeamModel;

  LotoAssignTeamSaved({required this.saveLotoAssignTeamModel});
}

class LotoAssignTeamNotSaved extends LotoDetailsState {
  final String getError;

  LotoAssignTeamNotSaved({required this.getError});
}

class LotoAssignTeamFetching extends LotoDetailsState {}

class LotoAssignTeamFetched extends LotoDetailsState {
  final FetchLotoAssignTeamModel fetchLotoAssignTeamModel;

  LotoAssignTeamFetched({required this.fetchLotoAssignTeamModel});
}

class LotoAssignTeamError extends LotoDetailsState {
  final String getError;

  LotoAssignTeamError({required this.getError});
}

class LotoStarting extends LotoDetailsState {}

class LotoStarted extends LotoDetailsState {
  final StartLotoModel startLotoModel;

  LotoStarted({required this.startLotoModel});
}

class LotoNotStarted extends LotoDetailsState {
  final String getError;

  LotoNotStarted({required this.getError});
}

class LotoRemoveStarting extends LotoDetailsState {}

class LotoRemoveStarted extends LotoDetailsState {
  final StartRemoveLotoModel startRemoveLotoModel;

  LotoRemoveStarted({required this.startRemoveLotoModel});
}

class LotoRemoveNotStarted extends LotoDetailsState {
  final String getError;

  LotoRemoveNotStarted({required this.getError});
}

class LotoApplying extends LotoDetailsState {}

class LotoApplied extends LotoDetailsState {
  final ApplyLotoModel applyLotoModel;

  LotoApplied({required this.applyLotoModel});
}

class LotoNotApplied extends LotoDetailsState {
  final String getError;

  LotoNotApplied({required this.getError});
}

class LotoAccepting extends LotoDetailsState {}

class LotoAccepted extends LotoDetailsState {
  final AcceptLotoModel acceptLotoModel;

  LotoAccepted({required this.acceptLotoModel});
}

class LotoNotAccepted extends LotoDetailsState {
  final String getError;

  LotoNotAccepted({required this.getError});
}

class LotoCommentAdding extends LotoDetailsState {}

class LotoCommentAdded extends LotoDetailsState {
  final AddLotoCommentModel addLotoCommentModel;

  LotoCommentAdded({required this.addLotoCommentModel});
}

class LotoCommentNotAdded extends LotoDetailsState {
  final String getError;

  LotoCommentNotAdded({required this.getError});
}

class LotoRemoving extends LotoDetailsState {}

class LotoRemoved extends LotoDetailsState {
  final RemoveLotoModel removeLotoModel;

  LotoRemoved({required this.removeLotoModel});
}

class LotoNotRemoved extends LotoDetailsState {
  final String getError;

  LotoNotRemoved({required this.getError});
}

class LotoPhotosUploading extends LotoDetailsState {}

class LotoPhotosUploaded extends LotoDetailsState {
  final LotoUploadPhotosModel lotoUploadPhotosModel;

  LotoPhotosUploaded({required this.lotoUploadPhotosModel});
}

class LotoPhotosNotUploaded extends LotoDetailsState {
  final String getError;

  LotoPhotosNotUploaded({required this.getError});
}

class LotoChecklistQuestionsFetching extends LotoDetailsState {}

class LotoChecklistQuestionsFetched extends LotoDetailsState {
  final FetchLotoChecklistQuestionsModel fetchLotoChecklistQuestionsModel;
  final List answerList;

  LotoChecklistQuestionsFetched(
      {required this.fetchLotoChecklistQuestionsModel,
      required this.answerList});
}

class LotoChecklistQuestionsNotFetched extends LotoDetailsState {
  final String errorMessage;

  LotoChecklistQuestionsNotFetched({required this.errorMessage});
}

class AnswerSelected extends LotoDetailsState {
  final int id;
  final String text;

  AnswerSelected({
    required this.id,
    required this.text,
  });
}

class LotoChecklistSaving extends LotoDetailsState {}

class LotoChecklistSaved extends LotoDetailsState {
  final SaveLotoChecklistModel saveLotoChecklistModel;

  LotoChecklistSaved({required this.saveLotoChecklistModel});
}

class LotoChecklistNotSaved extends LotoDetailsState {
  final String errorMessage;

  LotoChecklistNotSaved({required this.errorMessage});
}

class LotoAssignedChecklistFetching extends LotoDetailsState {}

class LotoAssignedChecklistFetched extends LotoDetailsState {
  final FetchLotoAssignedChecklistModel fetchLotoAssignedChecklistModel;

  LotoAssignedChecklistFetched({required this.fetchLotoAssignedChecklistModel});
}

class LotoAssignedChecklistNotFetched extends LotoDetailsState {
  final String errorMessage;

  LotoAssignedChecklistNotFetched({required this.errorMessage});
}

class AssignTeamRemoving extends LotoDetailsState {}

class AssignTeamRemoved extends LotoDetailsState {}

class AssignTeamRemoveError extends LotoDetailsState {
  final String errorMessage;

  AssignTeamRemoveError({required this.errorMessage});
}
