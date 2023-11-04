abstract class ExpenseStates {}

class ExpenseInitial extends ExpenseStates {}

class FetchingExpenses extends ExpenseStates {}

class ExpensesFetched extends ExpenseStates {
  final List expenseListDatum;
  final Map filtersMap;

  ExpensesFetched({required this.filtersMap, required this.expenseListDatum});
}

class ExpensesNotFetched extends ExpenseStates {
  final String expensesNotFetched;

  ExpensesNotFetched({required this.expensesNotFetched});
}

class ExpenseStatusSelected extends ExpenseStates {
  final List statusValueList;
  final List statusIdList;

  ExpenseStatusSelected(
      {required this.statusIdList, required this.statusValueList});
}
