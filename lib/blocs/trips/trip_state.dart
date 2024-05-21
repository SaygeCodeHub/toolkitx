part of 'trip_bloc.dart';

abstract class TripState {}

class TripInitial extends TripState {}

class TripsListFetching extends TripState {}

class TripsListFetched extends TripState {
  final FetchTripsListModel fetchTripsListModel;
  final List<TripDatum> tripDatum;
  final Map filterMap;

  TripsListFetched(
      {required this.fetchTripsListModel,
      required this.tripDatum,
      required this.filterMap});
}

class TripsListNotFetched extends TripState {
  final String errorMessage;

  TripsListNotFetched({required this.errorMessage});
}

class TripsStatusFilterSelected extends TripState {
  final String selectedIndex;
  final bool selected;

  TripsStatusFilterSelected(
      {required this.selected, required this.selectedIndex});
}

class TripMasterFetching extends TripState {}

class TripMasterFetched extends TripState {
  final FetchTripMasterModel fetchTripMasterModel;

  TripMasterFetched({required this.fetchTripMasterModel});
}

class TripMasterNotFetched extends TripState {
  final String errorMessage;

  TripMasterNotFetched({required this.errorMessage});
}

class TripsVesselFilterSelected extends TripState {
  final String selectVessel;

  TripsVesselFilterSelected({required this.selectVessel});
}
