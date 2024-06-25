import 'package:equatable/equatable.dart';

import '../../../../data/models/checklist/systemUser/sys_user_edit_header_details_model.dart';
import '../../../../data/models/checklist/systemUser/sys_user_submit_header_model.dart';

abstract class CheckListHeaderStates extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CheckListHeaderInitial extends CheckListHeaderStates {}

class FetchingCheckListEditHeader extends CheckListHeaderStates {
  final String scheduleId;

  FetchingCheckListEditHeader({required this.scheduleId});

  @override
  List<Object?> get props => [scheduleId];
}

class CheckListEditHeaderFetched extends CheckListHeaderStates {
  final CheckListEditHeaderDetailsModel getCheckListEditHeaderModel;

  CheckListEditHeaderFetched({required this.getCheckListEditHeaderModel});

  @override
  List<Object?> get props => [getCheckListEditHeaderModel];
}

class CheckListEditHeaderError extends CheckListHeaderStates {
  final String noHeaderMessage;

  CheckListEditHeaderError({required this.noHeaderMessage});
}

class SubmittingCheckListHeader extends CheckListHeaderStates {}

class CheckListHeaderSubmitted extends CheckListHeaderStates {
  final ChecklistSubmitHeaderModel checklistSubmitHeaderModel;
  final String headerMessage;

  CheckListHeaderSubmitted(
      {required this.headerMessage, required this.checklistSubmitHeaderModel});

  @override
  List<Object?> get props => [checklistSubmitHeaderModel];
}

class CheckListHeaderNotSubmitted extends CheckListHeaderStates {
  final String message;

  CheckListHeaderNotSubmitted({required this.message});

  @override
  List<Object?> get props => [message];
}
