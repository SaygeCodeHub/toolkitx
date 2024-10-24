enum AccountingMonthsEnum {
  allMonths(months: [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ]);

  const AccountingMonthsEnum({required this.months});

  final List months;
}
