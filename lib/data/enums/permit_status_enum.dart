enum PermitStatusEnum {
  approved(status: 'Approved', value: '5'),
  open(status: 'Open', value: '2'),
  onHold(status: 'OnHold', value: '7');

  const PermitStatusEnum({required this.status, required this.value});

  final String status;
  final String value;
}
