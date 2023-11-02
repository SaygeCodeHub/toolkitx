part of 'assets_bloc.dart';

abstract class AssetsEvent {}

class FetchAssetsList extends AssetsEvent {
  final int pageNo;
  final bool isFromHome;

  FetchAssetsList({required this.pageNo, required this.isFromHome});
}

class FetchAssetsDetails extends AssetsEvent {
  final String assetId;
  final int assetTabIndex;

  FetchAssetsDetails({required this.assetId, required this.assetTabIndex});
}

class SelectAssetsLocation extends AssetsEvent {
  final String selectLocationName;

  SelectAssetsLocation({required this.selectLocationName});
}

class FetchAssetsMaster extends AssetsEvent {}

class SelectAssetsStatus extends AssetsEvent {
  final String id;

  SelectAssetsStatus({required this.id});
}

class SelectAssetsSite extends AssetsEvent {
  final String id;

  SelectAssetsSite({required this.id});
}

class ApplyAssetsFilter extends AssetsEvent {
  final Map assetsFilterMap;

  ApplyAssetsFilter({required this.assetsFilterMap});
}

class ClearAssetsFilter extends AssetsEvent {}

class FetchAssetsGetDownTime extends AssetsEvent {
  final String assetId;
  final int pageNo;
  FetchAssetsGetDownTime({required this.assetId, required this.pageNo});
}

class SaveAssetsDownTime extends AssetsEvent {
  final Map saveDowntimeMap;

  SaveAssetsDownTime({required this.saveDowntimeMap});
}
