part of 'trip_bloc.dart';

abstract class TripEvent {}

class FetchTripsList extends TripEvent {
  final int pageNo;
  final bool isFromHome;

  FetchTripsList({required this.pageNo, required this.isFromHome});
}

class SelectTripStatusFilter extends TripEvent {
  final String selectedIndex;
  final bool selected;

  SelectTripStatusFilter({required this.selected, required this.selectedIndex});
}

class FetchTripsDetails extends TripEvent {
  final String tripId;
  final int tripTabIndex;

  FetchTripsDetails({required this.tripId, required this.tripTabIndex});
}

class FetchTripMaster extends TripEvent {}

class SelectTripVesselFilter extends TripEvent {
  final String selectVessel;

  SelectTripVesselFilter({required this.selectVessel});
}

class ApplyTripFilter extends TripEvent {
  final Map tripFilterMap;

  ApplyTripFilter({required this.tripFilterMap});
}

class ClearTripFilter extends TripEvent {}

class FetchPassengerCrewList extends TripEvent {
  final String tripId;

  FetchPassengerCrewList({required this.tripId});
}

class TripAddSpecialRequest extends TripEvent {
  final String tripId;
  final Map addSpecialRequestMap;

  TripAddSpecialRequest(
      {required this.tripId, required this.addSpecialRequestMap});
}

class FetchTripSpecialRequest extends TripEvent {
  final String tripId;
  final String requestId;

  FetchTripSpecialRequest({required this.tripId, required this.requestId});
}

class UpdateTripSpecialRequest extends TripEvent {
  final String requestId;
  final Map updateSpecialRequestMap;

  UpdateTripSpecialRequest(
      {required this.requestId, required this.updateSpecialRequestMap});
}
