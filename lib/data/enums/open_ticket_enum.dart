enum OpenTicketEnum {
  no(vo: 'No', value: '0'),
  yes(vo: 'Yes', value: '1');

  const OpenTicketEnum({required this.vo, required this.value});

  final String vo;
  final String value;
}
