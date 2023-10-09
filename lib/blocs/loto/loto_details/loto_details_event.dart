part of 'loto_details_bloc.dart';

abstract class LotoDetailsEvent {}

class FetchLotoDetails extends LotoDetailsEvent {
  final int lotTabIndex;

  FetchLotoDetails({required this.lotTabIndex});
}

class FetchLotoAssignWorkforce extends LotoDetailsEvent {
  final int pageNo;
  final int isRemove;
  final String name;

  FetchLotoAssignWorkforce(
      {required this.pageNo, required this.isRemove, required this.name});
}

class SaveLotoAssignWorkForce extends LotoDetailsEvent {
  final int peopleId;

  SaveLotoAssignWorkForce({required this.peopleId});
}

class FetchLotoAssignTeam extends LotoDetailsEvent {
  final int pageNo;
  final int isRemove;
  final String name;

  FetchLotoAssignTeam(
      {required this.pageNo, required this.isRemove, required this.name});
}

class ApplyLotoEvent extends LotoDetailsEvent {
  ApplyLotoEvent();
}

class StartLotoEvent extends LotoDetailsEvent {
  StartLotoEvent();
}
