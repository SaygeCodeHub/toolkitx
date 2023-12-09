import '../../data/models/location/fetch_location_checklists_model.dart';
import '../../data/models/location/fetch_location_assets_model.dart';
import '../../data/models/location/fetch_location_details_model.dart';
import '../../data/models/location/fetch_location_logbooks_model.dart';
import '../../data/models/location/fetch_location_loto_model.dart';
import '../../data/models/location/fetch_location_permits_model.dart';
import '../../data/models/location/fetch_location_workorders_model.dart';
import '../../data/models/location/fetch_locations_model.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {}

class FetchingLocations extends LocationState {}

class LocationsFetched extends LocationState {
  final List<LocationDatum> locationDatum;
  final bool locationListReachedMax;

  LocationsFetched(
      {required this.locationListReachedMax, required this.locationDatum});
}

class LocationsCouldNotFetch extends LocationState {
  final String locationsNotFetched;

  LocationsCouldNotFetch({required this.locationsNotFetched});
}

class FetchingLocationDetails extends LocationState {}

class LocationDetailsFetched extends LocationState {
  final FetchLocationDetailsModel fetchLocationDetailsModel;
  final int selectedTabIndex;
  final String clientId;

  LocationDetailsFetched(
      {required this.clientId,
      required this.selectedTabIndex,
      required this.fetchLocationDetailsModel});
}

class LocationDetailsNotFetched extends LocationState {
  final String detailsNotFetched;

  LocationDetailsNotFetched({required this.detailsNotFetched});
}

class FetchingLocationPermits extends LocationState {}

class LocationPermitsFetched extends LocationState {
  final List<LocationPermitsDatum> locationPermits;
  final bool locationPermitListReachedMax;

  LocationPermitsFetched(
      {required this.locationPermitListReachedMax,
      required this.locationPermits});
}

class LocationPermitsNotFetched extends LocationState {
  final String permitsNotFetched;

  LocationPermitsNotFetched({required this.permitsNotFetched});
}

class FetchingLocationLoTo extends LocationState {}

class LocationLoToFetched extends LocationState {
  final List<LocationLotoDatum> locationLoTos;
  final bool locationLoToListReachedMax;
  final Map loToFilterMap;

  LocationLoToFetched(
      {required this.loToFilterMap,
      required this.locationLoToListReachedMax,
      required this.locationLoTos});
}

class LocationLoToNotFetched extends LocationState {
  final String loToNotFetched;

  LocationLoToNotFetched({required this.loToNotFetched});
}

class FetchingLocationWorkOrders extends LocationState {}

class LocationWorkOrdersFetched extends LocationState {
  final List<LocationWorkOrdersDatum> workOrderLocations;
  final bool workOrderLoToListReachedMax;

  LocationWorkOrdersFetched(
      {required this.workOrderLoToListReachedMax,
      required this.workOrderLocations});
}

class LocationWorkOrdersNotFetched extends LocationState {
  final String workOrderNotFetched;

  LocationWorkOrdersNotFetched({required this.workOrderNotFetched});
}

class FetchingLocationCheckLists extends LocationState {}

class LocationCheckListsFetched extends LocationState {
  final FetchLocationCheckListsModel fetchLocationCheckListsModel;

  LocationCheckListsFetched({required this.fetchLocationCheckListsModel});
}

class LocationCheckListsNotFetched extends LocationState {
  final String checkListsNotFetched;

  LocationCheckListsNotFetched({required this.checkListsNotFetched});
}

class FetchingLocationAssets extends LocationState {}

class LocationAssetsFetched extends LocationState {
  final List<LocationAssetsDatum> locationAssets;
  final bool locationAssetsListReachedMax;

  LocationAssetsFetched(
      {required this.locationAssetsListReachedMax,
      required this.locationAssets});
}

class LocationAssetsNotFetched extends LocationState {
  final String assetsNotFetched;

  LocationAssetsNotFetched({required this.assetsNotFetched});
}

class FetchingLocationLogBooks extends LocationState {}

class LocationLogBooksFetched extends LocationState {
  final List<LocationLogBooksDatum> locationLogBooks;
  final bool locationLogBooksListReachedMax;

  LocationLogBooksFetched(
      {required this.locationLogBooksListReachedMax,
      required this.locationLogBooks});
}

class LocationLogBooksNotFetched extends LocationState {
  final String logBooksNotFetched;

  LocationLogBooksNotFetched({required this.logBooksNotFetched});
}
