enum SafetyNoticeStatusEnum {
  none(status: 'None', value: '1'),
  created(status: 'Created', value: '2'),
  issued(status: 'Issued', value: '3'),
  hold(status: 'Hold', value: '4');

  const SafetyNoticeStatusEnum({required this.status, required this.value});

  final String status;
  final String value;
}
