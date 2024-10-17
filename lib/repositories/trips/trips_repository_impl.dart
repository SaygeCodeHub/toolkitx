import 'package:toolkit/data/models/trips/delete_trip_special_request.dart';
import 'package:toolkit/data/models/trips/fetch_trip_master_model.dart';
import 'package:toolkit/data/models/trips/fetch_trip_details_model.dart';
import 'package:toolkit/data/models/trips/fetch_trip_passengers_crew_list_model.dart';
import 'package:toolkit/data/models/trips/fetch_trip_special_request_model.dart';
import 'package:toolkit/data/models/trips/fetch_trips_list_model.dart';
import 'package:toolkit/data/models/trips/trip_add_special_request_model.dart';
import 'package:toolkit/data/models/trips/update_trip_special_request_model.dart';
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

  @override
  Future<FetchTripDetailsModel> fetchTripDetails(
      String tripId, String hashCode, String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}trip/gettrip?tripid=$tripId&hashcode=$hashCode&userid=$userId");
    return FetchTripDetailsModel.fromJson(response);
  }

  @override
  Future<FetchTripMasterModel> fetchTripMaster(String hashCode) async {
    final response = await DioClient()
        .get("${ApiConstants.baseUrl}trip/getmaster?hashcode=$hashCode");
    return FetchTripMasterModel.fromJson(response);
  }

  @override
  Future<FetchTripPassengersCrewListModel> fetchTripPassengersCrewList(
      String hashCode, String tripId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}trip/getpassengerscrewlist?hashcode=$hashCode&tripid=$tripId");
    return FetchTripPassengersCrewListModel.fromJson(response);
  }

  @override
  Future<TripAddSpecialRequestModel> tripAddSpecialRequest(
      Map addSpecialRequestMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}trip/addspecialrequest", addSpecialRequestMap);
    return TripAddSpecialRequestModel.fromJson(response);
  }

  @override
  Future<FetchTripSpecialRequestModel> fetchTripSpecialRequest(
      String hashCode, String requestId, String tripId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}trip/getspecialrequest?hashcode=$hashCode&requestid=$requestId&tripid=$tripId");
    return FetchTripSpecialRequestModel.fromJson(response);
  }

  @override
  Future<UpdateTripSpecialRequestModel> updateTripSpecialRequest(
      Map updateSpecialRequestMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}trip/updatespecialrequest",
        updateSpecialRequestMap);
    return UpdateTripSpecialRequestModel.fromJson(response);
  }

  @override
  Future<DeleteTripSpecialRequestModel> deleteTripSpecialRequest(
      Map deleteSpecialRequestMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}trip/deletespecialrequest",
        deleteSpecialRequestMap);
    return DeleteTripSpecialRequestModel.fromJson(response);
  }
}
