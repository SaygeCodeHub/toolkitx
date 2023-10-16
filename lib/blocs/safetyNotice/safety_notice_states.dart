import '../../data/safetyNotice/add_safety_notice_model.dart';
import '../../data/safetyNotice/fetch_safety_notice_details_model.dart';
import '../../data/safetyNotice/fetch_safety_notices_model.dart';
import '../../data/safetyNotice/save_safety_notice_files_model.dart';
import '../../data/safetyNotice/update_safety_notice_model.dart';

abstract class SafetyNoticeStates {}

class SafetyNoticeInitialState extends SafetyNoticeStates {}

class FetchingSafetyNotices extends SafetyNoticeStates {}

class SafetyNoticesFetched extends SafetyNoticeStates {
  final List<Notice> noticesDatum;

  SafetyNoticesFetched({required this.noticesDatum});
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

class UpdatingSafetyNotice extends SafetyNoticeStates {}

class SafetyNoticeUpdated extends SafetyNoticeStates {
  final UpdatingSafetyNoticeModel updatingSafetyNoticeModel;

  SafetyNoticeUpdated({required this.updatingSafetyNoticeModel});
}

class SafetyNoticeCouldNotUpdate extends SafetyNoticeStates {
  final String noticeNotUpdated;

  SafetyNoticeCouldNotUpdate({required this.noticeNotUpdated});
}
