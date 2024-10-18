enum StatusEnum {
  yes(label: "Yes", value: '1'),
  no(label: "No", value: '0');

  const StatusEnum({required this.value, required this.label});

  final String value;
  final String label;
}
