import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/accounting/fetch_accounting_master_model.dart';
import 'package:toolkit/data/models/accounting/fetch_incoming_invoices_model.dart';
import 'package:toolkit/repositories/accounting/accounting_repository.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../di/app_module.dart';
import 'accounting_event.dart';
import 'accounting_state.dart';

class AccountingBloc extends Bloc<AccountingEvent, AccountingState> {
  final AccountingRepository _accountingRepository =
      getIt<AccountingRepository>();
  final Map accountingFilterMap = {};
  final List<IncomingInvoicesDatum> incomingInvoices = [];
  bool incomingInvoicesReachedMax = false;
  FetchIAccountingMasterModel fetchIAccountingMasterModel =
      FetchIAccountingMasterModel();

  AccountingBloc() : super(AccountingInitial()) {
    on<FetchIncomingInvoices>(_fetchIncomingInvoices);
    on<FetchAccountingMaster>(_fetchAccountingMaster);
  }

  FutureOr<void> _fetchIncomingInvoices(
      FetchIncomingInvoices event, Emitter<AccountingState> emit) async {
    emit(FetchingIncomingInvoices(pageNo: event.pageNo));
    incomingInvoices.clear();
    try {
      FetchIncomingInvoicesModel fetchIncomingInvoicesModel =
          await _accountingRepository.fetchIncomingInvoices(
              event.pageNo, jsonEncode(accountingFilterMap));
      incomingInvoicesReachedMax = fetchIncomingInvoicesModel.data.isEmpty;
      if (fetchIncomingInvoicesModel.status == 200) {
        if (fetchIncomingInvoicesModel.data.isNotEmpty) {
          incomingInvoices.addAll(fetchIncomingInvoicesModel.data);
          emit(IncomingInvoicesFetched(
              incomingInvoices: incomingInvoices, pageNo: event.pageNo));
        } else {
          emit(FailedToFetchIncomingInvoices(
              errorMessage: StringConstants.kNoRecordsFound));
        }
      } else if (fetchIncomingInvoicesModel.status == 204) {
        emit(IncomingInvoicesWithNoData(
            message: StringConstants.kNoRecordsFound));
      } else {
        emit(FailedToFetchIncomingInvoices(
            errorMessage: StringConstants.kSomethingWentWrong));
      }
    } catch (e) {
      rethrow;
    }
  }

  FutureOr<void> _fetchAccountingMaster(
      FetchAccountingMaster event, Emitter<AccountingState> emit) async {
    try {
      fetchIAccountingMasterModel =
          await _accountingRepository.fetchAccountingMaster();
      if (fetchIAccountingMasterModel.status != 200 ||
          fetchIAccountingMasterModel.status != 204) {
        emit(FailedToFetchAccountingMaster(
            errorMessage: StringConstants.kSomethingWentWrong));
      }
    } catch (e) {
      rethrow;
    }
  }
}
