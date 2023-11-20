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
