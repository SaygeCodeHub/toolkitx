enum ExpenseWorkingAtEnum {
  workOrder(status: 'Workorder', value: 'wo'),
  wbs(status: 'WBS', value: 'wbs'),
  project(status: 'Project', value: 'project'),
  generalWbs(status: 'General WBS', value: 'generalwbs');

  const ExpenseWorkingAtEnum({required this.status, required this.value});

  final String status;
  final String value;
}
