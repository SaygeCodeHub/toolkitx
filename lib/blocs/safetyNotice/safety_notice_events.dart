abstract class SafetyNoticeEvent {}

class FetchSafetyNotices extends SafetyNoticeEvent {
  final int pageNo;
  final bool isFromHomeScreen;

  FetchSafetyNotices({required this.pageNo, required this.isFromHomeScreen});
}

class SelectSafetyNoticeStatus extends SafetyNoticeEvent {
  final String statusId;
  final String status;

  SelectSafetyNoticeStatus({required this.status, required this.statusId});
}

class SafetyNoticeApplyFilter extends SafetyNoticeEvent {
  final Map safetyNoticeFilterMap;

  SafetyNoticeApplyFilter({required this.safetyNoticeFilterMap});
}
