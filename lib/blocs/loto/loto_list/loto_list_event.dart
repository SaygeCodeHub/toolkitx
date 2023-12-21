part of 'loto_list_bloc.dart';

abstract class LotoListEvent {}

class FetchLotoList extends LotoListEvent {
  final int pageNo;
  final bool isFromHome;

  FetchLotoList({required this.pageNo, required this.isFromHome});
}

class FetchLotoMaster extends LotoListEvent {}

class SelectLotoStatusFilter extends LotoListEvent {
  final String selectedIndex;

  SelectLotoStatusFilter({required this.selectedIndex});
}

class SelectLotoLocationFilter extends LotoListEvent {
  final String selectLocationName;
  final String selectLocationId;

  SelectLotoLocationFilter(
      {required this.selectLocationId, required this.selectLocationName});
}

class ClearLotoListFilter extends LotoListEvent {}

class ApplyLotoListFilter extends LotoListEvent {
  final Map filterMap;

  ApplyLotoListFilter({required this.filterMap});
}
