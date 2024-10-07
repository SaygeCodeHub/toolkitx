import '../../data/models/accounting/fetch_incoming_invoices_model.dart';

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
