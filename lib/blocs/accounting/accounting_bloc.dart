import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/data/cache/customer_cache.dart';
import 'package:toolkit/data/models/accounting/create_incoming_invoice_model.dart';
import 'package:toolkit/data/models/accounting/delete_outgoing_invoice_model.dart';
import 'package:toolkit/data/models/accounting/fetch_accounting_master_model.dart';
import 'package:toolkit/data/models/accounting/fetch_incoming_invoices_model.dart';
import 'package:toolkit/data/models/accounting/fetch_master_data_entry_model.dart';
import 'package:toolkit/data/models/accounting/fetch_outgoing_invoices_model.dart';
import 'package:toolkit/data/models/accounting/create_outgoing_invoice_model.dart';
import 'package:toolkit/repositories/accounting/accounting_repository.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../data/models/accounting/delete_incoming_invoice_model.dart';
import '../../di/app_module.dart';
import 'accounting_event.dart';
import 'accounting_state.dart';

class AccountingBloc extends Bloc<AccountingEvent, AccountingState> {
  final CustomerCache _customerCache = getIt<CustomerCache>();
  final AccountingRepository _accountingRepository =
      getIt<AccountingRepository>();
  final Map incomingFilterMap = {};
  final Map outgoingFilterMap = {};
  final Map manageIncomingInvoiceMap = {};
  final Map manageOutgoingInvoiceMap = {};
  final List<IncomingInvoicesDatum> incomingInvoices = [];
  final List<OutgoingInvoicesDatum> outgoingInvoices = [];
  List<FetchMasterDataEntryModel> fetchedMasterDataList = [];
  List<ClientDatum> clientList = [];
  List<ClientDatum> creditCardsList = [];
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
    on<SelectPaymentMode>(_selectPaymentMode);
    on<SelectInvoiceCurrency>(_selectInvoiceCurrency);
    on<SelectCurrency>(_selectCurrency);
    on<CreateIncomingInvoice>(_createIncomingInvoice);
    on<CreateOutgoingInvoice>(_createOutgoingInvoice);
    on<SelectCreditCard>(_selectCreditCard);
    on<DeleteIncomingInvoice>(_deleteIncomingInvoice);
    on<DeleteOutgoingInvoice>(_deleteOutgoingInvoice);
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
      if (fetchIAccountingMasterModel.data != null) {
        fetchIAccountingMasterModel.data![3]
            .add(AccountingMasterDatum.fromJson({"name": 'Other'}));
      }
      if (fetchIAccountingMasterModel.status != 200 &&
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
    creditCardsList.clear();
    try {
      FetchMasterDataEntryModel fetchMasterDataEntryModel =
          await _accountingRepository.fetchMasterDataEntry(event.entityId);
      if (fetchMasterDataEntryModel.status == 200) {
        clientList.addAll(
            fetchMasterDataEntryModel.data.expand((list) => list).toList());
        creditCardsList.addAll(fetchMasterDataEntryModel.data[1]);
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

  FutureOr<void> _selectPaymentMode(
      SelectPaymentMode event, Emitter<AccountingState> emit) async {
    emit(PaymentModeSelected(
        paymentModeId: event.paymentModeId, paymentMode: event.paymentMode));
  }

  FutureOr<void> _selectInvoiceCurrency(
      SelectInvoiceCurrency event, Emitter<AccountingState> emit) async {
    emit(InvoiceCurrencySelected(selectedCurrency: event.selectedCurrency));
  }

  FutureOr<void> _selectCurrency(
      SelectCurrency event, Emitter<AccountingState> emit) {
    emit(CurrencySelected(
        currencyId: event.currencyId, currency: event.currency));
  }

  FutureOr<void> _createIncomingInvoice(
      CreateIncomingInvoice event, Emitter<AccountingState> emit) async {
    emit(CreatingIncomingInvoice());
    try {
      Map createIncomingInvoiceMap = {
        "entity": manageIncomingInvoiceMap['entity'] ?? '',
        "billable": manageIncomingInvoiceMap['billable'] ?? '',
        "client": manageIncomingInvoiceMap['client'] ?? '',
        "project": manageIncomingInvoiceMap['project'] ?? '',
        "date": manageIncomingInvoiceMap['date'] ?? '',
        "purposename": manageIncomingInvoiceMap['purposename'] ?? '',
        "mode": manageIncomingInvoiceMap['mode'] ?? '',
        "creditcard": manageIncomingInvoiceMap['creditcard'] ?? '',
        "other": manageIncomingInvoiceMap['other'] ?? '',
        "othercurrency": manageIncomingInvoiceMap['othercurrency'] ?? '',
        "invoiceamount": manageIncomingInvoiceMap['invoiceamount'] ?? '',
        "otherinvoiceamount":
            manageIncomingInvoiceMap['otherinvoiceamount'] ?? '',
        "comments": manageIncomingInvoiceMap['comments'] ?? '',
        "files": manageIncomingInvoiceMap['files'] ?? '',
        "id": "",
        "userid": await _customerCache.getUserId(CacheKeys.userId),
        "hashcode": await _customerCache.getHashCode(CacheKeys.hashcode)
      };
      CreateIncomingInvoiceModel createIncomingInvoiceModel =
          await _accountingRepository
              .createIncomingInvoice(createIncomingInvoiceMap);
      if (createIncomingInvoiceModel.status == 200) {
        if (createIncomingInvoiceModel.message == '1') {
          emit(IncomingInvoiceCreated());
        } else {
          emit(FailedToCreateIncomingInvoice(
              errorMessage: StringConstants.kSomethingWentWrong));
        }
      } else {
        emit(FailedToCreateIncomingInvoice(
            errorMessage: StringConstants.kSomethingWentWrong));
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _createOutgoingInvoice(
      CreateOutgoingInvoice event, Emitter<AccountingState> emit) async {
    emit(CreatingOutgoingInvoice());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      Map createInvoiceMap = {
        "id": "",
        "userid": userId,
        "hashcode": hashCode,
        "files": manageOutgoingInvoiceMap['files'] ?? "",
        "purposename": "",
        "entity": manageOutgoingInvoiceMap['entity'] ?? "",
        "client": manageOutgoingInvoiceMap['client'] ?? "",
        "project": manageOutgoingInvoiceMap['project'] ?? "",
        "date": manageOutgoingInvoiceMap['date'] ?? "",
        "comments": manageOutgoingInvoiceMap['comments'] ?? "",
        "invoiceamount": manageOutgoingInvoiceMap['invoiceamount'] ?? "",
        "other": manageIncomingInvoiceMap['other'] ?? "",
        "othercurrency": manageOutgoingInvoiceMap['othercurrency'] ?? "",
        "otherinvoiceamount": ""
      };
      CreateOutgoingInvoiceModel createOutgoingInvoiceModel =
          await _accountingRepository.createOutgoingInvoice(createInvoiceMap);
      if (createOutgoingInvoiceModel.status == 200) {
        emit(OutgoingInvoiceCreated());
      } else {
        emit(FailedToCreateOutgoingInvoice(
            errorMessage: createOutgoingInvoiceModel.message));
      }
    } on Exception catch (e) {
      emit(FailedToCreateOutgoingInvoice(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _selectCreditCard(
      SelectCreditCard event, Emitter<AccountingState> emit) async {
    try {
      emit(CreditCardSelected(cardName: event.cardName, cardId: event.cardId));
    } catch (e) {
      rethrow;
    }
  }

  FutureOr<void> _deleteIncomingInvoice(
      DeleteIncomingInvoice event, Emitter<AccountingState> emit) async {
    emit(DeletingIncomingInvoice());
    try {
      DeleteIncomingInvoiceModel deleteIncomingInvoiceModel =
          await _accountingRepository.deleteIncomingInvoice({
        "id": event.invoiceId,
        "userid": await _customerCache.getUserId(CacheKeys.userId),
        "hashcode": await _customerCache.getHashCode(CacheKeys.hashcode)
      });
      if (deleteIncomingInvoiceModel.status == 200) {
        if (deleteIncomingInvoiceModel.message == '1') {
          emit(IncomingInvoiceDeleted());
        } else {
          emit(FailedToDeleteIncomingInvoice(
              errorMessage: StringConstants.kSomethingWentWrong));
        }
      } else {
        emit(FailedToDeleteIncomingInvoice(
            errorMessage: StringConstants.kSomethingWentWrong));
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _deleteOutgoingInvoice(
      DeleteOutgoingInvoice event, Emitter<AccountingState> emit) async {
    emit(DeletingOutgoingInvoice());
    try {
      DeleteOutgoingInvoiceModel deleteOutgoingInvoiceModel =
          await _accountingRepository.deleteOutgoingInvoice({
        "id": event.invoiceId,
        "userid": await _customerCache.getUserId(CacheKeys.userId),
        "hashcode": await _customerCache.getHashCode(CacheKeys.hashcode)
      });
      if (deleteOutgoingInvoiceModel.status == 200) {
        if (deleteOutgoingInvoiceModel.message == '1') {
          emit(OutgoingInvoiceDeleted());
        } else {
          emit(FailedToDeleteOutgoingInvoice(
              errorMessage: StringConstants.kSomethingWentWrong));
        }
      } else {
        emit(FailedToDeleteOutgoingInvoice(
            errorMessage: StringConstants.kSomethingWentWrong));
      }
    } catch (e) {
      rethrow;
    }
  }
}
