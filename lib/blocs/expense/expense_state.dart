import '../../data/models/expense/fetch_expense_details_model.dart';

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

class FetchingExpenseDetails extends ExpenseStates {}

class ExpenseDetailsFetched extends ExpenseStates {
  final FetchExpenseDetailsModel fetchExpenseDetailsModel;

  ExpenseDetailsFetched({required this.fetchExpenseDetailsModel});
}

class ExpenseDetailsFailedToFetch extends ExpenseStates {
  final String expenseDetailsNotFetched;

  ExpenseDetailsFailedToFetch({required this.expenseDetailsNotFetched});
}
