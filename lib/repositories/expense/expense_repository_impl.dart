import 'package:toolkit/data/models/expense/fetch_expense_master_model.dart';
import 'package:toolkit/data/models/expense/save_expense_model.dart';

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
}
