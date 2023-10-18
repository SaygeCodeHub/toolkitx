import 'package:toolkit/data/models/assets/assets_details_model.dart';
import 'package:toolkit/data/models/assets/assets_list_model.dart';
import 'package:toolkit/data/models/assets/assets_master_model.dart';

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
}
