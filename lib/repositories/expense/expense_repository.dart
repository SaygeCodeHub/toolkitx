import 'package:toolkit/data/models/expense/reject_expense_model.dart';

import '../../data/models/expense/approve_expnse_model.dart';
import '../../data/models/expense/close_expense_model.dart';
import '../../data/models/expense/delete_expense_item_model.dart';
import '../../data/models/expense/expense_item_custom_field_model.dart';
import '../../data/models/expense/expense_submit_for_approval_model.dart';
import '../../data/models/expense/expense_working_at_number_model.dart';
import '../../data/models/expense/fetch_expense_details_model.dart';
import '../../data/models/expense/fetch_expense_item_details_model.dart';
import '../../data/models/expense/fetch_expense_list_model.dart';
import '../../data/models/expense/fetch_expense_master_model.dart';
import '../../data/models/expense/fetch_item_master_model.dart';
import '../../data/models/expense/save_expense_item_model.dart';
import '../../data/models/expense/save_expense_model.dart';
import '../../data/models/expense/update_expense_model.dart';

abstract class ExpenseRepository {
  Future<FetchExpenseListModel> fetchExpenseList(
      int pageNo, String userId, String hashCode, String filter);

  Future<FetchExpenseDetailsModel> fetchExpenseDetails(
      String expenseId, String userId, String hashCode);

  Future<FetchExpenseMasterModel> fetchExpenseMaster(String hashCode);

  Future<SaveExpenseModel> addExpense(Map saveExpenseMap);

  Future<UpdateExpenseModel> updateExpense(Map updateExpenseMap);

  Future<ExpenseSubmitForApprovalModel> submitExpenseForApproval(
      Map submitForApprovalMap);

  Future<FetchItemMasterModel> fetchExpenseItemMaster(
      String hashCode, String expenseId);

  Future<ApproveExpenseModel> approveExpense(Map approveExpenseMap);

  Future<CloseExpenseModel> closeExpense(Map closeExpenseMap);

  Future<DeleteExpenseItemModel> deleteExpenseItem(Map deleteExpenseItemMap);

  Future<SaveExpenseItemModel> saveExpenseItem(Map saveItemMap);

  Future<ExpenseWorkingAtNumberDataModel> fetchWorkingAtNumberData(
      Map fetchWorkingAtNumberMap);

  Future<ExpenseItemCustomFieldsModel> fetchExpenseItemCustomFields(
      Map customFieldsMap);

  Future<FetchExpenseItemDetailsModel> fetchExpenseItemDetails(
      Map itemDetailsMap);

  Future<ExpenseRejectModel> rejectExpense(Map rejectExpenseMap);
}
