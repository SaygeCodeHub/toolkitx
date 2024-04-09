enum TicketBugEnum {
  yes(option: 'Yes', value: '1'),
  no(option: 'No', value: '0');

  const TicketBugEnum({required this.option, required this.value});

  final String option;
  final String value;
}
