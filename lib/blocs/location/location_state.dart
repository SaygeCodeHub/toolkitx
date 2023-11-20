import '../../data/models/location/fetch_location_details_model.dart';
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
