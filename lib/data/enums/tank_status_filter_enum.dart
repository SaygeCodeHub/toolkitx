enum TankStatusFilterEnum {
  none(status: 'none', value: ''),
  created(status: 'Created', value: '1'),
  approved(status: 'Approved', value: '8'),
  inExecution(status: 'In Execution', value: '2'),
  rejected(status: 'Rejected', value: '9');

  const TankStatusFilterEnum({required this.status, required this.value});

  final String status;
  final String value;
}
