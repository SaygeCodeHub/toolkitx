import '../../data/models/location/fetch_location_details_model.dart';
import '../../data/models/location/fetch_location_logbooks_model.dart';
import '../../data/models/location/fetch_location_loto_model.dart';
import '../../data/models/location/fetch_location_permits_model.dart';
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

  LocationLoToFetched(
      {required this.locationLoToListReachedMax, required this.locationLoTos});
}

class LocationLoToNotFetched extends LocationState {
  final String loToNotFetched;

  LocationLoToNotFetched({required this.loToNotFetched});
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
