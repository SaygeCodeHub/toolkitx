import 'package:toolkit/data/models/timeZones/time_zone_model.dart';

abstract class TimeZoneStates {}

class TimeZoneInitial extends TimeZoneStates {}

class TimeZoneFetching extends TimeZoneStates {}

class TimeZoneFetched extends TimeZoneStates {
  final TimeZoneModel getTimeZoneModel;

  TimeZoneFetched({required this.getTimeZoneModel});
}

class FetchTimeZoneError extends TimeZoneStates {}
