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

class SelectAssetsReportFailureLocation extends AssetsEvent {
  final String selectLocationName;

  SelectAssetsReportFailureLocation({required this.selectLocationName});
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

class ClearAssetsDocumentFilter extends AssetsEvent {}

class FetchAssetsGetDownTime extends AssetsEvent {
  final String assetId;
  final int pageNo;

  FetchAssetsGetDownTime({required this.assetId, required this.pageNo});
}

class SaveAssetsDownTime extends AssetsEvent {
  final Map saveDowntimeMap;

  SaveAssetsDownTime({required this.saveDowntimeMap});
}

class FetchAssetsManageDocument extends AssetsEvent {
  final int pageNo;
  final String assetsId;

  FetchAssetsManageDocument({required this.assetsId, required this.pageNo});
}

class DeleteAssetsDownTime extends AssetsEvent {
  final String downtimeId;

  DeleteAssetsDownTime({required this.downtimeId});
}

class FetchAssetsSingleDowntime extends AssetsEvent {
  final String downtimeId;

  FetchAssetsSingleDowntime({required this.downtimeId});
}

class FetchAssetsComments extends AssetsEvent {
  FetchAssetsComments();
}

class AddAssetsComments extends AssetsEvent {
  final Map addAssetCommentMap;

  AddAssetsComments({required this.addAssetCommentMap});
}

class SelectAssetsFailureCode extends AssetsEvent {
  final String id;

  SelectAssetsFailureCode({required this.id});
}

class SaveAssetsReportFailure extends AssetsEvent {
  final Map assetsReportFailureMap;

  SaveAssetsReportFailure({required this.assetsReportFailureMap});
}

class SaveAssetsMeterReading extends AssetsEvent {
  final Map assetsMeterReadingMap;

  SaveAssetsMeterReading({required this.assetsMeterReadingMap});
}

class SelectAssetsMeter extends AssetsEvent {
  final int id;
  final String meterName;

  SelectAssetsMeter({required this.id, required this.meterName});
}

class SelectAssetsRollOver extends AssetsEvent {
  final String id;
  final String isRollover;

  SelectAssetsRollOver({required this.id, required this.isRollover});
}

class DeleteAssetsDocument extends AssetsEvent {
  final String documentId;

  DeleteAssetsDocument({required this.documentId});
}

class FetchAddAssetsDocument extends AssetsEvent {
  final int pageNo;
  final bool isFromHome;

  FetchAddAssetsDocument({required this.pageNo, required this.isFromHome});
}

class SelectAssetsDocument extends AssetsEvent {
  final bool isChecked;

  SelectAssetsDocument({required this.isChecked});
}

class AddManageDocument extends AssetsEvent {
  final Map addDocumentMap;
  AddManageDocument({required this.addDocumentMap});
}

class SelectAssetsDocumentTypeFilter extends AssetsEvent {
  final String selectedTypeId;
  final String selectedTypeName;

  SelectAssetsDocumentTypeFilter(
      {required this.selectedTypeId, required this.selectedTypeName});
}

class ApplyAssetsDocumentFilter extends AssetsEvent {
  final Map assetsDocumentFilterMap;

  ApplyAssetsDocumentFilter({required this.assetsDocumentFilterMap});
}
