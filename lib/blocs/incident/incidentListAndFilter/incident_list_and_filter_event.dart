abstract class IncidentListAndFilterEvent {
  const IncidentListAndFilterEvent();
}

class FetchIncidentListEvent extends IncidentListAndFilterEvent {
  final bool isFromHome;
  final int page;

  const FetchIncidentListEvent({required this.page, required this.isFromHome});
}

class ApplyIncidentFilter extends IncidentListAndFilterEvent {
  final Map incidentFilterMap;

  const ApplyIncidentFilter({required this.incidentFilterMap});
}

class ClearIncidentFilters extends IncidentListAndFilterEvent {
  const ClearIncidentFilters();
}

class IncidentFetchRoles extends IncidentListAndFilterEvent {
  const IncidentFetchRoles();
}

class IncidentChangeRole extends IncidentListAndFilterEvent {
  final String roleId;

  const IncidentChangeRole({required this.roleId});
}
