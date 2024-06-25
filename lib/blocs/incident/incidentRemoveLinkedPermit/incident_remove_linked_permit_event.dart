class IncidentRemoveLinkedPermitEvent {
  final String permitId;
  final List permitLinkedList;
  final int index;

  IncidentRemoveLinkedPermitEvent(
      {required this.index,
      required this.permitLinkedList,
      required this.permitId});
}
