enum TicketTwoBugEnum {
  yes(option: 'Yes', value: '1'),
  no(option: 'No', value: '0');

  const TicketTwoBugEnum({required this.option, required this.value});

  final String option;
  final String value;
}
