part of 'sign_in_assign_to_me_bloc.dart';

abstract class SignInAssignToMeState {}

class SignInAssignToMeInitial extends SignInAssignToMeState {}

class WorkOrderAssigning extends SignInAssignToMeState {}

class WorkOrderAssigned extends SignInAssignToMeState {
  final AssignToMeWorkOrderModel assignToMeWorkOrderModel;

  WorkOrderAssigned({required this.assignToMeWorkOrderModel});
}

class WorkOrderAssignError extends SignInAssignToMeState {
  final String workOrderError;

  WorkOrderAssignError({required this.workOrderError});
}

class PermitAssigning extends SignInAssignToMeState {}

class PermitAssigned extends SignInAssignToMeState {
  final AssignToMePermitModel assignToMePermitModel;

  PermitAssigned({required this.assignToMePermitModel});
}

class PermitAssignError extends SignInAssignToMeState {
  final String permitError;

  PermitAssignError({required this.permitError});
}

class LOTOAssigning extends SignInAssignToMeState {}

class LOTOAssigned extends SignInAssignToMeState {
  final AssignToMeLotoModel assignToMeLotoModel;

  LOTOAssigned({required this.assignToMeLotoModel});
}

class LOTOAssignError extends SignInAssignToMeState {
  final String permitError;

  LOTOAssignError({required this.permitError});
}

class ChecklistAssigning extends SignInAssignToMeState {}

class ChecklistAssigned extends SignInAssignToMeState {
  final AssignToMeChecklistModel assignToMeChecklistModel;

  ChecklistAssigned({required this.assignToMeChecklistModel});
}

class ChecklistAssignError extends SignInAssignToMeState {
  final String checklistError;

  ChecklistAssignError({required this.checklistError});
}
