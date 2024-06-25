enum PermitEmergencyEnum {
  yes(value: true, valueId: '1'),
  no(value: false, valueId: '0');

  const PermitEmergencyEnum({required this.valueId, required this.value});

  final bool value;
  final String valueId;
}
