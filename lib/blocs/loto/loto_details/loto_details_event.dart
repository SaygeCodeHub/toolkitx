part of 'loto_details_bloc.dart';

abstract class LotoDetailsEvent {}

class FetchLotoDetails extends LotoDetailsEvent {
  final String lotoId;
  final int lotTabIndex;

  FetchLotoDetails({required this.lotoId, required this.lotTabIndex});
}

class FetchLotoAssignWorkforce extends LotoDetailsEvent {
  final String lotoId;
  final int pageNo;
  final int isRemove;
  final String name;

  FetchLotoAssignWorkforce(
      {required this.lotoId,
      required this.pageNo,
      required this.isRemove,
      required this.name});
}
