import 'package:toolkit/data/models/accounting/fetch_outgoing_invoices_model.dart';

import '../../data/models/accounting/fetch_incoming_invoices_model.dart';
import '../../data/models/accounting/fetch_master_data_entry_model.dart';

abstract class AccountingState {}

class AccountingInitial extends AccountingState {}

class FetchingIncomingInvoices extends AccountingState {
  final int pageNo;

  FetchingIncomingInvoices({required this.pageNo});
}

class IncomingInvoicesFetched extends AccountingState {
  final List<IncomingInvoicesDatum> incomingInvoices;
  final int pageNo;

  IncomingInvoicesFetched(
      {required this.incomingInvoices, required this.pageNo});
}

class IncomingInvoicesWithNoData extends AccountingState {
  final String message;
  final int pageNo;

  IncomingInvoicesWithNoData({required this.message, required this.pageNo});
}

class NoRecordsFoundForFilter extends AccountingState {
  final String message;

  NoRecordsFoundForFilter({required this.message});
}

class FailedToFetchIncomingInvoices extends AccountingState {
  final String errorMessage;

  FailedToFetchIncomingInvoices({required this.errorMessage});
}

class FailedToFetchAccountingMaster extends AccountingState {
  final String errorMessage;

  FailedToFetchAccountingMaster({required this.errorMessage});
}

class PaymentModeSelected extends AccountingState {
  final String paymentModeId;
  final String paymentMode;

  PaymentModeSelected({required this.paymentModeId, required this.paymentMode});
}

class FetchingOutgoingInvoices extends AccountingState {
  final int pageNo;

  FetchingOutgoingInvoices({required this.pageNo});
}

class OutgoingInvoicesFetched extends AccountingState {
  final List<OutgoingInvoicesDatum> outgoingInvoices;
  final int pageNo;

  OutgoingInvoicesFetched(
      {required this.outgoingInvoices, required this.pageNo});
}

class OutgoingInvoicesWithNoData extends AccountingState {
  final String message;
  final int pageNo;

  OutgoingInvoicesWithNoData({required this.message, required this.pageNo});
}

class FailedToFetchOutgoingInvoices extends AccountingState {
  final String errorMessage;

  FailedToFetchOutgoingInvoices({required this.errorMessage});
}

class AccountingNewEntitySelecting extends AccountingState {}

class AccountingNewEntitySelected extends AccountingState {
  final FetchMasterDataEntryModel fetchMasterDataEntryModel;

  AccountingNewEntitySelected({required this.fetchMasterDataEntryModel});
}

class AccountingNewEntityNotSelected extends AccountingState {
  final String errorMessage;

  AccountingNewEntityNotSelected({required this.errorMessage});
}

class AccountingProjectListFetching extends AccountingState {}

class AccountingProjectListFetched extends AccountingState {
  final List<Project> projectList;

  AccountingProjectListFetched({required this.projectList});
}

class AccountingProjectListNotFetched extends AccountingState {
  final String errorMessage;

  AccountingProjectListNotFetched({required this.errorMessage});
}

class InvoiceCurrencySelected extends AccountingState {
  final String selectedCurrency;

  InvoiceCurrencySelected({required this.selectedCurrency});
}

class CurrencySelected extends AccountingState {
  final String currencyId;
  final String currency;

  CurrencySelected({required this.currencyId, required this.currency});
}

class CreatingIncomingInvoice extends AccountingState {}

class IncomingInvoiceCreated extends AccountingState {}

class FailedToCreateIncomingInvoice extends AccountingState {
  final String errorMessage;

  FailedToCreateIncomingInvoice({required this.errorMessage});
}

class CreatingOutgoingInvoice extends AccountingState {}

class OutgoingInvoiceCreated extends AccountingState {}

class FailedToCreateOutgoingInvoice extends AccountingState {
  final String errorMessage;

  FailedToCreateOutgoingInvoice({required this.errorMessage});
}

class CreditCardSelected extends AccountingState {
  final String cardName;
  final String cardId;

  CreditCardSelected({required this.cardName, required this.cardId});
}

class DeletingIncomingInvoice extends AccountingState {}

class IncomingInvoiceDeleted extends AccountingState {}

class FailedToDeleteIncomingInvoice extends AccountingState {
  final String errorMessage;

  FailedToDeleteIncomingInvoice({required this.errorMessage});
}

class DeletingOutgoingInvoice extends AccountingState {}

class OutgoingInvoiceDeleted extends AccountingState {}

class FailedToDeleteOutgoingInvoice extends AccountingState {
  final String errorMessage;

  FailedToDeleteOutgoingInvoice({required this.errorMessage});
}
