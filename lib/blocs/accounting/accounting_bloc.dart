import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/accounting/fetch_incoming_invoices_model.dart';
import 'package:toolkit/data/models/accounting/fetch_outgoing_invoices_model.dart';
import 'package:toolkit/repositories/accounting/accounting_repository.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../di/app_module.dart';
import 'accounting_event.dart';
import 'accounting_state.dart';

class AccountingBloc extends Bloc<AccountingEvent, AccountingState> {
  final AccountingRepository _accountingRepository =
  getIt<AccountingRepository>();
  final List<IncomingInvoicesDatum> incomingInvoices = [];
    final List<OutgoingInvoicesDatum> outgoingInvoices = [];
  bool incomingInvoicesReachedMax = false;
  bool outgoingInvoicesReachedMax = false;

  AccountingBloc() : super(AccountingInitial()) {
    on<FetchIncomingInvoices>(_fetchIncomingInvoices);
    on<FetchOutgoingInvoices>(_fetchOutgoingInvoices);
  }

  FutureOr<void> _fetchIncomingInvoices(
      FetchIncomingInvoices event, Emitter<AccountingState> emit) async {
    emit(FetchingIncomingInvoices(pageNo: event.pageNo));
    try {
      FetchIncomingInvoicesModel fetchIncomingInvoicesModel =
      await _accountingRepository.fetchIncomingInvoices(event.pageNo);
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

  Future<void> _fetchOutgoingInvoices(FetchOutgoingInvoices event, Emitter<AccountingState> emit) async {
    emit(FetchingOutgoingInvoices(pageNo: event.pageNo));
    try {
      FetchOutgoingInvoicesModel fetchOutgoingInvoicesModel =
      await _accountingRepository.fetchOutgoingInvoices(event.pageNo);
      outgoingInvoicesReachedMax = fetchOutgoingInvoicesModel.data.isEmpty;
      if (fetchOutgoingInvoicesModel.status == 200) {
        if (fetchOutgoingInvoicesModel.data.isNotEmpty) {
          outgoingInvoices.addAll(fetchOutgoingInvoicesModel.data);
          emit(OutgoingInvoicesFetched(
              outgoingInvoices: outgoingInvoices, pageNo: event.pageNo));
        } else {
          emit(FailedToFetchOutgoingInvoices(
              errorMessage: StringConstants.kNoRecordsFound));
        }
      } else if (fetchOutgoingInvoicesModel.status == 204) {
        emit(OutgoingInvoicesWithNoData(
            message: StringConstants.kNoRecordsFound));
      } else {
        emit(FailedToFetchOutgoingInvoices(
            errorMessage: StringConstants.kSomethingWentWrong));
      }
    } catch (e) {
      rethrow;
    }
  }
}
