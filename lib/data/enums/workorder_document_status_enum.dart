enum WorkOrderStatusEnum {
  none(status: 'None', value: ''),
  created(status: 'Created', value: '1'),
  openedForInformation(status: 'Opened for Information', value: '21'),
  openedForReview(status: 'Opened for Review', value: '22'),
  approved(status: 'Approved', value: '8'),
  rejected(status: 'Rejected', value: '9'),
  closed(status: 'Closed', value: '3');

  const WorkOrderStatusEnum({required this.status, required this.value});

  final String status;
  final String value;
}
