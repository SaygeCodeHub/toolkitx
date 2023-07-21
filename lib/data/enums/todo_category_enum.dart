enum ToDoCategoryEnum {
  healthAssessment(status: 'Health Risk Assessment ToDos', value: '1'),
  production(status: 'Production', value: '2'),
  serverDevelopment(status: 'Server Development', value: '3'),
  work(status: 'Work', value: '4');

  const ToDoCategoryEnum({required this.status, required this.value});

  final String status;
  final String value;
}
