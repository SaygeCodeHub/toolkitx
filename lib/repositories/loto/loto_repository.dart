import '../../data/models/loto/loto_list_model.dart';
import '../../data/models/loto/loto_master_model.dart';

abstract class LotoRepository {
  Future<FetchLotoListModel> fetchLotoListRepo(
    int pageNo,
    String hashCode,
    String userId,
    String filter,
  );

  Future<FetchLotoMasterModel> fetchLotoMasterRepo(String hashCode);
}
