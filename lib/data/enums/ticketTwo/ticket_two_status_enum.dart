enum TicketTwoStatusEnum {
  newStatus(status: 'New', value: '1'),
  deferred(status: 'Deferred', value: '2'),
  approveForDevelopment(status: 'Approve For Development', value: '3'),
  testing(status: 'Testing', value: '4'),
  development(status: 'Development', value: '5'),
  approved(status: 'Approved', value: '6'),
  rolledOut(status: 'Rolled Out', value: '7'),
  closed(status: 'Closed', value: '8'),
  estimateDT(status: 'Estimate DT', value: '10'),
  waitingForDevelopment(status: 'Waiting For Development', value: '11'),
  backToApprove(status: 'Back to Approve', value: '6'),
  approveRolledOut(status: 'Approve Rolled out', value: '19');

  const TicketTwoStatusEnum({required this.status, required this.value});

  final String status;
  final String value;
}
