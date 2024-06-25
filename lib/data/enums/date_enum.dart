enum CustomDateFormat {
  dotDdMmYyyy(dateFormat: "dd.MM.yyyy", value: '1'),
  slashMmDdYyyy(dateFormat: "MM/dd/yyyy", value: '2'),
  slashDdMmYyyy(dateFormat: "dd/MM/yyyy", value: '3'),
  dashYyyyMmDd(dateFormat: "yyyy-M-d", value: '4'),
  slashYyyyMmDd(dateFormat: "yyyy/MM/dd", value: '5'),
  dotYyyMmDd(dateFormat: "yyy.MM.dd", value: '6'),
  dashYyyMmDd(dateFormat: "yyyy-MM-dd", value: '7');

  const CustomDateFormat({required this.dateFormat, required this.value});

  final String dateFormat;
  final String value;
}
