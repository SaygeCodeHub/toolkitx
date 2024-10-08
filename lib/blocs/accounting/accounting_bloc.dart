import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/accounting/fetch_accounting_master_model.dart';
import 'package:toolkit/data/models/accounting/fetch_incoming_invoices_model.dart';
import 'package:toolkit/data/models/accounting/fetch_master_data_entry_model.dart';
import 'package:toolkit/data/models/accounting/fetch_outgoing_invoices_model.dart';
import 'package:toolkit/repositories/accounting/accounting_repository.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../di/app_module.dart';
import 'accounting_event.dart';
import 'accounting_state.dart';

class AccountingBloc extends Bloc<AccountingEvent, AccountingState> {
  final AccountingRepository _accountingRepository =
      getIt<AccountingRepository>();
  final Map incomingFilterMap = {};
  final Map outgoingFilterMap = {};
  final List<IncomingInvoicesDatum> incomingInvoices = [];
  final List<OutgoingInvoicesDatum> outgoingInvoices = [];
  List<FetchMasterDataEntryModel> fetchedMasterDataList = [];
  List<ClientDatum> clientList = [];
  bool incomingInvoicesReachedMax = false;
  bool outgoingInvoicesReachedMax = false;
  FetchIAccountingMasterModel fetchIAccountingMasterModel =
      FetchIAccountingMasterModel();
  int entityId = 0;

  AccountingBloc() : super(AccountingInitial()) {
    on<FetchIncomingInvoices>(_fetchIncomingInvoices);
    on<FetchAccountingMaster>(_fetchAccountingMaster);
    on<FetchOutgoingInvoices>(_fetchOutgoingInvoices);
    on<FetchMasterDataEntity>(_fetchMasterDataEntity);
    on<SelectClientId>(_selectClientId);
  }

  FutureOr<void> _fetchIncomingInvoices(
      FetchIncomingInvoices event, Emitter<AccountingState> emit) async {
    emit(FetchingIncomingInvoices(pageNo: event.pageNo));
    try {
      FetchIncomingInvoicesModel fetchIncomingInvoicesModel =
          await _accountingRepository.fetchIncomingInvoices(
              event.pageNo, jsonEncode(incomingFilterMap));
      incomingInvoicesReachedMax = fetchIncomingInvoicesModel.data.isEmpty;
      if (fetchIncomingInvoicesModel.status == 200) {
        incomingInvoices.addAll(fetchIncomingInvoicesModel.data);
        emit(IncomingInvoicesFetched(
            incomingInvoices: incomingInvoices, pageNo: event.pageNo));
      } else if (fetchIncomingInvoicesModel.status == 204) {
        if (event.isFilterEnabled) {
          emit(NoRecordsFoundForFilter(
              message: StringConstants.kNoRecordsFilter));
        } else if (incomingInvoices.isEmpty && event.pageNo == 1) {
          emit(IncomingInvoicesWithNoData(
              message: StringConstants.kNoRecordsFound, pageNo: event.pageNo));
        } else {
          emit(IncomingInvoicesFetched(
              incomingInvoices: incomingInvoices, pageNo: event.pageNo));
        }
      } else {
        emit(FailedToFetchIncomingInvoices(
            errorMessage: StringConstants.kSomethingWentWrong));
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _fetchOutgoingInvoices(
      FetchOutgoingInvoices event, Emitter<AccountingState> emit) async {
    emit(FetchingOutgoingInvoices(pageNo: event.pageNo));
    try {
      FetchOutgoingInvoicesModel fetchOutgoingInvoicesModel =
          await _accountingRepository.fetchOutgoingInvoices(
              event.pageNo, jsonEncode(outgoingFilterMap));
      outgoingInvoicesReachedMax = fetchOutgoingInvoicesModel.data.isEmpty;
      if (fetchOutgoingInvoicesModel.status == 200) {
        outgoingInvoices.addAll(fetchOutgoingInvoicesModel.data);
        emit(OutgoingInvoicesFetched(
            outgoingInvoices: outgoingInvoices, pageNo: event.pageNo));
      } else if (fetchOutgoingInvoicesModel.status == 204) {
        if (event.isFilterEnabled) {
          emit(NoRecordsFoundForFilter(
              message: StringConstants.kNoRecordsFilter));
        } else if (outgoingInvoices.isEmpty && event.pageNo == 1) {
          emit(OutgoingInvoicesWithNoData(
              message: StringConstants.kNoRecordsFound, pageNo: event.pageNo));
        } else {
          emit(OutgoingInvoicesFetched(
              outgoingInvoices: outgoingInvoices, pageNo: event.pageNo));
        }
      } else {
        emit(FailedToFetchOutgoingInvoices(
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

  Future<void> _fetchMasterDataEntity(
      FetchMasterDataEntity event, Emitter<AccountingState> emit) async {
    emit(AccountingNewEntitySelecting());
    clientList.clear();
    try {
      FetchMasterDataEntryModel fetchMasterDataEntryModel =
          await _accountingRepository.fetchMasterDataEntry(event.entityId);
      if (fetchMasterDataEntryModel.status == 200) {
        clientList.addAll(
            fetchMasterDataEntryModel.data.expand((list) => list).toList());
        emit(AccountingNewEntitySelected(
            fetchMasterDataEntryModel: fetchMasterDataEntryModel));
      } else {
        emit(AccountingNewEntityNotSelected(
            errorMessage:
                fetchMasterDataEntryModel.message ?? "Unknown error occurred"));
      }
    } on Exception catch (e) {
      emit(AccountingNewEntityNotSelected(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _selectClientId(
      SelectClientId event, Emitter<AccountingState> emit) {
    emit(AccountingProjectListFetching());
    try {
      if (event.clientId != '') {
        if (clientList.isNotEmpty) {
          var client =
              clientList.firstWhere((client) => client.id == event.clientId);
          List<Project> projectList = [];
          if (client.projects != null && client.projects!.isNotEmpty) {
            projectList = List<Project>.from(client.projects!);
            emit(AccountingProjectListFetched(projectList: projectList));
          } else {
            emit(AccountingProjectListFetched(projectList: []));
          }
        }
      } else {
        emit(AccountingProjectListNotFetched(
            errorMessage: "Client ID is empty"));
      }
    } on Exception catch (e) {
      emit(AccountingProjectListNotFetched(errorMessage: e.toString()));
    }
  }
}
