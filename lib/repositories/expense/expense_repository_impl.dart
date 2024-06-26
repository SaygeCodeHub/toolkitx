import 'package:toolkit/data/models/expense/approve_expnse_model.dart';
import 'package:toolkit/data/models/expense/close_expense_model.dart';
import 'package:toolkit/data/models/expense/delete_expense_item_model.dart';
import 'package:toolkit/data/models/expense/expense_item_custom_field_model.dart';
import 'package:toolkit/data/models/expense/expense_submit_for_approval_model.dart';
import 'package:toolkit/data/models/expense/expense_working_at_number_model.dart';
import 'package:toolkit/data/models/expense/fetch_expense_details_model.dart';
import 'package:toolkit/data/models/expense/fetch_expense_master_model.dart';
import 'package:toolkit/data/models/expense/fetch_item_master_model.dart';
import 'package:toolkit/data/models/expense/reject_expense_model.dart';
import 'package:toolkit/data/models/expense/save_expense_item_model.dart';
import 'package:toolkit/data/models/expense/save_expense_model.dart';
import 'package:toolkit/data/models/expense/update_expense_model.dart';

import '../../data/models/expense/fetch_expense_item_details_model.dart';
import '../../data/models/expense/fetch_expense_list_model.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';
import 'expense_repository.dart';

class ExpenseRepositoryImpl extends ExpenseRepository {
  @override
  Future<FetchExpenseListModel> fetchExpenseList(
      int pageNo, String userId, String hashCode, String filter) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}expense/get?pageno=$pageNo&userid=$userId&hashcode=$hashCode&filter=$filter");
    return FetchExpenseListModel.fromJson(response);
  }

  @override
  Future<FetchExpenseDetailsModel> fetchExpenseDetails(
      String expenseId, String userId, String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}expense/getreport?reportid=$expenseId&userid=$userId&hashcode=$hashCode");
    return FetchExpenseDetailsModel.fromJson(response);
  }

  @override
  Future<FetchExpenseMasterModel> fetchExpenseMaster(String hashCode) async {
    final response = await DioClient()
        .get("${ApiConstants.baseUrl}expense/getmaster?hashcode=$hashCode");
    return FetchExpenseMasterModel.fromJson(response);
  }

  @override
  Future<SaveExpenseModel> addExpense(Map saveExpenseMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}expense/save", saveExpenseMap);
    return SaveExpenseModel.fromJson(response);
  }

  @override
  Future<UpdateExpenseModel> updateExpense(Map updateExpenseMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}expense/Update", updateExpenseMap);
    return UpdateExpenseModel.fromJson(response);
  }

  @override
  Future<ExpenseSubmitForApprovalModel> submitExpenseForApproval(
      Map submitForApprovalMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}expense/SubmitForApproval",
        submitForApprovalMap);
    return ExpenseSubmitForApprovalModel.fromJson(response);
  }

  @override
  Future<FetchItemMasterModel> fetchExpenseItemMaster(
      String hashCode, String expenseId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}expense/getitemmaster1?hashcode=$hashCode&reportid=$expenseId");
    return FetchItemMasterModel.fromJson(response);
  }

  @override
  Future<ApproveExpenseModel> approveExpense(Map approveExpenseMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}expense/Approve", approveExpenseMap);
    return ApproveExpenseModel.fromJson(response);
  }

  @override
  Future<CloseExpenseModel> closeExpense(Map closeExpenseMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}expense/CloseReport", closeExpenseMap);
    return CloseExpenseModel.fromJson(response);
  }

  @override
  Future<DeleteExpenseItemModel> deleteExpenseItem(
      Map deleteExpenseItemMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}expense/deleteitem", deleteExpenseItemMap);
    return DeleteExpenseItemModel.fromJson(response);
  }

  @override
  Future<SaveExpenseItemModel> saveExpenseItem(Map saveItemMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}expense/saveitem", saveItemMap);
    return SaveExpenseItemModel.fromJson(response);
  }

  @override
  Future<ExpenseItemCustomFieldsModel> fetchExpenseItemCustomFields(
      Map customFieldsMap) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}expense/getitemcustomfields?expenseitemid=${customFieldsMap['expenseitemid']}&itemid=${customFieldsMap['itemid']}&hashcode=${customFieldsMap['hashcode']}");
    return ExpenseItemCustomFieldsModel.fromJson(response);
  }

  @override
  Future<ExpenseWorkingAtNumberDataModel> fetchWorkingAtNumberData(
      Map fetchWorkingAtNumberMap) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}timesheet/getemployeeworkingat?groupby=${fetchWorkingAtNumberMap['groupby']}&userid=${fetchWorkingAtNumberMap['userid']}&hashcode=${fetchWorkingAtNumberMap['hashcode']}");
    return ExpenseWorkingAtNumberDataModel.fromJson(response);
  }

  @override
  Future<FetchExpenseItemDetailsModel> fetchExpenseItemDetails(
      Map itemDetailsMap) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}expense/GetExpenseItem?itemid=${itemDetailsMap['item_id']}&hashcode=${itemDetailsMap['hash_code']}");
    return FetchExpenseItemDetailsModel.fromJson(response);
  }

  @override
  Future<ExpenseRejectModel> rejectExpense(Map rejectExpenseMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}expense/RejectReport", rejectExpenseMap);
    return ExpenseRejectModel.fromJson(response);
  }
}
