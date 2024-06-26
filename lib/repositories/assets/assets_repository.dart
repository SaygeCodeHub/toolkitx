import 'package:toolkit/data/models/assets/add_manage_document_model.dart';
import 'package:toolkit/data/models/assets/assets_add_comments_model.dart';
import 'package:toolkit/data/models/assets/assets_details_model.dart';
import 'package:toolkit/data/models/assets/assets_list_model.dart';
import 'package:toolkit/data/models/assets/fetch_add_assets_document_model.dart';
import 'package:toolkit/data/models/assets/fetch_asset_single_downtime_model.dart';
import 'package:toolkit/data/models/assets/fetch_assets_comment_model.dart';
import 'package:toolkit/data/models/assets/save_assets_meter_reading_model.dart';
import 'package:toolkit/data/models/assets/save_assets_report_failure_model.dart';
import 'package:toolkit/data/models/assets_get_downtime_model.dart';
import '../../data/models/assets/assets_delete_document_model.dart';
import '../../data/models/assets/assets_delete_downtime_model.dart';
import '../../data/models/assets/assets_master_model.dart';
import '../../data/models/assets/fetch_assets_document_model.dart';
import '../../data/models/assets/save_assets_downtime_model.dart';

abstract class AssetsRepository {
  Future<FetchAssetsListModel> fetchAssetsListRepo(
      int pageNo, String hashCode, String filter);

  Future<FetchAssetsDetailsModel> fetchAssetsDetailsRepo(
      String hashCode, String assetId);

  Future<FetchAssetsMasterModel> fetchAssetsMasterRepo(String hashCode);

  Future<FetchAssetsDowntimeModel> fetchAssetsDowntimeRepo(
      int pageNo, String hashCode, String assetId);

  Future<FetchAssetsManageDocumentModel> fetchAssetsDocument(
      int pageNo, String hashCode, String assetId);

  Future<SaveAssetsDowntimeModel> saveAssetsDowntimeRepo(Map saveDowntimeMap);

  Future<AssetsDeleteDowntimeModel> assetsDeleteDowntimeRepo(
      Map deleteDowntimeMap);

  Future<FetchAssetSingleDowntimeModel> fetchAssetsSingleDowntimeRepo(
      String hashCode, String downtimeId);

  Future<FetchAssetsCommentsModel> fetchAssetsCommentsRepo(
      String hashCode, String assetId);

  Future<AssetsAddCommentsModel> assetsAddCommentsRepo(Map addCommentMap);

  Future<SaveAssetsReportFailureModel> saveAssetsReportFailureRepo(
      Map assetsReportFailureMap);

  Future<SaveAssetsMeterReadingModel> saveAssetsMeterReadingRepo(
      Map assetsMeterReadingMap);

  Future<AssetsDeleteDocumentModel> assetsDeleteDocumentRepo(
      Map deleteDocumentMap);

  Future<FetchAddAssetsDocumentModel> fetchAddAssetsDocument(
      int pageNo, String hashCode, String assetId, String filter);

  Future<AddManageDocumentModel> addManageDocumentRepo(Map addDocumentMap);
}
