part of 'loto_details_bloc.dart';

abstract class LotoDetailsState {}

class LotoDetailsInitial extends LotoDetailsState {}

class LotoDetailsFetching extends LotoDetailsState {}

class LotoDetailsFetched extends LotoDetailsState {
  final FetchLotoDetailsModel fetchLotoDetailsModel;
  final List lotoPopUpMenu;
  final bool showPopUpMenu;

  LotoDetailsFetched(
      {required this.fetchLotoDetailsModel,
      required this.lotoPopUpMenu,
      required this.showPopUpMenu});
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
