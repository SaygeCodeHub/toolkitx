import '../../data/models/accounting/fetch_accounting_master_model.dart';
import '../../data/models/accounting/fetch_incoming_invoices_model.dart';

abstract class AccountingRepository {
  Future<FetchIncomingInvoicesModel> fetchIncomingInvoices(
      int pageNo, String filter);
  Future<FetchIAccountingMasterModel> fetchAccountingMaster();
}
