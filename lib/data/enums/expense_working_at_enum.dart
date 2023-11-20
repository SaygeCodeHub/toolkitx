enum ExpenseWorkingAtEnum {
  workOrder(status: 'Workorder'),
  wbs(status: 'WBS'),
  project(status: 'Project'),
  generalWbs(status: 'General WBS');

  const ExpenseWorkingAtEnum({required this.status});

  final String status;
}
