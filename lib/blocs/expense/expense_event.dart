abstract class ExpenseEvent {}

class FetchExpenseList extends ExpenseEvent {
  final int pageNo;

  FetchExpenseList({required this.pageNo});
}

class FetchExpenseDetails extends ExpenseEvent {
  final String expenseId;
  final int tabIndex;

  FetchExpenseDetails({required this.tabIndex, required this.expenseId});
}
