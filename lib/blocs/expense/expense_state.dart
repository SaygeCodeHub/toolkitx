abstract class ExpenseStates {}

class ExpenseInitial extends ExpenseStates {}

class FetchingExpenses extends ExpenseStates {}

class ExpensesFetched extends ExpenseStates {
  final List expenseListDatum;

  ExpensesFetched({required this.expenseListDatum});
}

class ExpensesNotFetched extends ExpenseStates {
  final String expensesNotFetched;

  ExpensesNotFetched({required this.expensesNotFetched});
}
