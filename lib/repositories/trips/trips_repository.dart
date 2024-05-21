import 'package:toolkit/data/models/trips/fetch_trip_master_model.dart';
import 'package:toolkit/data/models/trips/fetch_trips_list_model.dart';

abstract class TripsRepository {
  Future<FetchTripsListModel> fetchTripsList(
      int pageNo, String hashCode, String filter, String userId);

  Future<FetchTripMasterModel> fetchTripMaster(String hashCode);
}
