import 'package:toolkit/data/models/trips/fetch_trips_list_model.dart';
import 'package:toolkit/repositories/trips/trips_repository.dart';

import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';

class TripsRepositoryImpl extends TripsRepository {
  @override
  Future<FetchTripsListModel> fetchTripsList(
      int pageNo, String hashCode, String filter, String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}trip/get?pageno=$pageNo&hashcode=$hashCode&filter=$filter&userid=$userId");
    return FetchTripsListModel.fromJson(response);
  }
}
