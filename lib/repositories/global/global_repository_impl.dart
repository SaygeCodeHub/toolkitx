import 'package:toolkit/data/models/global/uodate_count_model.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';
import 'global_repository.dart';

class GlobalRepositoryImpl extends GlobalRepository {
  @override
  Future<UpdateCountModel> updateCount(Map updateCountMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}common/updatecount", updateCountMap);
    return UpdateCountModel.fromJson(response);
  }
}
