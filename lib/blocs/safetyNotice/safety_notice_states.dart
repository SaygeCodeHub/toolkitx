import '../../data/safetyNotice/fetch_safety_notices_model.dart';

abstract class SafetyNoticeStates {}

class SafetyNoticeInitialState extends SafetyNoticeStates {}

class FetchingSafetyNotices extends SafetyNoticeStates {}

class SafetyNoticesFetched extends SafetyNoticeStates {
  final List<Notice> noticesDatum;

  SafetyNoticesFetched({required this.noticesDatum});
}
