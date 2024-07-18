part of 'tank_management_bloc.dart';

abstract class TankManagementState {}

class TankManagementInitial extends TankManagementState {}

class TankManagementListFetching extends TankManagementState {}

class TankManagementListFetched extends TankManagementState {
  final FetchTankManagementListModel fetchTankManagementListModel;

  TankManagementListFetched({required this.fetchTankManagementListModel});
}

class TankManagementNotFetched extends TankManagementState {
  final String errorMessage;

  TankManagementNotFetched({required this.errorMessage});
}
