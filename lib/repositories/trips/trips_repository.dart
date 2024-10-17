import 'package:toolkit/data/models/trips/delete_trip_special_request.dart';
import 'package:toolkit/data/models/trips/fetch_trip_master_model.dart';
import 'package:toolkit/data/models/trips/fetch_trip_passengers_crew_list_model.dart';
import 'package:toolkit/data/models/trips/fetch_trip_special_request_model.dart';
import 'package:toolkit/data/models/trips/fetch_trips_list_model.dart';
import 'package:toolkit/data/models/trips/trip_add_special_request_model.dart';
import 'package:toolkit/data/models/trips/update_trip_special_request_model.dart';

import '../../data/models/trips/fetch_trip_details_model.dart';

abstract class TripsRepository {
  Future<FetchTripsListModel> fetchTripsList(
      int pageNo, String hashCode, String filter, String userId);

  Future<FetchTripDetailsModel> fetchTripDetails(
      String tripId, String hashCode, String userId);

  Future<FetchTripMasterModel> fetchTripMaster(String hashCode);

  Future<FetchTripPassengersCrewListModel> fetchTripPassengersCrewList(
      String hashCode, String tripId);

  Future<TripAddSpecialRequestModel> tripAddSpecialRequest(
      Map addSpecialRequestMap);

  Future<FetchTripSpecialRequestModel> fetchTripSpecialRequest(
      String hashCode, String requestId, String tripId);

  Future<UpdateTripSpecialRequestModel> updateTripSpecialRequest(
      Map updateSpecialRequestMap);

  Future<DeleteTripSpecialRequestModel> deleteTripSpecialRequest(
      Map deleteSpecialRequestMap);
}
