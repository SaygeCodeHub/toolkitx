part of 'loto_details_bloc.dart';

abstract class LotoDetailsState {}

class LotoDetailsInitial extends LotoDetailsState {}

class LotoDetailsFetching extends LotoDetailsState {}

class LotoDetailsFetched extends LotoDetailsState {
  final FetchLotoDetailsModel fetchLotoDetailsModel;
  final bool showPopUpMenu;
  final List lotoPopUpMenuList;


  LotoDetailsFetched(
      {required this.fetchLotoDetailsModel,
      required this.showPopUpMenu , required this.lotoPopUpMenuList,});
}

class LotoDetailsNotFetched extends LotoDetailsState {
  final String getError;

  LotoDetailsNotFetched({required this.getError});
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
