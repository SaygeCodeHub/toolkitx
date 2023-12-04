abstract class LocationEvent {}

class FetchLocations extends LocationEvent {
  final int pageNo;

  FetchLocations({required this.pageNo});
}

class FetchLocationDetails extends LocationEvent {
  final String locationId;
  final int selectedTabIndex;

  FetchLocationDetails(
      {required this.selectedTabIndex, required this.locationId});
}

class FetchLocationPermits extends LocationEvent {
  final int pageNo;

  FetchLocationPermits({required this.pageNo});
}

class FetchLocationLoTo extends LocationEvent {
  final int pageNo;

  FetchLocationLoTo({required this.pageNo});
}

class FetchLocationWorkOrders extends LocationEvent {
  final int pageNo;

  FetchLocationWorkOrders({required this.pageNo});
}
