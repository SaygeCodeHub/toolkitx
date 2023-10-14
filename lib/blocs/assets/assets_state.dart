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

class AssetsDetailsFetching extends AssetsState {}

class AssetsDetailsFetched extends AssetsState {
  final FetchAssetsDetailsModel fetchAssetsDetailsModel;

  AssetsDetailsFetched({required this.fetchAssetsDetailsModel});
}

class AssetsDetailsError extends AssetsState {
  final String errorMessage;

  AssetsDetailsError({required this.errorMessage});
}
