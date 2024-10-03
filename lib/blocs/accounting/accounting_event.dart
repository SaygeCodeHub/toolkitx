abstract class AccountingEvent {}

class FetchIncomingInvoices extends AccountingEvent {
  final int pageNo;

  FetchIncomingInvoices({required this.pageNo});
}
