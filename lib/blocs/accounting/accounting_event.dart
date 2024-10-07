abstract class AccountingEvent {}

class FetchIncomingInvoices extends AccountingEvent {
  final int pageNo;
  final bool isFilterEnabled;

  FetchIncomingInvoices({required this.pageNo, this.isFilterEnabled = false});
}

class FetchAccountingMaster extends AccountingEvent {}
