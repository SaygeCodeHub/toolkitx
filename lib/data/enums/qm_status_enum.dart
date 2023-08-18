enum QualityManagementStatusEnum {
  created(status: 'Created', value: '-1'),
  reported(status: 'Reported', value: '0'),
  acknowledged(status: 'Acknowledged', value: '1'),
  mitigationDefined(status: 'MitigationDefined', value: '2'),
  mitigationApproved(status: 'MitigationApproved', value: '3'),
  mitigationImplemented(status: 'MitigationImplemented', value: '4'),
  resolved(status: 'Resolved', value: '5');

  const QualityManagementStatusEnum(
      {required this.status, required this.value});

  final String status;
  final String value;
}
