enum LogbookStatusEnum {
  approved(status: 'Open', value: '5'),
  open(status: 'Close', value: '2');

  const LogbookStatusEnum({required this.status, required this.value});

  final String status;
  final String value;
}
