abstract class LocationEvent {}

class FetchLocations extends LocationEvent {
  final int pageNo;

  FetchLocations({required this.pageNo});
}
