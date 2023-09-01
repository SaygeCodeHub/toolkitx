enum QualityManagementClassificationEnum {
  faultEquipment(status: 'Fault equipment', value: '0'),
  safetyIssue(status: 'Safety issue', value: '1'),
  spill(status: 'Spill', value: '2'),
  test(status: 'Test', value: '3');

  const QualityManagementClassificationEnum(
      {required this.status, required this.value});

  final String status;
  final String value;
}
