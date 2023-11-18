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

class FetchExpenseMaster extends ExpenseEvent {}

class ExpenseSelectCurrency extends ExpenseEvent {
  final Map currencyDetailsMap;

  ExpenseSelectCurrency({required this.currencyDetailsMap});
}

class AddExpense extends ExpenseEvent {
  final Map saveExpenseMap;

  AddExpense({required this.saveExpenseMap});
}

class UpdateExpense extends ExpenseEvent {
  final Map manageExpenseMap;

  UpdateExpense({required this.manageExpenseMap});
}

class SubmitExpenseForApproval extends ExpenseEvent {}

class FetchExpenseItemMaster extends ExpenseEvent {
  final bool isScreenChange;

  FetchExpenseItemMaster({required this.isScreenChange});
}

class SelectExpenseDate extends ExpenseEvent {
  final String date;

  SelectExpenseDate({required this.date});
}

class SelectExpenseItem extends ExpenseEvent {
  final Map itemsMap;

  SelectExpenseItem({required this.itemsMap});
}

class SelectExpenseWorkingAtOption extends ExpenseEvent {
  final String workingAt;

  SelectExpenseWorkingAtOption({required this.workingAt});
}

class SelectExpenseWorkingAtNumber extends ExpenseEvent {
  final Map workingAtNumberMap;

  SelectExpenseWorkingAtNumber({required this.workingAtNumberMap});
}

class SelectExpenseAddItemsCurrency extends ExpenseEvent {
  final Map currencyDetailsMap;

  SelectExpenseAddItemsCurrency({required this.currencyDetailsMap});
}
