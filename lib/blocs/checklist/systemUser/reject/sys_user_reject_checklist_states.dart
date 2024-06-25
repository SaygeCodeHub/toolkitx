import 'package:equatable/equatable.dart';
import 'package:toolkit/data/models/checklist/systemUser/sys_user_reject_model.dart';

abstract class RejectCheckListStates extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class RejectCheckListInitial extends RejectCheckListStates {}

class RejectingCheckList extends RejectCheckListStates {}

class CheckListRejected extends RejectCheckListStates {
  final ChecklistRejectModel checklistRejectModel;

  CheckListRejected({required this.checklistRejectModel});

  @override
  List<Object?> get props => [checklistRejectModel];
}

class CheckListNotRejected extends RejectCheckListStates {
  final String errorMessage;

  CheckListNotRejected({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
