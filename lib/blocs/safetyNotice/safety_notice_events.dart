abstract class SafetyNoticeEvent {}

class FetchSafetyNotices extends SafetyNoticeEvent {
  final int pageNo;
  final bool isFromHomeScreen;

  FetchSafetyNotices({required this.pageNo, required this.isFromHomeScreen});
}
