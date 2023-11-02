import '../../data/models/expense/fetch_expense_list_model.dart';

abstract class ExpenseRepository {
  Future<FetchExpenseListModel> fetchExpenseList(
      int pageNo, String userId, String hashCode, String filter);
}
