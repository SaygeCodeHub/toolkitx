abstract class ExpenseEvent {}

class FetchExpenseList extends ExpenseEvent {
  final int pageNo;
  final bool isFromHome;

  FetchExpenseList({required this.isFromHome, required this.pageNo});
}

class SelectExpenseStatus extends ExpenseEvent {
  final String statusId;
  final String statusName;
  final List statusIdList;
  final List statusNameList;

  SelectExpenseStatus(
      {required this.statusNameList,
      required this.statusIdList,
      required this.statusId,
      required this.statusName});
}

class FetchExpenseDetails extends ExpenseEvent {
  final String expenseId;
  final int tabIndex;

  FetchExpenseDetails({required this.tabIndex, required this.expenseId});
}

class ExpenseApplyFilter extends ExpenseEvent {
  final Map expenseFilterMap;

  ExpenseApplyFilter({required this.expenseFilterMap});
}

class ExpenseClearFilter extends ExpenseEvent {}
