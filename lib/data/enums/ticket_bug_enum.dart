enum TicketBugEnum {
  yes(option: 'Yes', value: '1'),
  no(option: 'no', value: '0');

  const TicketBugEnum({required this.option, required this.value});

  final String option;
  final String value;
}
