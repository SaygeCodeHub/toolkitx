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

class SaveOutgoingInvoice extends AccountingEvent {
  final Map outgoingInvoiceMap;

  SaveOutgoingInvoice({required this.outgoingInvoiceMap});
}

