enum WorkOrderPriorityEnum {
  p1(priority: 'P1', value: '1'),
  p2(priority: 'P2', value: '2'),
  p3(priority: 'P3', value: '3'),
  p4(priority: 'P4', value: '4'),
  p5(priority: 'P5', value: '5');

  const WorkOrderPriorityEnum({required this.priority, required this.value});

  final String priority;
  final String value;
}
