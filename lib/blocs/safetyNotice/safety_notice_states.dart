import '../../data/safetyNotice/fetch_safety_notices_model.dart';

abstract class SafetyNoticeStates {}

class SafetyNoticeInitialState extends SafetyNoticeStates {}

class FetchingSafetyNotices extends SafetyNoticeStates {}

class SafetyNoticesFetched extends SafetyNoticeStates {
  final List<Notice> noticesDatum;
  final Map safetyNoticeFilterMap;

  SafetyNoticesFetched(
      {required this.safetyNoticeFilterMap, required this.noticesDatum});
}

class SafetyNoticeStatusSelected extends SafetyNoticeStates {
  final String statusId;
  final String status;

  SafetyNoticeStatusSelected({required this.status, required this.statusId});
}
