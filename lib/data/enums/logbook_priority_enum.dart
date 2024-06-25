enum LogbookPriorityEnum {
  high(priority: 'High', value: '1'),
  low(priority: 'Low', value: '2'),
  medium(priority: 'Medium', value: '3');

  const LogbookPriorityEnum({required this.priority, required this.value});

  final String priority;
  final String value;
}
