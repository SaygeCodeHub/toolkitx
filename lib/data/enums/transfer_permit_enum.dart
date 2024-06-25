enum TransferPermitEnum {
  workForce(type: 'Workforce', value: '1'),
  sap(type: 'SAP', value: '2');

  const TransferPermitEnum({required this.type, required this.value});

  final String type;
  final String value;
}
