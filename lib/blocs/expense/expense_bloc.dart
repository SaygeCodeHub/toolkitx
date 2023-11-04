import 'dart:convert';

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
    on<SelectExpenseStatus>(_selectExpenseStatus);
    on<ExpenseApplyFilter>(_expenseApplyFilter);
    on<ExpenseClearFilter>(_expenseClearFilter);
  }

  List<ExpenseListDatum> expenseListData = [];
  bool expenseListReachedMax = false;
  Map filters = {};

  Future<void> _fetchExpenseList(
      FetchExpenseList event, Emitter<ExpenseStates> emit) async {
    try {
      emit(FetchingExpenses());
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      if (event.isFromHome) {
        FetchExpenseListModel fetchExpenseListModel = await _expenseRepository
            .fetchExpenseList(event.pageNo, userId!, hashCode!, '{}');
        expenseListReachedMax = fetchExpenseListModel.expenseListData.isEmpty;
        expenseListData.addAll(fetchExpenseListModel.expenseListData);
        emit(
            ExpensesFetched(expenseListDatum: expenseListData, filtersMap: {}));
      } else {
        FetchExpenseListModel fetchExpenseListModel =
            await _expenseRepository.fetchExpenseList(
                event.pageNo, userId!, hashCode!, jsonEncode(filters));
        expenseListReachedMax = fetchExpenseListModel.expenseListData.isEmpty;
        expenseListData.addAll(fetchExpenseListModel.expenseListData);
        emit(ExpensesFetched(
            expenseListDatum: expenseListData, filtersMap: filters));
      }
    } catch (e) {
      emit(ExpensesNotFetched(expensesNotFetched: e.toString()));
    }
  }

  _selectExpenseStatus(SelectExpenseStatus event, Emitter<ExpenseStates> emit) {
    List selectedStatusIdList = List.from(event.statusIdList);
    List selectedStatusNameList = List.from(event.statusNameList);
    if (selectedStatusIdList.contains(event.statusId)) {
      selectedStatusIdList.remove(event.statusId);
      selectedStatusNameList.remove(event.statusName);
    } else {
      selectedStatusIdList.add(event.statusId);
      selectedStatusNameList.add(event.statusName);
    }
    emit(ExpenseStatusSelected(
        statusIdList: selectedStatusIdList,
        statusValueList: selectedStatusNameList));
  }

  _expenseApplyFilter(ExpenseApplyFilter event, Emitter<ExpenseStates> emit) {
    filters = event.expenseFilterMap;
  }

  _expenseClearFilter(ExpenseClearFilter event, Emitter<ExpenseStates> emit) {
    filters = {};
  }
}
