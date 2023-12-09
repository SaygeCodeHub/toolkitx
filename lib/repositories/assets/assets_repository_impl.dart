import 'package:toolkit/data/models/assets/assets_delete_document_model.dart';
import 'package:toolkit/data/models/assets/assets_delete_downtime_model.dart';
import 'package:toolkit/data/models/assets/assets_details_model.dart';
import 'package:toolkit/data/models/assets/assets_list_model.dart';
import 'package:toolkit/data/models/assets/assets_master_model.dart';
import 'package:toolkit/data/models/assets/fetch_asset_single_downtime_model.dart';
import 'package:toolkit/data/models/assets/fetch_assets_comment_model.dart';
import 'package:toolkit/data/models/assets/fetch_assets_document_model.dart';
import 'package:toolkit/data/models/assets/save_assets_downtime_model.dart';
import 'package:toolkit/data/models/assets/save_assets_meter_reading_model.dart';
import 'package:toolkit/data/models/assets/save_assets_report_failure_model.dart';
import 'package:toolkit/data/models/assets_get_downtime_model.dart';
import '../../data/models/assets/assets_add_comments_model.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';
import 'assets_repository.dart';

class AssetsRepositoryImpl extends AssetsRepository {
  @override
  Future<FetchAssetsListModel> fetchAssetsListRepo(
      int pageNo, String hashCode, String filter) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}asset/get?pageno=$pageNo&hashcode=$hashCode&filter=$filter");
    return FetchAssetsListModel.fromJson(response);
  }

  @override
  Future<FetchAssetsDetailsModel> fetchAssetsDetailsRepo(
      String hashCode, String assetId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}asset/getasset?hashcode=$hashCode&assetid=$assetId");
    return FetchAssetsDetailsModel.fromJson(response);
  }

  @override
  Future<FetchAssetsMasterModel> fetchAssetsMasterRepo(String hashCode) async {
    final response = await DioClient()
        .get("${ApiConstants.baseUrl}asset/getmaster?hashcode=$hashCode");
    return FetchAssetsMasterModel.fromJson(response);
  }

  @override
  Future<FetchAssetsDowntimeModel> fetchAssetsDowntimeRepo(
      int pageNo, String hashCode, String assetId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}asset/getdowntime?pageno=$pageNo&hashcode=$hashCode&filter=$assetId");
    return FetchAssetsDowntimeModel.fromJson(response);
  }

  @override
  Future<SaveAssetsDowntimeModel> saveAssetsDowntimeRepo(
      Map saveDowntimeMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}asset/savedowntime", saveDowntimeMap);
    return SaveAssetsDowntimeModel.fromJson(response);
  }

  @override
  Future<FetchAssetsManageDocumentModel> fetchAssetsDocument(
      int pageNo, String hashCode, String assetId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}asset/getdocuments?pageno=$pageNo&hashcode=$hashCode&filter=$assetId");
    return FetchAssetsManageDocumentModel.fromJson(response);
  }

  @override
  Future<FetchAssetSingleDowntimeModel> fetchAssetsSingleDowntimeRepo(
      String hashCode, String downtimeId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}asset/getsingledowntime?hashcode=$hashCode&downtimeid=$downtimeId");
    return FetchAssetSingleDowntimeModel.fromJson(response);
  }

  @override
  Future<AssetsDeleteDowntimeModel> assetsDeleteDowntimeRepo(
      Map deleteDowntimeMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}asset/deletedowntime", deleteDowntimeMap);
    return AssetsDeleteDowntimeModel.fromJson(response);
  }

  @override
  Future<FetchAssetsCommentsModel> fetchAssetsCommentsRepo(
      String hashCode, String assetId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}asset/getcomments?hashcode=$hashCode&filter=$assetId");
    return FetchAssetsCommentsModel.fromJson(response);
  }

  @override
  Future<AssetsAddCommentsModel> assetsAddCommentsRepo(
      Map addCommentMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}asset/savecomments", addCommentMap);
    return AssetsAddCommentsModel.fromJson(response);
  }

  @override
  Future<SaveAssetsReportFailureModel> saveAssetsReportFailureRepo(
      Map assetsReportFailureMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}asset/reportequipmentfailure",
        assetsReportFailureMap);
    return SaveAssetsReportFailureModel.fromJson(response);
  }

  @override
  Future<SaveAssetsMeterReadingModel> saveAssetsMeterReadingRepo(
      Map assetsMeterReadingMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}asset/savemeterreading", assetsMeterReadingMap);
    return SaveAssetsMeterReadingModel.fromJson(response);
  }

  @override
  Future<AssetsDeleteDocumentModel> assetsDeleteDocumentRepo(
      Map deleteDocumentMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}asset/deletedocument", deleteDocumentMap);
    return AssetsDeleteDocumentModel.fromJson(response);
  }
}
