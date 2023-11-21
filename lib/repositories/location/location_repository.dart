import '../../data/models/location/fetch_location_assets_model.dart';
import '../../data/models/location/fetch_location_details_model.dart';
import '../../data/models/location/fetch_location_loto_model.dart';
import '../../data/models/location/fetch_location_permits_model.dart';
import '../../data/models/location/fetch_locations_model.dart';

abstract class LocationRepository {
  Future<FetchLocationsModel> fetchLocations(int pageNo, String hashCode,
      String filter);

  Future<FetchLocationDetailsModel> fetchLocationDetails(String locationId,
      String hashCode);

  Future<FetchLocationPermitsModel> fetchLocationPermits(int pageNo,
      String hashCode, String filter, String locationId);

  Future<FetchLocationLoToModel> fetchLocationLoTo(int pageNo, String hashCode,
      String userId, String filter, String locationId);

  Future<FetchLocationAssetsModel> fetchLocationAssets(int pageNo,
      String hashCode, String filter);
}
