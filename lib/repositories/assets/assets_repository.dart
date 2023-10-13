import 'package:toolkit/data/models/assets/assets_list_model.dart';

abstract class AssetsRepository {
  Future<FetchAssetsListModel> fetchAssetsListRepo(
      int pageNo, String hashCode, String filter);
}
