part of 'sign_in_assign_to_me_bloc.dart';

abstract class SignInAssignToMeEvent {}

class AssignToMeWorkOrder extends SignInAssignToMeEvent {
  final Map assignToMeWorkOrdersMap;

  AssignToMeWorkOrder({required this.assignToMeWorkOrdersMap});
}

class AssignToMePermit extends SignInAssignToMeEvent {
  final Map assignToMePermitsMap;

  AssignToMePermit({required this.assignToMePermitsMap});
}

class AssignToMeLOTO extends SignInAssignToMeEvent {
  final Map assignToMeLOTOsMap;

  AssignToMeLOTO({required this.assignToMeLOTOsMap});
}

class AssignToMeChecklist extends SignInAssignToMeEvent {
  final Map assignToMeChecklistsMap;

  AssignToMeChecklist({required this.assignToMeChecklistsMap});
}
