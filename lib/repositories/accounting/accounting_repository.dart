import 'package:toolkit/data/models/accounting/fetch_outgoing_invoices_model.dart';

import '../../data/models/accounting/fetch_incoming_invoices_model.dart';

abstract class AccountingRepository {
  Future<FetchIncomingInvoicesModel> fetchIncomingInvoices(int pageNo);

  Future<FetchOutgoingInvoicesModel> fetchOutgoingInvoices(int pageNo);
}
