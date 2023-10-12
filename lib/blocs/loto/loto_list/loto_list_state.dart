part of 'loto_list_bloc.dart';

abstract class LotoListState extends Equatable {
  const LotoListState();
  @override
  List<Object> get props => [];
}

class LotoListInitial extends LotoListState {}

class FetchingLotoList extends LotoListState {}

class LotoListFetched extends LotoListState {
  final FetchLotoListModel fetchLotoListModel;
  final List<LotoListDatum> data;
  final bool hasReachedMax;
  final Map filtersMap;

  const LotoListFetched({
    required this.fetchLotoListModel,
    required this.data,
    required this.hasReachedMax,
    required this.filtersMap,
  });

  @override
  List<Object> get props => [data];
}

class LotoListError extends LotoListState {
  final String error;

  const LotoListError({required this.error});
}

class FetchingLotoMaster extends LotoListState {}

class LotoMasterFetched extends LotoListState {
  final FetchLotoMasterModel fetchLotoMasterModel;
  final Map lotoMasterMap;
  const LotoMasterFetched({
    required this.fetchLotoMasterModel,
    required this.lotoMasterMap,
  });
}

class LotoMasterFetchError extends LotoListState {
  final String lotoMasterError;

  const LotoMasterFetchError({required this.lotoMasterError});
}

class LotoStatusFilterSelected extends LotoListState {
  final String selectedIndex;
  const LotoStatusFilterSelected(this.selectedIndex);
}

class LotoLocationFilterSelected extends LotoListState {
  final String selectLocationName;

  const LotoLocationFilterSelected(this.selectLocationName);
}
