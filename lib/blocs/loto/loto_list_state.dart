part of 'loto_list_bloc.dart';

abstract class LotoListState {}

class LotoListInitial extends LotoListState {}

class FetchingLotoList extends LotoListState {}

class LotoListFetched extends LotoListState {
  final FetchLotoListModel fetchLotoListModel;
  final List<LotoListDatum> data;
  final bool hasReachedMax;
  final Map filtersMap;

  LotoListFetched({
    required this.fetchLotoListModel,
    required this.data,
    required this.hasReachedMax,
    required this.filtersMap,
  });
}

class LotoListError extends LotoListState {
  final String error;

  LotoListError({required this.error});
}

class FetchingLotoMaster extends LotoListState {}

class LotoMasterFetched extends LotoListState {
  final FetchLotoMasterModel fetchLotoMasterModel;
  final Map lotoMasterMap;
  LotoMasterFetched({
    required this.fetchLotoMasterModel,
    required this.lotoMasterMap,
  });
}

class LotoMasterFetchError extends LotoListState {
  final String lotoMasterError;

  LotoMasterFetchError({required this.lotoMasterError});
}

class LotoStatusFilterSelected extends LotoListState {
  final String selectedIndex;
  LotoStatusFilterSelected(this.selectedIndex);
}

class LotoLocationFilterSelected extends LotoListState {
  final String selectLocationName;

  LotoLocationFilterSelected(this.selectLocationName);
}
