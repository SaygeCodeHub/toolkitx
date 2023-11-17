enum ExpenseWorkingAtEnum {
  workOrder(status: 'Workorder', value: '0'),
  wbs(status: 'WBS', value: '1'),
  project(status: 'Project', value: '2'),
  generalWbs(status: 'General WBS', value: '3');

  const ExpenseWorkingAtEnum({required this.status, required this.value});

  final String status;
  final String value;
}
