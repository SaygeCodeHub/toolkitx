import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/expense/fetch_expense_details_model.dart';
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
    on<FetchExpenseDetails>(_fetchExpenseDetails);
  }

  List<ExpenseListDatum> expenseListData = [];
  bool expenseListReachedMax = false;
  int tabIndex = 0;
  Map filters = {};

  Future<void> _fetchExpenseList(
      FetchExpenseList event, Emitter<ExpenseStates> emit) async {
    try {
      emit(FetchingExpenses());
      String hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      if (event.isFromHome) {
        FetchExpenseListModel fetchExpenseListModel = await _expenseRepository
            .fetchExpenseList(event.pageNo, userId, hashCode, '{}');
        expenseListReachedMax = fetchExpenseListModel.expenseListData.isEmpty;
        expenseListData.addAll(fetchExpenseListModel.expenseListData);
        emit(
            ExpensesFetched(expenseListDatum: expenseListData, filtersMap: {}));
      } else {
        FetchExpenseListModel fetchExpenseListModel =
            await _expenseRepository.fetchExpenseList(
                event.pageNo, userId, hashCode, jsonEncode(filters));
        expenseListReachedMax = fetchExpenseListModel.expenseListData.isEmpty;
        expenseListData.addAll(fetchExpenseListModel.expenseListData);
        emit(ExpensesFetched(
            expenseListDatum: expenseListData, filtersMap: filters));
      }
    } catch (e) {
      emit(ExpensesNotFetched(expensesNotFetched: e.toString()));
    }
  }

  Future<void> _fetchExpenseDetails(
      FetchExpenseDetails event, Emitter<ExpenseStates> emit) async {
    try {
      emit(FetchingExpenseDetails());
      String hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      tabIndex = event.tabIndex;
      FetchExpenseDetailsModel fetchExpenseDetailsModel =
          await _expenseRepository.fetchExpenseDetails(
              event.expenseId, userId, hashCode);
      List popUpMenuList = [];
      if (fetchExpenseDetailsModel.data.canEdit == '1') {
        popUpMenuList.add(DatabaseUtil.getText('Edit'));
      }
      if (fetchExpenseDetailsModel.data.canSubmitforapproval == '1') {
        popUpMenuList.add(DatabaseUtil.getText('SubmitForApproval'));
      }
      if (fetchExpenseDetailsModel.data.canApprove == '1') {
        popUpMenuList.add(DatabaseUtil.getText('approve'));
      }
      if (fetchExpenseDetailsModel.data.canClose == '1') {
        popUpMenuList.add(DatabaseUtil.getText('Close'));
      }
      emit(ExpenseDetailsFetched(
          fetchExpenseDetailsModel: fetchExpenseDetailsModel,
          popUpMenuList: popUpMenuList));
    } catch (e) {
      emit(ExpenseDetailsFailedToFetch(expenseDetailsNotFetched: e.toString()));
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
