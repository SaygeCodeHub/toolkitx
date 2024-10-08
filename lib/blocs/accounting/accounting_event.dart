abstract class AccountingEvent {}

class FetchIncomingInvoices extends AccountingEvent {
  final int pageNo;
  final bool isFilterEnabled;

  FetchIncomingInvoices({required this.pageNo, this.isFilterEnabled = false});
}

class FetchOutgoingInvoices extends AccountingEvent {
  final int pageNo;
  final bool isFilterEnabled;

  FetchOutgoingInvoices({required this.pageNo, this.isFilterEnabled = false});
}

class FetchAccountingMaster extends AccountingEvent {}

class SelectPaymentMode extends AccountingEvent {
  final String paymentModeId;
  final String paymentMode;

  SelectPaymentMode({required this.paymentMode, required this.paymentModeId});
}

class SelectInvoiceCurrency extends AccountingEvent {
  final String selectedCurrency;

  SelectInvoiceCurrency({required this.selectedCurrency});
}

class SelectCurrency extends AccountingEvent {
  final String currencyId;
  final String currency;

  SelectCurrency({required this.currencyId, required this.currency});
}

class CreateIncomingInvoice extends AccountingEvent {}
