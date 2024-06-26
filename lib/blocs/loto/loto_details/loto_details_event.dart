part of 'loto_details_bloc.dart';

abstract class LotoDetailsEvent {}

class FetchLotoDetails extends LotoDetailsEvent {
  final int lotoTabIndex;
  final String lotoId;

  FetchLotoDetails({required this.lotoTabIndex, required this.lotoId});
}

class FetchLotoAssignWorkforce extends LotoDetailsEvent {
  final int pageNo;
  final String isRemoveOperation;
  final String workforceName;

  FetchLotoAssignWorkforce(
      {required this.pageNo,
      required this.isRemoveOperation,
      required this.workforceName});
}

class SaveLotoAssignWorkForce extends LotoDetailsEvent {
  final int peopleId;

  SaveLotoAssignWorkForce({required this.peopleId});
}

class SaveLotoAssignTeam extends LotoDetailsEvent {
  final String teamId;

  SaveLotoAssignTeam({required this.teamId});
}

class FetchLotoAssignTeam extends LotoDetailsEvent {
  final int pageNo;
  final String isRemove;
  final String name;

  FetchLotoAssignTeam(
      {required this.pageNo, required this.isRemove, required this.name});
}

class SearchLotoAssignWorkForce extends LotoDetailsEvent {
  final bool isWorkforceSearched;
  final String isRemoveOperation;

  SearchLotoAssignWorkForce(
      {required this.isWorkforceSearched, required this.isRemoveOperation});
}

class StartLotoEvent extends LotoDetailsEvent {}

class StartRemoveLotoEvent extends LotoDetailsEvent {
  StartRemoveLotoEvent();
}

class RejectLotoEvent extends LotoDetailsEvent {
  final String remark;

  RejectLotoEvent({required this.remark});
}

class ApplyLotoEvent extends LotoDetailsEvent {
  ApplyLotoEvent();
}

class AcceptLotoEvent extends LotoDetailsEvent {
  AcceptLotoEvent();
}

class RemoveLotoEvent extends LotoDetailsEvent {
  RemoveLotoEvent();
}

class RemoveAssignWorkforce extends LotoDetailsEvent {
  final int peopleId;

  RemoveAssignWorkforce({required this.peopleId});
}

class LotoUploadPhotos extends LotoDetailsEvent {
  final String filename;

  LotoUploadPhotos({required this.filename});
}

class AddLotoComment extends LotoDetailsEvent {
  final String comment;

  AddLotoComment({required this.comment});
}

class FetchLotoChecklistQuestions extends LotoDetailsEvent {
  final String checkListId;
  final String isRemoveOperation;

  FetchLotoChecklistQuestions(
      {this.checkListId = "", required this.isRemoveOperation});
}

class SelectAnswer extends LotoDetailsEvent {
  final int id;
  final String text;

  SelectAnswer({required this.id, required this.text});
}

class SelectOption extends LotoDetailsEvent {
  final int id;
  final String text;

  SelectOption({required this.id, required this.text});
}

class SaveLotoChecklist extends LotoDetailsEvent {}

class FetchLotoAssignedChecklists extends LotoDetailsEvent {
  final String isRemove;

  FetchLotoAssignedChecklists({required this.isRemove});
}

class DeleteLotoWorkforce extends LotoDetailsEvent {
  final Map deleteWorkforceMap;

  DeleteLotoWorkforce({required this.deleteWorkforceMap});
}

class RemoveAssignTeam extends LotoDetailsEvent {
  final String teamId;

  RemoveAssignTeam({required this.teamId});
}

class SelectLotoChecklistMultiAnswer extends LotoDetailsEvent {
  final bool isChecked;

  SelectLotoChecklistMultiAnswer({required this.isChecked});
}
