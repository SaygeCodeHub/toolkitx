import 'package:toolkit/data/models/accounting/fetch_accounting_master_model.dart';
import 'package:toolkit/data/models/accounting/fetch_outgoing_invoices_model.dart';

import '../../data/models/accounting/create_incoming_invoice_model.dart';
import '../../data/models/accounting/fetch_incoming_invoices_model.dart';

abstract class AccountingRepository {
  Future<FetchOutgoingInvoicesModel> fetchOutgoingInvoices(
      int pageNo, String filter);

  Future<FetchIncomingInvoicesModel> fetchIncomingInvoices(
      int pageNo, String filter);

  Future<FetchIAccountingMasterModel> fetchAccountingMaster();

  Future<CreateIncomingInvoiceModel> createIncomingInvoice(
      Map createIncomingInvoiceMap);
}
