part of 'assets_bloc.dart';

abstract class AssetsState {}

class AssetsInitial extends AssetsState {}

class AssetsListFetching extends AssetsState {}

class AssetsListFetched extends AssetsState {
  final FetchAssetsListModel fetchAssetsListModel;

  AssetsListFetched({required this.fetchAssetsListModel});
}

class AssetsListError extends AssetsState {
  final String errorMessage;

  AssetsListError({required this.errorMessage});
}
