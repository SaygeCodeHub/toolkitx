part of 'loto_list_bloc.dart';

abstract class LotoListState {}

class LotoListInitial extends LotoListState {}

class FetchingLotoList extends LotoListState {}

class LotoListFetched extends LotoListState {
  final FetchLotoListModel fetchLotoListModel;
  final List<LotoListDatum> data;
  final bool hasReachedMax;

  LotoListFetched({
    required this.fetchLotoListModel,
    required this.data,
    required this.hasReachedMax,
  });
}

class LotoListError extends LotoListState {
  final String error;

  LotoListError({required this.error});
}
