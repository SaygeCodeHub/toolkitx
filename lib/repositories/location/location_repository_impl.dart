import 'package:toolkit/data/models/location/fetch_location_details_model.dart';

import '../../data/models/location/fetch_locations_model.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';
import 'location_repository.dart';

class LocationRepositoryImpl extends LocationRepository {
  @override
  Future<FetchLocationsModel> fetchLocations(
      int pageNo, String hashCode, String filter) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}common/getalllocations?pageno=$pageNo&hashcode=$hashCode&filter=$filter");
    return FetchLocationsModel.fromJson(response);
  }

  @override
  Future<FetchLocationDetailsModel> fetchLocationDetails(
      String locationId, String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}common/getlocation?hashcode=$hashCode&locationid=$locationId");
    return FetchLocationDetailsModel.fromJson(response);
  }
}
