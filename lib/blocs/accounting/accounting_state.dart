import 'package:toolkit/data/models/accounting/fetch_bank_statements_model.dart';
import 'package:toolkit/data/models/accounting/fetch_outgoing_invoices_model.dart';

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

  IncomingInvoicesWithNoData({required this.message});
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

class FetchingBankStatements extends AccountingState {
  final int pageNo;

  FetchingBankStatements({required this.pageNo});
}

class BankStatementsFetched extends AccountingState {
  final List<BankStatementsDatum> bankStatements;
  final int pageNo;

  BankStatementsFetched({required this.bankStatements, required this.pageNo});
}

class BankStatementsWithNoData extends AccountingState {
  final String message;

  BankStatementsWithNoData({required this.message});
}

class FailedToFetchBankStatements extends AccountingState {
  final String errorMessage;

  FailedToFetchBankStatements({required this.errorMessage});
}
