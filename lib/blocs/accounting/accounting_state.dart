import 'package:toolkit/data/models/accounting/fetch_master_data_entry_model.dart';
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

class OutgoingInvoiceSaving extends AccountingState {}

class OutgoingInvoiceSaved extends AccountingState {}

class OutgoingInvoiceNotSaved extends AccountingState {
  final String errorMessage;

  OutgoingInvoiceNotSaved({required this.errorMessage});
}