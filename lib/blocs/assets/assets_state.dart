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

class AssetsGetDownTimeFetching extends AssetsState {}

class AssetsGetDownTimeFetched extends AssetsState {
  final FetchAssetsDowntimeModel fetchAssetsDowntimeModel;
  final List assetsPopUpMenu;
  final bool showPopUpMenu;

  AssetsGetDownTimeFetched({
    required this.fetchAssetsDowntimeModel,
    required this.assetsPopUpMenu,
    required this.showPopUpMenu,
  });
}

class AssetsGetDownTimeError extends AssetsState {
  final String errorMessage;

  AssetsGetDownTimeError({required this.errorMessage});
}

class AssetsDownTimeSaving extends AssetsState {}

class AssetsDownTimeSaved extends AssetsState {
  final SaveAssetsDowntimeModel saveAssetsDowntimeModel;

  AssetsDownTimeSaved({required this.saveAssetsDowntimeModel});
}

class AssetsDownTimeNotSaved extends AssetsState {
  final String errorMessage;

  AssetsDownTimeNotSaved({required this.errorMessage});
}

class AssetsGetDocumentFetching extends AssetsState {}

class AssetsGetDocumentFetched extends AssetsState {
  final FetchAssetsManageDocumentModel fetchAssetsManageDocumentModel;
  final List assetsPopUpMenu;
  final bool showPopUpMenu;

  AssetsGetDocumentFetched({
    required this.fetchAssetsManageDocumentModel,
    required this.assetsPopUpMenu,
    required this.showPopUpMenu,
  });
}

class AssetsGetDocumentError extends AssetsState {
  final String errorMessage;

  AssetsGetDocumentError({required this.errorMessage});
}

class AssetsDownTimeDeleting extends AssetsState {}

class AssetsDownTimeDeleted extends AssetsState {
  final AssetsDeleteDowntimeModel assetsDeleteDowntimeModel;

  AssetsDownTimeDeleted({required this.assetsDeleteDowntimeModel});
}

class AssetsDownTimeNotDeleted extends AssetsState {
  final String errorMessage;

  AssetsDownTimeNotDeleted({required this.errorMessage});
}

class AssetsSingleDownTimeFetching extends AssetsState {}

class AssetsSingleDownTimeFetched extends AssetsState {
  final FetchAssetSingleDowntimeModel fetchAssetSingleDowntimeModel;

  AssetsSingleDownTimeFetched({required this.fetchAssetSingleDowntimeModel});
}

class AssetsSingleDownTimeError extends AssetsState {
  final String errorMessage;

  AssetsSingleDownTimeError({required this.errorMessage});
}
