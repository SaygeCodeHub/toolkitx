abstract class AccountingEvent {}

class FetchIncomingInvoices extends AccountingEvent {
  final int pageNo;

  FetchIncomingInvoices({required this.pageNo});
}

class FetchOutgoingInvoices extends AccountingEvent {
  final int pageNo;

  FetchOutgoingInvoices({required this.pageNo});
}
