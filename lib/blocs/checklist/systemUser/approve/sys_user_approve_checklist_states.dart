import 'package:equatable/equatable.dart';

import '../../../../data/models/checklist/systemUser/sys_user_approve_model.dart';

abstract class CheckListApproveStates extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ApproveCheckListInitial extends CheckListApproveStates {}

class ApprovingCheckList extends CheckListApproveStates {}

class CheckListApproved extends CheckListApproveStates {
  final ChecklistApproveModel checklistApproveModel;

  CheckListApproved({required this.checklistApproveModel});

  @override
  List<Object?> get props => [checklistApproveModel];
}

class CheckListNotApproved extends CheckListApproveStates {
  final String errorMessage;

  CheckListNotApproved({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
