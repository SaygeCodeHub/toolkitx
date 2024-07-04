import '../../../../data/models/checklist/workforce/workforce_fetch_reject_reason_model.dart';

abstract class WorkForceCheckListRejectReasonEvent {}

class CheckListFetchRejectReasons extends WorkForceCheckListRejectReasonEvent {}

class CheckListSelectRejectReasons extends WorkForceCheckListRejectReasonEvent {
  final GetCheckListRejectReasonsModel getCheckListRejectReasonsModel;
  final String reason;

  CheckListSelectRejectReasons(
      {required this.getCheckListRejectReasonsModel, required this.reason});
}

class CheckListSaveRejectReasons extends WorkForceCheckListRejectReasonEvent {
  final String reason;
  final Map allCheckListDataMap;

  CheckListSaveRejectReasons(
      {required this.allCheckListDataMap, required this.reason});
}

class FetchChecklistWorkforceDocuments
    extends WorkForceCheckListRejectReasonEvent {
  final String checklistId;

  FetchChecklistWorkforceDocuments({required this.checklistId});
}
