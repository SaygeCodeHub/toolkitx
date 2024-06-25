abstract class TimeZoneEvents {}

class FetchTimeZone extends TimeZoneEvents {}

class SelectTimeZone extends TimeZoneEvents {
  final String timeZoneCode;
  final String timeZoneName;
  final String timeZoneOffset;
  final bool isFromProfile;

  SelectTimeZone(
      {required this.timeZoneCode,
      required this.timeZoneName,
      required this.timeZoneOffset,
      this.isFromProfile = false});
}
