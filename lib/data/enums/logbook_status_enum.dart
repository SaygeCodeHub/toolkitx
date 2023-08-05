enum LogbookStatusEnum {
  approved(status: 'Open', value: '1'),
  open(status: 'Close', value: '0');

  const LogbookStatusEnum({required this.status, required this.value});

  final String status;
  final String value;
}
