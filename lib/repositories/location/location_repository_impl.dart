import 'package:toolkit/data/models/location/fetch_location_checklists_model.dart';
import 'package:toolkit/data/models/location/fetch_location_assets_model.dart';
import 'package:toolkit/data/models/location/fetch_location_details_model.dart';
import 'package:toolkit/data/models/location/fetch_location_logbooks_model.dart';
import 'package:toolkit/data/models/location/fetch_location_loto_model.dart';
import 'package:toolkit/data/models/location/fetch_location_permits_model.dart';
import 'package:toolkit/data/models/location/fetch_location_workorders_model.dart';

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

  @override
  Future<FetchLocationPermitsModel> fetchLocationPermits(
      int pageNo, String hashCode, String filter, String locationId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}common/getlocationpermits?pageno=$pageNo&hashcode=$hashCode&filter=$filter&locationid=$locationId");
    return FetchLocationPermitsModel.fromJson(response);
  }

  @override
  Future<FetchLocationLoToModel> fetchLocationLoTo(int pageNo, String hashCode,
      String userId, String filter, String locationId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}common/getlocationloto?pageno=$pageNo&hashcode=$hashCode&filter=$filter&userid=$userId&locationid=$locationId");
    return FetchLocationLoToModel.fromJson(response);
  }

  @override
  Future<FetchLocationWorkOrdersModel> fetchLocationWorkOrders(
      int pageNo, String hashCode, String filter, String locationId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}common/getlocationworkorders?pageno=$pageNo&hashcode=$hashCode&filter=$filter&locationid=$locationId");
    return FetchLocationWorkOrdersModel.fromJson(response);
  }

  @override
  Future<FetchLocationCheckListsModel> fetchLocationCheckLists(
      String hashCode, String filter, String locationId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}common/getlocationschecklists?locationid=$locationId&hashcode=$hashCode&filter=$filter");
    return FetchLocationCheckListsModel.fromJson(response);
  }

  @override
  Future<FetchLocationAssetsModel> fetchLocationAssets(
      int pageNo, String hashCode, String filter) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}asset/get?pageno=$pageNo&hashcode=$hashCode&filter=$filter");
    return FetchLocationAssetsModel.fromJson(response);
  }

  @override
  Future<FetchLocationLogBookModel> fetchLocationLogBooks(int pageNo,
      String hashCode, String userId, String filter, String locationId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}common/getlocationlogbooks?pageno=$pageNo&hashcode=$hashCode&filter=$filter&locationid=$locationId&userid=$userId");
    return FetchLocationLogBookModel.fromJson(response);
  }
}
