enum AccountingBankPaymentEnum {
  bank(paymentMode: "Bank", paymentModeId: '1'),
  creditCard(paymentMode: "Credit Card", paymentModeId: '2'),
  cash(paymentMode: "Cash", paymentModeId: '3');

  const AccountingBankPaymentEnum(
      {required this.paymentMode, required this.paymentModeId});

  final String paymentMode;
  final String paymentModeId;
}
