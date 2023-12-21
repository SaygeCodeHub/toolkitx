enum LotoStatusEnum {
  none(status: 'None', value: '0'),
  created(status: 'Created', value: '1'),
  assigned(status: 'Assigned', value: '3'),
  accepted(status: 'Accepted', value: '4'),
  rejected(status: 'Rejected', value: '41'),
  started(status: 'Started', value: '5'),
  completed(status: 'Completed', value: '7');

  const LotoStatusEnum({required this.status, required this.value});

  final String status;
  final String value;
}
