part of 'tank_management_bloc.dart';

abstract class TankManagementState {}

class TankManagementInitial extends TankManagementState {}

class TankManagementListFetching extends TankManagementState {}

class TankManagementListFetched extends TankManagementState {
  final FetchTankManagementListModel fetchTankManagementListModel;

  TankManagementListFetched({required this.fetchTankManagementListModel});
}

class TankManagementListNotFetched extends TankManagementState {
  final String errorMessage;

  TankManagementListNotFetched({required this.errorMessage});
}

class TankManagementDetailsFetching extends TankManagementState {}

class TankManagementDetailsFetched extends TankManagementState {
  final FetchTankManagementDetailsModel fetchTankManagementDetailsModel;

  TankManagementDetailsFetched({required this.fetchTankManagementDetailsModel});
}

class TankManagementDetailsNotFetched extends TankManagementState {
  final String errorMessage;

  TankManagementDetailsNotFetched({required this.errorMessage});
}

class NominationChecklistFetching extends TankManagementState {}

class NominationChecklistFetched extends TankManagementState {
  final FetchNominationChecklistModel fetchNominationChecklistModel;

  NominationChecklistFetched({required this.fetchNominationChecklistModel});
}

class NominationChecklistNotFetched extends TankManagementState {
  final String errorMessage;

  NominationChecklistNotFetched({required this.errorMessage});
}