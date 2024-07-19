part of 'tank_management_bloc.dart';

abstract class TankManagementEvent {}

class FetchTankManagementList extends TankManagementEvent {
  final int pageNo;
  final bool isFromHome;

  FetchTankManagementList({required this.pageNo, required this.isFromHome});
}

class FetchTankManagementDetails extends TankManagementEvent {
  final String nominationId;

  FetchTankManagementDetails({required this.nominationId});
}

class FetchTmsNominationData extends TankManagementEvent {
  final String nominationId;

  FetchTmsNominationData({required this.nominationId});
}