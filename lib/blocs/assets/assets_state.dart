part of 'assets_bloc.dart';

abstract class AssetsState {}

class AssetsInitial extends AssetsState {}

class AssetsListFetching extends AssetsState {}

class AssetsListFetched extends AssetsState {
  final FetchAssetsListModel fetchAssetsListModel;
  final List<AssetsListDatum> data;
  final bool hasReachedMax;
  final Map filtersMap;

  AssetsListFetched(
      {required this.fetchAssetsListModel,
      required this.data,
      required this.hasReachedMax,
      required this.filtersMap});
}

class AssetsListError extends AssetsState {
  final String errorMessage;

  AssetsListError({required this.errorMessage});
}

class AssetsDetailsFetching extends AssetsState {}

class AssetsDetailsFetched extends AssetsState {
  final FetchAssetsDetailsModel fetchAssetsDetailsModel;
  final List assetsPopUpMenu;
  final bool showPopUpMenu;

  AssetsDetailsFetched({
    required this.fetchAssetsDetailsModel,
    required this.assetsPopUpMenu,
    required this.showPopUpMenu,
  });
}

class AssetsDetailsError extends AssetsState {
  final String errorMessage;

  AssetsDetailsError({required this.errorMessage});
}

class AssetsMasterFetching extends AssetsState {}

class AssetsMasterFetched extends AssetsState {
  final FetchAssetsMasterModel fetchAssetsMasterModel;
  final Map assetsMasterMap;
  AssetsMasterFetched(
      {required this.fetchAssetsMasterModel, required this.assetsMasterMap});
}

class AssetsMasterError extends AssetsState {
  final String errorMessage;

  AssetsMasterError({required this.errorMessage});
}

class AssetsLocationSelected extends AssetsState {
  final String selectLocationName;

  AssetsLocationSelected({required this.selectLocationName});
}

class AssetsStatusSelected extends AssetsState {
  final String id;

  AssetsStatusSelected({required this.id});
}

class AssetsSiteSelected extends AssetsState {
  final String id;

  AssetsSiteSelected({required this.id});
}
