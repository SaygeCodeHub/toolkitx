enum LotoStatusEnum {
  none(status: 'None', value: '0'),
  created(status: 'Created', value: '1'),
  assigned(status: 'Assigned', value: '21'),
  accepted(status: 'Accepted', value: '22'),
  rejected(status: 'Rejected', value: '9'),
  started(status: 'Started', value: '8'),
  completed(status: 'Completed', value: '3');

  const LotoStatusEnum({required this.status, required this.value});

  final String status;
  final String value;
}
