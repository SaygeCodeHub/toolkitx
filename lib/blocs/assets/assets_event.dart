part of 'assets_bloc.dart';

abstract class AssetsEvent {}

class FetchAssetsList extends AssetsEvent {
  final int pageNo;

  FetchAssetsList({required this.pageNo});
}

class FetchAssetsDetails extends AssetsEvent {
  final String assetId;
  final int assetTabIndex;
  FetchAssetsDetails({required this.assetId, required this.assetTabIndex});
}
