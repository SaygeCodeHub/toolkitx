enum ExpenseStatusEnum {
  none(status: 'Created', value: '0'),
  created(status: 'Submit for Approval', value: '1'),
  openedForInformation(status: 'Approval', value: '2'),
  openedForReview(status: 'Rejected', value: '21');

  const ExpenseStatusEnum({required this.status, required this.value});

  final String status;
  final String value;
}
