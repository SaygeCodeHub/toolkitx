enum TodoStatusEnum {
  none(status: 'None', value: '0'),
  created(status: 'Created', value: '1'),
  openForInformation(status: 'Open For Information', value: '21'),
  openForReview(status: 'Open For Review', value: '22'),
  approved(status: 'Approved', value: '8'),
  rejected(status: 'Rejected', value: '9'),
  closed(status: 'Closed', value: '3');

  const TodoStatusEnum({required this.status, required this.value});

  final String status;
  final String value;
}
