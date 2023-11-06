import '../../data/models/expense/expense_submit_for_approval_model.dart';
import '../../data/models/expense/fetch_expense_details_model.dart';

import '../../data/models/expense/fetch_expense_master_model.dart';
import '../../data/models/expense/save_expense_model.dart';

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

  ExpenseStatusSelected({required this.statusIdList, required this.statusValueList});
}

class FetchingExpenseDetails extends ExpenseStates {}

class ExpenseDetailsFetched extends ExpenseStates {
  final FetchExpenseDetailsModel fetchExpenseDetailsModel;
  final List popUpMenuList;

  ExpenseDetailsFetched({required this.popUpMenuList, required this.fetchExpenseDetailsModel});
}

class ExpenseDetailsFailedToFetch extends ExpenseStates {
  final String expenseDetailsNotFetched;

  ExpenseDetailsFailedToFetch({required this.expenseDetailsNotFetched});
}

class FetchingExpenseMaster extends ExpenseStates {}

class ExpenseMasterFetched extends ExpenseStates {
  final FetchExpenseMasterModel fetchExpenseMasterModel;

  ExpenseMasterFetched({required this.fetchExpenseMasterModel});
}

class ExpenseMasterNotFetched extends ExpenseStates {
  final String masterNotFetched;

  ExpenseMasterNotFetched({required this.masterNotFetched});
}

class ExpenseCurrencySelected extends ExpenseStates {
  final Map currencyDetailsMap;

  ExpenseCurrencySelected({required this.currencyDetailsMap});
}

class SavingAddExpense extends ExpenseStates {}

class AddExpenseSaved extends ExpenseStates {
  final SaveExpenseModel saveExpenseModel;

  AddExpenseSaved({required this.saveExpenseModel});
}

class AddExpenseNotSaved extends ExpenseStates {
  final String expenseNotSaved;

  AddExpenseNotSaved({required this.expenseNotSaved});
}

class SubmittingExpenseForApproval extends ExpenseStates {}

class ExpenseForApprovalSubmitted extends ExpenseStates {
  final ExpenseSubmitForApprovalModel expenseSubmitForApprovalModel;

  ExpenseForApprovalSubmitted({required this.expenseSubmitForApprovalModel});
}

class ExpenseForApprovalFailedToSubmit extends ExpenseStates {
  final String approvalFailedToSubmit;

  ExpenseForApprovalFailedToSubmit({required this.approvalFailedToSubmit});
}
