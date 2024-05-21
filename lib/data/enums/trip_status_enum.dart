enum TripStatusEnum {
  none(status: 'none', value: ''),
  completed(status: 'Completed', value: '4'),
  approved(status: 'Approved', value: '2'),
  started(status: 'Started', value: '3');

  const TripStatusEnum({required this.status, required this.value});

  final String status;
  final String value;
}
