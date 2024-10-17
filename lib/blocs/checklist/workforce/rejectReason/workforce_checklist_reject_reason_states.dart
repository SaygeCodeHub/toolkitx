import 'package:equatable/equatable.dart';
import 'package:toolkit/data/models/checklist/workforce/fetch_checklist_workforce_documents_model.dart';

import '../../../../data/models/checklist/workforce/workforce_checklist_save_reject_reason_model.dart';
import '../../../../data/models/checklist/workforce/workforce_fetch_reject_reason_model.dart';

class WorkForceCheckListRejectReasonStates extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CheckListRejectReasonInitial
    extends WorkForceCheckListRejectReasonStates {}

class CheckListFetchingRejectReasons
    extends WorkForceCheckListRejectReasonStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CheckListRejectReasonsFetched
    extends WorkForceCheckListRejectReasonStates {
  final GetCheckListRejectReasonsModel getCheckListRejectReasonsModel;
  final String reason;

  CheckListRejectReasonsFetched(
      {required this.reason, required this.getCheckListRejectReasonsModel});

  @override
  List<Object?> get props => [reason, getCheckListRejectReasonsModel];
}

class CheckListRejectReasonsError extends WorkForceCheckListRejectReasonStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CheckListSelectReasonsError extends WorkForceCheckListRejectReasonStates {
  final String reason;

  CheckListSelectReasonsError({required this.reason});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class SavingCheckListRejectReasons
    extends WorkForceCheckListRejectReasonStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CheckListRejectReasonsSaved extends WorkForceCheckListRejectReasonStates {
  final PostRejectReasonsModel postRejectReasonsModel;

  CheckListRejectReasonsSaved({required this.postRejectReasonsModel});

  @override
  List<Object?> get props => [postRejectReasonsModel];
}

class CheckListRejectReasonsNotSaved
    extends WorkForceCheckListRejectReasonStates {
  final String message;

  CheckListRejectReasonsNotSaved({required this.message});

  @override
  List<Object?> get props => [message];
}

class ChecklistWorkforceDocumentsFetching
    extends WorkForceCheckListRejectReasonStates {}

class ChecklistWorkforceDocumentsFetched
    extends WorkForceCheckListRejectReasonStates {
  final FetchChecklistWorkforceDocumentsModel
      fetchChecklistWorkforceDocumentsModel;
  final String clientId;

  ChecklistWorkforceDocumentsFetched(
      {required this.fetchChecklistWorkforceDocumentsModel,
      required this.clientId});
}

class ChecklistWorkforceDocumentsNotFetched
    extends WorkForceCheckListRejectReasonStates {
  final String errorMessage;

  ChecklistWorkforceDocumentsNotFetched({required this.errorMessage});
}
