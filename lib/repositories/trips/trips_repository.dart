import 'package:toolkit/data/models/trips/fetch_trips_list_model.dart';

import '../../data/models/trips/fetch_trip_details_model.dart';

abstract class TripsRepository {
  Future<FetchTripsListModel> fetchTripsList(
      int pageNo, String hashCode, String filter, String userId);

  Future<FetchTripDetailsModel> fetchTripDetails(
      String tripId, String hashCode, String userId);
}
