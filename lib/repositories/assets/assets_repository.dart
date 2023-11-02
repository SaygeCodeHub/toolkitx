import 'package:toolkit/data/models/assets/assets_details_model.dart';
import 'package:toolkit/data/models/assets/assets_list_model.dart';
import 'package:toolkit/data/models/assets_get_downtime_model.dart';

import '../../data/models/assets/assets_master_model.dart';
import '../../data/models/assets/save_assets_downtime_model.dart';

abstract class AssetsRepository {
  Future<FetchAssetsListModel> fetchAssetsListRepo(
      int pageNo, String hashCode, String filter);

  Future<FetchAssetsDetailsModel> fetchAssetsDetailsRepo(
      String hashCode, String assetId);

  Future<FetchAssetsMasterModel> fetchAssetsMasterRepo(String hashCode);

  Future<FetchAssetsDowntimeModel> fetchAssetsDowntimeRepo(
      int pageNo, String hashCode, String assetId);

  Future<SaveAssetsDowntimeModel> saveAssetsDowntimeRepo(Map saveDowntimeMap);
}
