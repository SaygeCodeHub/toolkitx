part of 'trip_bloc.dart';

abstract class TripEvent {}

class FetchTripsList extends TripEvent {
  final int pageNo;

  FetchTripsList({required this.pageNo});
}
