import '../../data/models/accounting/fetch_incoming_invoices_model.dart';

abstract class AccountingRepository {
  Future<FetchIncomingInvoicesModel> fetchIncomingInvoices(int pageNo);
}
