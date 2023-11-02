abstract class ExpenseEvent {}

class FetchExpenseList extends ExpenseEvent {
  final int pageNo;

  FetchExpenseList({required this.pageNo});
}
