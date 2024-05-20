part of 'trip_bloc.dart';

abstract class TripEvent {}

class FetchTripsList extends TripEvent {
  final int pageNo;

  FetchTripsList({required this.pageNo});
}

class FetchTripsDetails extends TripEvent {
  final String tripId;
  final int tripTabIndex;

  FetchTripsDetails({required this.tripId, required this.tripTabIndex});
}
