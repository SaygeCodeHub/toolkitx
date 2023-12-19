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

class AssetsReportFailureLocationSelected extends AssetsState {
  final String selectLocationName;

  AssetsReportFailureLocationSelected({required this.selectLocationName});
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
  final List assetDowntimeDatum;
  final List assetsPopUpMenu;
  final bool showPopUpMenu;

  AssetsGetDownTimeFetched({
    required this.assetsPopUpMenu,
    required this.showPopUpMenu,
    required this.assetDowntimeDatum,
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
  final List manageDocumentDatum;
  final List assetsPopUpMenu;
  final bool showPopUpMenu;

  AssetsGetDocumentFetched({
    required this.manageDocumentDatum,
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

class AssetsCommentsFetching extends AssetsState {}

class AssetsCommentsFetched extends AssetsState {
  final FetchAssetsCommentsModel fetchAssetsCommentsModel;
  final String clientId;

  AssetsCommentsFetched(
      {required this.fetchAssetsCommentsModel, required this.clientId});
}

class AssetsCommentsError extends AssetsState {
  final String errorMessage;

  AssetsCommentsError({required this.errorMessage});
}

class AssetsCommentsAdding extends AssetsState {}

class AssetsCommentsAdded extends AssetsState {
  final AssetsAddCommentsModel assetsAddCommentsModel;

  AssetsCommentsAdded({required this.assetsAddCommentsModel});
}

class AssetsCommentsNotAdded extends AssetsState {
  final String errorMessage;

  AssetsCommentsNotAdded({required this.errorMessage});
}

class AssetsFailureCodeSelected extends AssetsState {
  final String id;

  AssetsFailureCodeSelected({required this.id});
}

class AssetsReportFailureSaving extends AssetsState {}

class AssetsReportFailureSaved extends AssetsState {
  final SaveAssetsReportFailureModel saveAssetsReportFailureModel;

  AssetsReportFailureSaved({required this.saveAssetsReportFailureModel});
}

class AssetsReportFailureNotSaved extends AssetsState {
  final String errorMessage;

  AssetsReportFailureNotSaved({required this.errorMessage});
}

class AssetsMeterReadingSaving extends AssetsState {}

class AssetsMeterReadingSaved extends AssetsState {
  final SaveAssetsMeterReadingModel saveAssetsMeterReadingModel;

  AssetsMeterReadingSaved({required this.saveAssetsMeterReadingModel});
}

class AssetsMeterReadingNotSaved extends AssetsState {
  final String errorMessage;

  AssetsMeterReadingNotSaved({required this.errorMessage});
}

class AssetsMeterSelected extends AssetsState {
  final int id;
  final String meterName;

  AssetsMeterSelected({required this.id, required this.meterName});
}

class AssetsRollOverSelected extends AssetsState {
  final String id;
  final String isRollover;

  AssetsRollOverSelected({required this.id, required this.isRollover});
}

class AssetsDocumentDeleting extends AssetsState {}

class AssetsDocumentDeleted extends AssetsState {}

class AssetsDocumentNotDeleted extends AssetsState {
  final String errorMessage;

  AssetsDocumentNotDeleted({required this.errorMessage});
}

class AddAssetsDocumentFetching extends AssetsState {}

class AddAssetsDocumentFetched extends AssetsState {
  final FetchAddAssetsDocumentModel fetchAddAssetsDocumentModel;
  final Map documentFilterMap;
  final List<AddDocumentDatum> data;

  AddAssetsDocumentFetched(
      {required this.fetchAddAssetsDocumentModel,
      required this.documentFilterMap,
      required this.data});
}

class AddAssetsDocumentNotFetched extends AssetsState {
  final String errorMessage;

  AddAssetsDocumentNotFetched({required this.errorMessage});
}

class AssetsDocumentSelected extends AssetsState {
  final bool isChecked;

  AssetsDocumentSelected({required this.isChecked});
}

class ManageDocumentAdding extends AssetsState {}

class ManageDocumentAdded extends AssetsState {}

class ManageDocumentNotAdded extends AssetsState {
  final String errorMessage;

  ManageDocumentNotAdded({required this.errorMessage});
}

class AssetsDocumentTypeFilterSelected extends AssetsState {
  final String selectedTypeId;
  final String selectedTypeName;

  AssetsDocumentTypeFilterSelected(
      {required this.selectedTypeId, required this.selectedTypeName});
}
