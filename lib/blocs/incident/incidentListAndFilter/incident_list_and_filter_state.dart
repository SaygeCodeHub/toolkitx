import 'package:equatable/equatable.dart';

import '../../../data/models/incident/fetch_incidents_list_model.dart';
import '../../../data/models/incident/incident_fetch_roles_model.dart';

abstract class IncidentListAndFilterStates extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchIncidentsInitial extends IncidentListAndFilterStates {}

class FetchingIncidents extends IncidentListAndFilterStates {}

class IncidentsFetched extends IncidentListAndFilterStates {
  final FetchIncidentsListModel fetchIncidentsListModel;
  final Map filterMap;

  IncidentsFetched(
      {required this.filterMap, required this.fetchIncidentsListModel});
}

class IncidentsNotFetched extends IncidentListAndFilterStates {
  final String noIncidentsMessage;

  IncidentsNotFetched({required this.noIncidentsMessage});
}

class FetchingIncidentRoles extends IncidentListAndFilterStates {
  FetchingIncidentRoles();
}

class IncidentRolesFetched extends IncidentListAndFilterStates {
  final IncidentFetchRolesModel incidentFetchRolesModel;
  final String roleId;

  IncidentRolesFetched(
      {required this.roleId, required this.incidentFetchRolesModel});

  @override
  List<Object?> get props => [incidentFetchRolesModel, roleId];
}

class IncidentRolesNotFetched extends IncidentListAndFilterStates {
  IncidentRolesNotFetched();
}

class IncidentRoleChanged extends IncidentListAndFilterStates {
  final String roleId;

  IncidentRoleChanged({required this.roleId});

  @override
  List<Object?> get props => [roleId];
}
