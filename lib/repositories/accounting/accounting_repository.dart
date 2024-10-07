import 'package:toolkit/data/models/accounting/fetch_accounting_master_model.dart';
import 'package:toolkit/data/models/accounting/fetch_outgoing_invoices_model.dart';

import '../../data/models/accounting/fetch_bank_statements_model.dart';
import '../../data/models/accounting/fetch_incoming_invoices_model.dart';

abstract class AccountingRepository {
  Future<FetchOutgoingInvoicesModel> fetchOutgoingInvoices(
      int pageNo, String filter);
  Future<FetchIncomingInvoicesModel> fetchIncomingInvoices(
      int pageNo, String filter);
  Future<FetchAccountingMasterModel> fetchAccountingMaster();
  Future<FetchBankStatementsModel> fetchBankStatements(
      int pageNo, String filter);
}
