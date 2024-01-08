import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/expense/approve_expnse_model.dart';
import '../../data/models/expense/close_expense_model.dart';
import '../../data/models/expense/delete_expense_item_model.dart';
import '../../data/models/expense/expense_submit_for_approval_model.dart';
import '../../data/models/expense/fetch_expense_details_model.dart';
import '../../data/models/expense/fetch_expense_list_model.dart';
import '../../data/models/expense/fetch_expense_master_model.dart';
import '../../data/models/expense/fetch_item_master_model.dart';
import '../../data/models/expense/save_expense_item_model.dart';
import '../../data/models/expense/save_expense_model.dart';
import '../../data/models/expense/update_expense_model.dart';
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
    on<FetchExpenseMaster>(_fetchExpenseMaster);
    on<ExpenseSelectCurrency>(_selectCurrency);
    on<AddExpense>(_saveExpense);
    on<UpdateExpense>(_updateExpense);
    on<SubmitExpenseForApproval>(_submitExpenseForApproval);
    on<FetchExpenseItemMaster>(_fetchItemMaster);
    on<SelectExpenseDate>(_selectDate);
    on<SelectExpenseItem>(_selectItem);
    on<SelectExpenseWorkingAtOption>(_selectWorkingAtOption);
    on<SelectExpenseWorkingAtNumber>(_selectWorkingAtNumber);
    on<SelectExpenseAddItemsCurrency>(_selectAddItemCurrency);
    on<ApproveExpense>(_approveExpense);
    on<CloseExpense>(_closeExpense);
    on<DeleteExpenseItem>(_deleteExpenseItem);
    on<SaveExpenseItem>(_saveItem);
  }

  List<ExpenseListDatum> expenseListData = [];
  bool expenseListReachedMax = false;
  int tabIndex = 0;
  Map filters = {};
  String expenseId = '';

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
      expenseId = event.expenseId;
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
      Map manageExpensesMap = {
        'startdate': fetchExpenseDetailsModel.data.startdate,
        'enddate': fetchExpenseDetailsModel.data.enddate,
        'location': fetchExpenseDetailsModel.data.location,
        'purpose': fetchExpenseDetailsModel.data.purpose,
        'currency_id': fetchExpenseDetailsModel.data.currency,
        'currency_name': fetchExpenseDetailsModel.data.currencyname
      };
      emit(ExpenseDetailsFetched(
          fetchExpenseDetailsModel: fetchExpenseDetailsModel,
          popUpMenuList: popUpMenuList,
          manageExpenseMap: manageExpensesMap));
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

  Future<void> _fetchExpenseMaster(
      FetchExpenseMaster event, Emitter<ExpenseStates> emit) async {
    try {
      emit(FetchingExpenseMaster());
      String hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      FetchExpenseMasterModel fetchExpenseMasterModel =
          await _expenseRepository.fetchExpenseMaster(hashCode);
      if (fetchExpenseMasterModel.data.isNotEmpty) {
        emit(ExpenseMasterFetched(
            fetchExpenseMasterModel: fetchExpenseMasterModel));
      } else {
        emit(ExpenseMasterNotFetched(
            masterNotFetched: StringConstants.kNoRecordsFound));
      }
    } catch (e) {
      emit(ExpenseMasterNotFetched(masterNotFetched: e.toString()));
    }
  }

  _selectCurrency(ExpenseSelectCurrency event, Emitter<ExpenseStates> emit) {
    emit(ExpenseCurrencySelected(currencyDetailsMap: event.currencyDetailsMap));
  }

  Future<void> _saveExpense(
      AddExpense event, Emitter<ExpenseStates> emit) async {
    emit(SavingAddExpense());
    try {
      String hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      if (event.saveExpenseMap['startdate'] == null &&
              event.saveExpenseMap['enddate'] == null &&
              event.saveExpenseMap['currency'] == null ||
          event.saveExpenseMap['currency'].isEmpty) {
        emit(AddExpenseNotSaved(
            expenseNotSaved:
                DatabaseUtil.getText('DateAndCurrencyCompulsary')));
      } else if (DateFormat("dd.MM.yyy")
              .parse(event.saveExpenseMap['startdate'])
              .compareTo(DateFormat("dd.MM.yyy")
                  .parse(event.saveExpenseMap['enddate'])) >
          0) {
        emit(AddExpenseNotSaved(
            expenseNotSaved: DatabaseUtil.getText(
                'Enddateshouldbegreaterthanstartdatetime')));
      } else {
        Map saveExpenseMap = {
          "startdate": event.saveExpenseMap['startdate'],
          "enddate": event.saveExpenseMap['enddate'],
          "location": event.saveExpenseMap['location'] ?? '',
          "purpose": event.saveExpenseMap['purpose'] ?? '',
          "currency": event.saveExpenseMap['currency'],
          "userid": userId,
          "hashcode": hashCode
        };
        SaveExpenseModel saveExpenseModel =
            await _expenseRepository.addExpense(saveExpenseMap);
        if (saveExpenseModel.status == 200) {
          emit(AddExpenseSaved(saveExpenseModel: saveExpenseModel));
        } else {
          emit(AddExpenseNotSaved(
              expenseNotSaved: DatabaseUtil.getText('UnknownErrorMessage')));
        }
      }
    } catch (e) {
      emit(AddExpenseNotSaved(expenseNotSaved: e.toString()));
    }
  }

  Future<void> _updateExpense(
      UpdateExpense event, Emitter<ExpenseStates> emit) async {
    emit(UpdatingExpense());
    try {
      String hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      if (event.manageExpenseMap['startdate'] == null &&
              event.manageExpenseMap['enddate'] == null &&
              event.manageExpenseMap['currency'] == null ||
          event.manageExpenseMap['currency'].isEmpty) {
        emit(AddExpenseNotSaved(
            expenseNotSaved:
                DatabaseUtil.getText('DateAndCurrencyCompulsary')));
      } else if (DateFormat("dd.MM.yyy")
              .parse(event.manageExpenseMap['startdate'])
              .compareTo(DateFormat("dd.MM.yyy")
                  .parse(event.manageExpenseMap['enddate'])) >
          0) {
        emit(AddExpenseNotSaved(
            expenseNotSaved: DatabaseUtil.getText(
                'Enddateshouldbegreaterthanstartdatetime')));
      } else {
        Map updateExpenseMap = {
          "reportid": expenseId,
          "startdate": event.manageExpenseMap['startdate'] ?? '',
          "enddate": event.manageExpenseMap['enddate'] ?? '',
          "location": event.manageExpenseMap['location'] ?? '',
          "purpose": event.manageExpenseMap['purpose'] ?? '',
          "currency1": event.manageExpenseMap['currency_id'] ?? '',
          "currency2": event.manageExpenseMap['new_currency_id'] ??
              event.manageExpenseMap['currency_id'],
          "showcurrencychangewarning":
              (event.manageExpenseMap['new_currency_id'] !=
                      event.manageExpenseMap['currency_id'])
                  ? '1'
                  : '0',
          "userid": userId,
          "hashcode": hashCode
        };

        UpdateExpenseModel updateExpenseModel =
            await _expenseRepository.updateExpense(updateExpenseMap);
        if (updateExpenseModel.message == 'Modifyingexpensereport') {
          emit(ExpenseCouldNotUpdate(
              expenseNotUpdated:
                  DatabaseUtil.getText('Modifyingexpensereport')));
          event.manageExpenseMap['currency_id'] =
              event.manageExpenseMap['new_currency_id'];
        } else if (updateExpenseModel.message == '1') {
          emit(ExpenseUpdated(
              updateExpenseModel: updateExpenseModel, expenseId: expenseId));
        } else {
          emit(ExpenseCouldNotUpdate(
              expenseNotUpdated: DatabaseUtil.getText('UnknownErrorMessage')));
        }
      }
    } catch (e) {
      emit(ExpenseCouldNotUpdate(expenseNotUpdated: e.toString()));
    }
  }

  Future<void> _submitExpenseForApproval(
      SubmitExpenseForApproval event, Emitter<ExpenseStates> emit) async {
    emit(SubmittingExpenseForApproval());
    try {
      String hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      Map submitExpenseForApproval = {
        "reportid": expenseId,
        "userid": userId,
        "hashcode": hashCode
      };
      ExpenseSubmitForApprovalModel expenseSubmitForApprovalModel =
          await _expenseRepository
              .submitExpenseForApproval(submitExpenseForApproval);
      if (expenseSubmitForApprovalModel.message == '1') {
        emit(ExpenseForApprovalSubmitted(
            expenseSubmitForApprovalModel: expenseSubmitForApprovalModel));
      } else {
        emit(ExpenseForApprovalFailedToSubmit(
            approvalFailedToSubmit:
                DatabaseUtil.getText('UnknownErrorMessage')));
      }
    } catch (e) {
      emit(ExpenseForApprovalFailedToSubmit(
          approvalFailedToSubmit: e.toString()));
    }
  }

  Future<void> _fetchItemMaster(
      FetchExpenseItemMaster event, Emitter<ExpenseStates> emit) async {
    try {
      emit(FetchingExpenseItemMaster());
      String hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      FetchItemMasterModel fetchItemMasterModel =
          await _expenseRepository.fetchExpenseItemMaster(hashCode, expenseId);
      emit(ExpenseItemMasterFetched(
          fetchItemMasterModel: fetchItemMasterModel,
          isScreenChange: event.isScreenChange));
      add(SelectExpenseDate(date: ''));
    } catch (e) {
      emit(ExpenseItemMasterCouldNotFetch(itemsNotFound: e.toString()));
    }
  }

  _selectDate(SelectExpenseDate event, Emitter<ExpenseStates> emit) {
    emit(ExpenseDateSelected(date: event.date));
  }

  _selectItem(SelectExpenseItem event, Emitter<ExpenseStates> emit) {
    emit(ExpenseItemSelected(itemsMap: event.itemsMap));
  }

  _selectWorkingAtOption(
      SelectExpenseWorkingAtOption event, Emitter<ExpenseStates> emit) {
    emit(ExpenseWorkingAtOptionSelected(workingAt: event.workingAt));
  }

  _selectWorkingAtNumber(SelectExpenseWorkingAtNumber event,
      Emitter<ExpenseStates> emit) {
    emit(ExpenseWorkingAtNumberSelected(
        workingAtNumberMap: event.workingAtNumberMap));
  }

  _selectAddItemCurrency(SelectExpenseAddItemsCurrency event,
      Emitter<ExpenseStates> emit) {
    emit(ExpenseAddItemsCurrencySelected(
        currencyDetailsMap: event.currencyDetailsMap));
  }

  FutureOr<void> _approveExpense(
      ApproveExpense event, Emitter<ExpenseStates> emit) async {
    emit(ApprovingExpense());
    try {
      ApproveExpenseModel approveExpenseModel =
          await _expenseRepository.approveExpense({
        "reportid": expenseId,
        "userid": await _customerCache.getHashCode(CacheKeys.hashcode) ?? '',
        "hashcode": await _customerCache.getUserId(CacheKeys.userId) ?? ''
      });
      if (approveExpenseModel.message == StringConstants.kSuccessCode) {
        emit(ExpenseApproved());
      } else {
        emit(ExpenseNotApproved(
            notApproved:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(ExpenseNotApproved(notApproved: e.toString()));
    }
  }

  FutureOr<void> _closeExpense(
      CloseExpense event, Emitter<ExpenseStates> emit) async {
    emit(ClosingExpense());
    try {
      CloseExpenseModel closeExpenseModel =
          await _expenseRepository.closeExpense({
        "reportid": expenseId,
        "userid": await _customerCache.getUserId(CacheKeys.userId) ?? '',
        "hashcode": await _customerCache.getUserId(CacheKeys.hashcode) ?? ''
      });
      if (closeExpenseModel.message == StringConstants.kSuccessCode) {
        emit(ExpenseClosed());
      } else {
        emit(ExpenseNotClosed(
            notClosed:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(ExpenseNotClosed(notClosed: e.toString()));
    }
  }

  FutureOr<void> _deleteExpenseItem(
      DeleteExpenseItem event, Emitter<ExpenseStates> emit) async {
    try {
      emit(DeletingExpenseItem());
      DeleteExpenseItemModel deleteExpenseItemModel =
          await _expenseRepository.deleteExpenseItem({
        "id": event.itemId,
        "hashcode": await _customerCache.getHashCode(CacheKeys.hashcode) ?? ''
      });
      if (deleteExpenseItemModel.status == 200) {
        emit(ExpenseItemDeleted());
      } else {
        emit(ExpenseItemNotDeleted(
            itemNotDeleted:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(ExpenseItemNotDeleted(itemNotDeleted: e.toString()));
    }
  }

  Future<void> _saveItem(SaveExpenseItem event,
      Emitter<ExpenseStates> emit) async {
    emit(SavingExpenseItem());
    try {
      String hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      if (event.expenseItemMap['amount'] == null &&
          event.expenseItemMap['reportcurrency'] == null) {
        emit(ExpenseItemCouldNotSave(
            itemNotSaved:
            StringConstants.kExpenseAddItemAmountAndCurrencyValidation));
      } else {
        Map saveItemMap = {
          "id": "",
          "expenseid": expenseId,
          "date": event.expenseItemMap['date'] ?? '',
          "itemid": event.expenseItemMap['itemid'] ?? '',
          "amount": event.expenseItemMap['amount'] ?? '',
          "exchange_rate": event.expenseItemMap['exchange_rate'] ?? '',
          "description": event.expenseItemMap['description'] ?? '',
          "currency": event.expenseItemMap['currency'] ?? '',
          "filenames": event.expenseItemMap['filenames'] ?? '',
          "reportcurrency": event.expenseItemMap['reportcurrency'] ??
              event.expenseItemMap['currency'],
          "workingatid": event.expenseItemMap['workingatid'] ?? '',
          "workingatnumber": event.expenseItemMap['workingatnumber'] ?? '',
          "userid": userId,
          "hashcode": hashCode,
          "questions": []
        };
        SaveExpenseItemModel saveExpenseItemModel =
        await _expenseRepository.saveExpenseItem(saveItemMap);
        if (saveExpenseItemModel.message == '1') {
          emit(ExpenseItemSaved(saveExpenseItemModel: saveExpenseItemModel));
        } else {
          emit(ExpenseItemCouldNotSave(
              itemNotSaved: DatabaseUtil.getText('UnknownErrorMessage')));
        }
      }
    } catch (e) {
      emit(ExpenseItemCouldNotSave(itemNotSaved: e.toString()));
    }
  }
}
