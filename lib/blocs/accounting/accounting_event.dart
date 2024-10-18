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

class FetchMasterDataEntity extends AccountingEvent {
  final int entityId;

  FetchMasterDataEntity({required this.entityId});
}

class SelectClientId extends AccountingEvent {
  final dynamic clientId;

  SelectClientId({required this.clientId});
}

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

class CreateIncomingInvoice extends AccountingEvent {
  final String incomingInvoiceId;

  CreateIncomingInvoice({required this.incomingInvoiceId});
}

class CreateOutgoingInvoice extends AccountingEvent {
  final String outgoingInvoiceId;

  CreateOutgoingInvoice({required this.outgoingInvoiceId});
}

class SelectCreditCard extends AccountingEvent {
  final String cardName;
  final String cardId;

  SelectCreditCard({required this.cardName, required this.cardId});
}

class DeleteIncomingInvoice extends AccountingEvent {
  final String invoiceId;

  DeleteIncomingInvoice({required this.invoiceId});
}

class DeleteOutgoingInvoice extends AccountingEvent {
  final String invoiceId;

  DeleteOutgoingInvoice({required this.invoiceId});
}

class FetchOutgoingInvoice extends AccountingEvent {
  final String invoiceId;

  FetchOutgoingInvoice({required this.invoiceId});
}

class FetchIncomingInvoice extends AccountingEvent {
  final String invoiceId;

  FetchIncomingInvoice({required this.invoiceId});
}
