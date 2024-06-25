abstract class HomeStates {
  const HomeStates();
}

class HomeInitial extends HomeStates {
  const HomeInitial();
}

class SaveDeviceLoading extends HomeStates {
  const SaveDeviceLoading();
}

class SaveDeviceLoaded extends HomeStates {
  const SaveDeviceLoaded();
}

class DateAndTimeLoaded extends HomeStates {
  final DateTime dateTime;
  final String timeZoneName;
  final String image;
  final String dateFormat;

  const DateAndTimeLoaded(
      {required this.dateTime,
      required this.timeZoneName,
      required this.dateFormat,
      required this.image});
}
