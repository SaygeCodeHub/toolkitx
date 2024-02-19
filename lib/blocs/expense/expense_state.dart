import '../../data/models/expense/expense_item_custom_field_model.dart';
import '../../data/models/expense/expense_submit_for_approval_model.dart';
import '../../data/models/expense/expense_working_at_number_model.dart';
import '../../data/models/expense/fetch_expense_details_model.dart';

import '../../data/models/expense/fetch_expense_item_details_model.dart';
import '../../data/models/expense/fetch_expense_master_model.dart';
import '../../data/models/expense/fetch_item_master_model.dart';
import '../../data/models/expense/save_expense_item_model.dart';
import '../../data/models/expense/save_expense_model.dart';
import '../../data/models/expense/update_expense_model.dart';

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

class FetchingExpenseDetails extends ExpenseStates {}

class ExpenseDetailsFetched extends ExpenseStates {
  final FetchExpenseDetailsModel fetchExpenseDetailsModel;
  final List popUpMenuList;
  final Map manageExpenseMap;

  ExpenseDetailsFetched(
      {required this.manageExpenseMap,
      required this.popUpMenuList,
      required this.fetchExpenseDetailsModel});
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

class UpdatingExpense extends ExpenseStates {}

class ExpenseUpdated extends ExpenseStates {
  final UpdateExpenseModel updateExpenseModel;
  final String expenseId;

  ExpenseUpdated({required this.expenseId, required this.updateExpenseModel});
}

class ExpenseCouldNotUpdate extends ExpenseStates {
  final String expenseNotUpdated;

  ExpenseCouldNotUpdate({required this.expenseNotUpdated});
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

class FetchingExpenseItemMaster extends ExpenseStates {}

class ExpenseItemMasterFetched extends ExpenseStates {
  final FetchItemMasterModel fetchItemMasterModel;
  final bool isScreenChange;
  final String apiKey;

  ExpenseItemMasterFetched(
      {required this.apiKey,
      required this.isScreenChange,
      required this.fetchItemMasterModel});
}

class ExpenseItemMasterCouldNotFetch extends ExpenseStates {
  final String itemsNotFound;

  ExpenseItemMasterCouldNotFetch({required this.itemsNotFound});
}

class ExpenseDateSelected extends ExpenseStates {
  final String date;

  ExpenseDateSelected({required this.date});
}

class ExpenseItemSelected extends ExpenseStates {
  final Map itemsMap;

  ExpenseItemSelected({required this.itemsMap});
}

class ExpenseWorkingAtOptionSelected extends ExpenseStates {
  final String workingAt;
  final String workingAtValue;

  ExpenseWorkingAtOptionSelected(
      {required this.workingAtValue, required this.workingAt});
}

class ExpenseWorkingAtNumberSelected extends ExpenseStates {
  final Map workingAtNumberMap;

  ExpenseWorkingAtNumberSelected({required this.workingAtNumberMap});
}

class ExpenseAddItemsCurrencySelected extends ExpenseStates {
  final Map currencyDetailsMap;

  ExpenseAddItemsCurrencySelected({required this.currencyDetailsMap});
}

class ApprovingExpense extends ExpenseStates {}

class ExpenseApproved extends ExpenseStates {}

class ExpenseNotApproved extends ExpenseStates {
  final String notApproved;

  ExpenseNotApproved({required this.notApproved});
}

class ClosingExpense extends ExpenseStates {}

class ExpenseClosed extends ExpenseStates {}

class ExpenseNotClosed extends ExpenseStates {
  final String notClosed;

  ExpenseNotClosed({required this.notClosed});
}

class DeletingExpenseItem extends ExpenseStates {}

class ExpenseItemDeleted extends ExpenseStates {}

class ExpenseItemNotDeleted extends ExpenseStates {
  final String itemNotDeleted;

  ExpenseItemNotDeleted({required this.itemNotDeleted});
}

class SavingExpenseItem extends ExpenseStates {}

class ExpenseItemSaved extends ExpenseStates {
  final SaveExpenseItemModel saveExpenseItemModel;

  ExpenseItemSaved({required this.saveExpenseItemModel});
}

class ExpenseItemCouldNotSave extends ExpenseStates {
  final String itemNotSaved;

  ExpenseItemCouldNotSave({required this.itemNotSaved});
}

class FetchingExpenseCustomFields extends ExpenseStates {}

class ExpenseCustomFieldsFetched extends ExpenseStates {
  final ExpenseItemCustomFieldsModel expenseItemCustomFieldsModel;

  ExpenseCustomFieldsFetched({required this.expenseItemCustomFieldsModel});
}

class ExpenseCustomFieldsNotFetched extends ExpenseStates {
  final String fieldsNotFetched;

  ExpenseCustomFieldsNotFetched({required this.fieldsNotFetched});
}

class FetchingWorkingAtNumberData extends ExpenseStates {}

class WorkingAtNumberDataFetched extends ExpenseStates {
  final ExpenseWorkingAtNumberDataModel expenseWorkingAtNumberDataModel;

  WorkingAtNumberDataFetched({required this.expenseWorkingAtNumberDataModel});
}

class WorkingAtNumberDataNotFetched extends ExpenseStates {
  final String dataNotFetched;

  WorkingAtNumberDataNotFetched({required this.dataNotFetched});
}

class FetchingExpenseItemDetails extends ExpenseStates {}

class ExpenseItemDetailsFetched extends ExpenseStates {
  final FetchExpenseItemDetailsModel fetchExpenseItemDetailsModel;

  ExpenseItemDetailsFetched({required this.fetchExpenseItemDetailsModel});
}

class ExpenseItemDetailsNotFetched extends ExpenseStates {
  final String itemDetailsNotFetched;

  ExpenseItemDetailsNotFetched({required this.itemDetailsNotFetched});
}

class RejectingExpense extends ExpenseStates {}

class ExpenseReject extends ExpenseStates {}

class ExpenseNotReject extends ExpenseStates {
  final String errorMessage;

  ExpenseNotReject({required this.errorMessage});
}
