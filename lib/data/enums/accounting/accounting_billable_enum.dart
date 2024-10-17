enum AccountingBillableEnum {
  yes(billText: "Yes", billValue: '1'),
  no(billText: "No", billValue: '2');

  const AccountingBillableEnum(
      {required this.billText, required this.billValue});

  final String billValue;
  final String billText;
}
