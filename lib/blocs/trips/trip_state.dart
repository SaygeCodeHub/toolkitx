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

class TripDetailsFetching extends TripState {}

class TripDetailsFetched extends TripState {
  final FetchTripDetailsModel fetchTripDetailsModel;
  final String clientId;
  final bool showPopUpMenu;
  final List tripPopUpMenuList;

  TripDetailsFetched(
      {required this.fetchTripDetailsModel,
      required this.showPopUpMenu,
      required this.tripPopUpMenuList,
      required this.clientId});
}

class TripDetailsNotFetched extends TripState {
  final String errorMessage;

  TripDetailsNotFetched({required this.errorMessage});
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

class PassengerCrewListFetching extends TripState {}

class PassengerCrewListFetched extends TripState {
  final FetchTripPassengersCrewListModel fetchTripPassengersCrewListModel;

  PassengerCrewListFetched({required this.fetchTripPassengersCrewListModel});
}

class PassengerCrewListNotFetched extends TripState {
  final String errorMessage;

  PassengerCrewListNotFetched({required this.errorMessage});
}

class TripSpecialRequestAdding extends TripState {}

class TripSpecialRequestAdded extends TripState {}

class TripSpecialRequestNotAdded extends TripState {
  final String errorMessage;

  TripSpecialRequestNotAdded({required this.errorMessage});
}

class TripSpecialRequestFetching extends TripState {}

class TripSpecialRequestFetched extends TripState {
  final FetchTripSpecialRequestModel fetchTripSpecialRequestModel;
  final List<PassengerCrewDatum> passengerCrewDatum;
  final List<MasterDatum> masterDatum;

  TripSpecialRequestFetched(
      {required this.fetchTripSpecialRequestModel,
      required this.passengerCrewDatum,
      required this.masterDatum});
}

class TripSpecialRequestNotFetched extends TripState {
  final String errorMessage;

  TripSpecialRequestNotFetched({required this.errorMessage});
}

class TripSpecialRequestUpdating extends TripState {}

class TripSpecialRequestUpdated extends TripState {}

class TripSpecialRequestNotUpdated extends TripState {
  final String errorMessage;

  TripSpecialRequestNotUpdated({required this.errorMessage});
}
