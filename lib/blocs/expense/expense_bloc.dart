import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/expense/fetch_expense_list_model.dart';
import '../../di/app_module.dart';
import '../../repositories/expense/expense_repository.dart';
import 'expense_event.dart';
import 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseStates> {
  final ExpenseRepository _expenseRepository = getIt<ExpenseRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  ExpenseBloc() : super(ExpenseInitial()) {
    on<FetchExpenseList>(_fetchExpenseList);
  }

  List<ExpenseListDatum> expenseListData = [];
  bool expenseListReachedMax = false;

  Future<void> _fetchExpenseList(
      FetchExpenseList event, Emitter<ExpenseStates> emit) async {
    try {
      emit(FetchingExpenses());
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      FetchExpenseListModel fetchExpenseListModel = await _expenseRepository
          .fetchExpenseList(event.pageNo, userId!, hashCode!, '{}');
      expenseListReachedMax = fetchExpenseListModel.expenseListData.isEmpty;
      expenseListData.addAll(fetchExpenseListModel.expenseListData);
      emit(ExpensesFetched(expenseListDatum: expenseListData));
    } catch (e) {
      emit(ExpensesNotFetched(expensesNotFetched: e.toString()));
    }
  }
}