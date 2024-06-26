import '../../data/safetyNotice/add_safety_notice_model.dart';
import '../../data/safetyNotice/cancel_safety_notice_model.dart';
import '../../data/safetyNotice/close_safety_notice_model.dart';
import '../../data/safetyNotice/fetch_safety_notice_details_model.dart';
import '../../data/safetyNotice/fetch_safety_notices_model.dart';
import '../../data/safetyNotice/hold_safety_notice_model.dart';
import '../../data/safetyNotice/issue_safety_notice_model.dart';
import '../../data/safetyNotice/reissue_safety_notice_model.dart';
import '../../data/safetyNotice/save_safety_notice_files_model.dart';
import '../../data/safetyNotice/update_safety_notice_model.dart';

abstract class SafetyNoticeStates {}

class SafetyNoticeInitialState extends SafetyNoticeStates {}

class FetchingSafetyNotices extends SafetyNoticeStates {}

class SafetyNoticesFetched extends SafetyNoticeStates {
  final List<Notice> noticesDatum;
  final Map safetyNoticeFilterMap;
  final String canAdd;

  SafetyNoticesFetched(
      {required this.safetyNoticeFilterMap,
      required this.noticesDatum,
      this.canAdd = '0'});
}

class SafetyNoticesNotFetched extends SafetyNoticeStates {
  final String errorMessage;

  SafetyNoticesNotFetched({required this.errorMessage});
}

class SafetyNoticeStatusSelected extends SafetyNoticeStates {
  final String statusId;
  final String status;

  SafetyNoticeStatusSelected({required this.status, required this.statusId});
}

class AddingSafetyNotice extends SafetyNoticeStates {}

class SafetyNoticeAdded extends SafetyNoticeStates {
  final AddSafetyNoticeModel addSafetyNoticeModel;

  SafetyNoticeAdded({required this.addSafetyNoticeModel});
}

class SafetyNoticeNotAdded extends SafetyNoticeStates {
  final String errorMessage;

  SafetyNoticeNotAdded({required this.errorMessage});
}

class SavingSafetyNoticeFiles extends SafetyNoticeStates {}

class SafetyNoticeFilesSaved extends SafetyNoticeStates {
  final SaveSafetyNoticeFilesModel saveSafetyNoticeFilesModel;

  SafetyNoticeFilesSaved({required this.saveSafetyNoticeFilesModel});
}

class SafetyNoticeFilesNotSaved extends SafetyNoticeStates {
  final String filesNotSaved;

  SafetyNoticeFilesNotSaved({required this.filesNotSaved});
}

class FetchingSafetyNoticeDetails extends SafetyNoticeStates {}

class SafetyNoticeDetailsFetched extends SafetyNoticeStates {
  final FetchSafetyNoticeDetailsModel fetchSafetyNoticeDetailsModel;
  final String clientId;
  final List popUpMenuOptionsList;
  final Map safetyNoticeDetailsMap;

  SafetyNoticeDetailsFetched(
      {required this.safetyNoticeDetailsMap,
      required this.popUpMenuOptionsList,
      required this.clientId,
      required this.fetchSafetyNoticeDetailsModel});
}

class SafetyNoticeDetailsNotFetched extends SafetyNoticeStates {
  final String detailsNotFetched;

  SafetyNoticeDetailsNotFetched({required this.detailsNotFetched});
}

class IssuingSafetyNotice extends SafetyNoticeStates {}

class SafetyNoticeIssued extends SafetyNoticeStates {
  final IssueSafetyNoticeModel issueSafetyNoticeModel;

  SafetyNoticeIssued({required this.issueSafetyNoticeModel});
}

class SafetyNoticeFailedToIssue extends SafetyNoticeStates {
  final String noticeNotIssued;

  SafetyNoticeFailedToIssue({required this.noticeNotIssued});
}

class UpdatingSafetyNotice extends SafetyNoticeStates {}

class SafetyNoticeUpdated extends SafetyNoticeStates {
  final UpdatingSafetyNoticeModel updatingSafetyNoticeModel;

  SafetyNoticeUpdated({required this.updatingSafetyNoticeModel});
}

class SafetyNoticeCouldNotUpdate extends SafetyNoticeStates {
  final String noticeNotUpdated;

  SafetyNoticeCouldNotUpdate({required this.noticeNotUpdated});
}

class PuttingSafetyNoticeOnHold extends SafetyNoticeStates {}

class SafetyNoticeOnHold extends SafetyNoticeStates {
  final HoldSafetyNoticeModel holdSafetyNoticeModel;

  SafetyNoticeOnHold({required this.holdSafetyNoticeModel});
}

class SafetyNoticeNotOnHold extends SafetyNoticeStates {
  final String noticeNotOnHold;

  SafetyNoticeNotOnHold({required this.noticeNotOnHold});
}

class CancellingSafetyNotice extends SafetyNoticeStates {}

class SafetyNoticeCancelled extends SafetyNoticeStates {
  final CancelSafetyNoticeModel cancelSafetyNoticeModel;

  SafetyNoticeCancelled({required this.cancelSafetyNoticeModel});
}

class SafetyNoticeNotCancelled extends SafetyNoticeStates {
  final String noticeNotCancelled;

  SafetyNoticeNotCancelled({required this.noticeNotCancelled});
}

class ClosingSafetyNotice extends SafetyNoticeStates {}

class SafetyNoticeClosed extends SafetyNoticeStates {
  final CloseSafetyNoticeModel closeSafetyNoticeModel;

  SafetyNoticeClosed({required this.closeSafetyNoticeModel});
}

class SafetyNoticeNotClosed extends SafetyNoticeStates {
  final String noticeNotClosed;

  SafetyNoticeNotClosed({required this.noticeNotClosed});
}

class FetchingSafetyNoticeHistoryList extends SafetyNoticeStates {}

class SafetyNoticeHistoryListFetched extends SafetyNoticeStates {
  final List historyDatum;

  SafetyNoticeHistoryListFetched({required this.historyDatum});
}

class SafetyNoticeHistoryListNotFetched extends SafetyNoticeStates {
  final String historyNotFetched;

  SafetyNoticeHistoryListNotFetched({required this.historyNotFetched});
}

class ReIssuingSafetyNotice extends SafetyNoticeStates {}

class SafetyNoticeReIssued extends SafetyNoticeStates {
  final ReIssueSafetyNoticeModel reIssueSafetyNoticeModel;

  SafetyNoticeReIssued({required this.reIssueSafetyNoticeModel});
}

class SafetyNoticeFailedToReIssue extends SafetyNoticeStates {
  final String noticeNotReIssued;

  SafetyNoticeFailedToReIssue({required this.noticeNotReIssued});
}
