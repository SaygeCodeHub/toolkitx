abstract class SafetyNoticeEvent {}

class FetchSafetyNotices extends SafetyNoticeEvent {
  final int pageNo;
  final bool isFromHomeScreen;

  FetchSafetyNotices({required this.pageNo, required this.isFromHomeScreen});
}

class AddSafetyNotice extends SafetyNoticeEvent {
  final Map addSafetyNoticeMap;

  AddSafetyNotice({required this.addSafetyNoticeMap});
}

class SafetyNoticeSaveFiles extends SafetyNoticeEvent {
  final Map addSafetyNoticeMap;
  final String safetyNoticeId;

  SafetyNoticeSaveFiles(
      {required this.safetyNoticeId, required this.addSafetyNoticeMap});
}

class FetchSafetyNoticeDetails extends SafetyNoticeEvent {
  final String safetyNoticeId;
  final int tabIndex;

  FetchSafetyNoticeDetails(
      {required this.tabIndex, required this.safetyNoticeId});
}

class UpdateSafetyNotice extends SafetyNoticeEvent {
  final Map updateSafetyNoticeMap;

  UpdateSafetyNotice({required this.updateSafetyNoticeMap});
}
