abstract class DateFormatStates {}

class DateFormatSelected extends DateFormatStates {
  final String? dateFormatValue;
  final String dateFormatString;
  final bool isFormProfile;

  DateFormatSelected(
      {this.isFormProfile = false,
      this.dateFormatValue,
      required this.dateFormatString});
}
