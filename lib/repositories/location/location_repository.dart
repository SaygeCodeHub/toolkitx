import '../../data/models/location/fetch_locations_model.dart';

abstract class LocationRepository {
  Future<FetchLocationsModel> fetchLocations(
      int pageNo, String hashCode, String filter);
}
