part of 'loto_details_bloc.dart';

abstract class LotoDetailsEvent {}

class FetchLotoDetails extends LotoDetailsEvent {
  final int lotTabIndex;

  FetchLotoDetails({required this.lotTabIndex});
}

class FetchLotoAssignWorkforce extends LotoDetailsEvent {
  final int pageNo;
  final String isRemove;
  final String workforceName;

  FetchLotoAssignWorkforce(
      {required this.pageNo,
      required this.isRemove,
      required this.workforceName});
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

class SearchLotoAssignWorkForce extends LotoDetailsEvent {
  final bool isWorkforceSearched;

  SearchLotoAssignWorkForce({required this.isWorkforceSearched});
}

class StartLotoEvent extends LotoDetailsEvent {
  StartLotoEvent();
}
