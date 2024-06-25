enum ReportAnonymouslyEnum {
  yes(status: 'Yes', value: '1'),
  no(status: 'No', value: '2');

  const ReportAnonymouslyEnum({required this.status, required this.value});

  final String status;
  final String value;
}
