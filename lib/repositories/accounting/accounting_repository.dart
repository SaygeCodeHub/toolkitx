import 'package:toolkit/data/models/accounting/fetch_accounting_master_model.dart';
import 'package:toolkit/data/models/accounting/fetch_master_data_entry_model.dart';
import 'package:toolkit/data/models/accounting/fetch_outgoing_invoices_model.dart';
import 'package:toolkit/data/models/accounting/create_outgoing_invoice_model.dart';

import '../../data/models/accounting/create_incoming_invoice_model.dart';
import '../../data/models/accounting/delete_incoming_invoice_model.dart';
import '../../data/models/accounting/fetch_incoming_invoices_model.dart';

abstract class AccountingRepository {
  Future<FetchOutgoingInvoicesModel> fetchOutgoingInvoices(
      int pageNo, String filter);

  Future<FetchIncomingInvoicesModel> fetchIncomingInvoices(
      int pageNo, String filter);

  Future<FetchIAccountingMasterModel> fetchAccountingMaster();

  Future<FetchMasterDataEntryModel> fetchMasterDataEntry(int entityId);

  Future<CreateOutgoingInvoiceModel> createOutgoingInvoice(
      Map outgoingInvoiceMap);

  Future<CreateIncomingInvoiceModel> createIncomingInvoice(
      Map createIncomingInvoiceMap);

  Future<DeleteIncomingInvoiceModel> deleteIncomingInvoice(
      Map deleteIncomingInvoiceMap);
}
