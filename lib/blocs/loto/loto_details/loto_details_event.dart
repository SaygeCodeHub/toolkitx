part of 'loto_details_bloc.dart';

abstract class LotoDetailsEvent {}

class FetchLotoDetails extends LotoDetailsEvent {
  final String lotoId;
  final int lotTabIndex;

  FetchLotoDetails({required this.lotoId, required this.lotTabIndex});
}

class RemoveAssignWorkforce extends LotoDetailsEvent {
  final String peopleId;
  RemoveAssignWorkforce({required this.peopleId});
}
