enum SafetyNoticeStatusEnum {
  none(status: 'None', value: ''),
  created(status: 'Created', value: '0'),
  issued(status: 'Issued', value: '1'),
  hold(status: 'Hold', value: '2');

  const SafetyNoticeStatusEnum({required this.status, required this.value});

  final String status;
  final String value;
}
