import 'package:equatable/equatable.dart';

import '../../../data/models/incident/incident_unlink_permit_model.dart';

abstract class IncidentRemoveLinkedPermitStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class IncidentRemoveLinkedPermitInitial
    extends IncidentRemoveLinkedPermitStates {}

class IncidentRemoveLinkedPermitLoading
    extends IncidentRemoveLinkedPermitStates {}

class IncidentLinkedPermitRemoved extends IncidentRemoveLinkedPermitStates {
  final IncidentUnlinkPermitModel incidentUnlinkPermitModel;

  IncidentLinkedPermitRemoved({required this.incidentUnlinkPermitModel});

  @override
  List<Object?> get props => [incidentUnlinkPermitModel];
}

class IncidentLinkedPermitNotRemoved extends IncidentRemoveLinkedPermitStates {
  final String unableToUnlinkPermit;

  IncidentLinkedPermitNotRemoved({required this.unableToUnlinkPermit});
}

class IncidentUnlinkedPermit extends IncidentRemoveLinkedPermitStates {
  final List permitLinkedList;
  final int index;

  IncidentUnlinkedPermit({required this.permitLinkedList, required this.index});

  @override
  List<Object?> get props => [permitLinkedList, index];
}
