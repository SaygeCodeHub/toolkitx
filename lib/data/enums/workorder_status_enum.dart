enum WorkOrderStatus {
  none(type: 'None', value: '0'),
  newValue(type: 'New', value: '1'),
  assigned(type: 'Assigned', value: '2'),
  accepted(type: 'Accepted', value: '3'),
  rejected(type: 'Rejected', value: '4'),
  started(type: 'Started', value: '5'),
  onHold(type: 'On hold', value: '6'),
  completed(type: 'Completed', value: '7'),
  closed(type: 'Closed', value: '8');

  const WorkOrderStatus({required this.type, required this.value});

  final String type;
  final String value;
}
