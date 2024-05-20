part of 'trip_bloc.dart';

abstract class TripState {}

class TripInitial extends TripState {}

class TripsListFetching extends TripState {}

class TripsListFetched extends TripState {
  final FetchTripsListModel fetchTripsListModel;

  TripsListFetched({required this.fetchTripsListModel});
}

class TripsListNotFetched extends TripState {
  final String errorMessage;

  TripsListNotFetched({required this.errorMessage});
}

class TripDetailsFetching extends TripState {}

class TripDetailsFetched extends TripState {
  final FetchTripDetailsModel fetchTripDetailsModel;

  TripDetailsFetched({required this.fetchTripDetailsModel});
}

class TripDetailsNotFetched extends TripState {
  final String errorMessage;

  TripDetailsNotFetched({required this.errorMessage});
}
