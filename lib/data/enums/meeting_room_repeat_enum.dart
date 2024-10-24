enum MeetingRoomRepeatEnum {
  noRecord(status: 'No Record', value: '0'),
  daily(status: 'Daily', value: '1'),
  weekly(status: 'Weekly', value: '3'),
  monthly(status: 'Monthly', value: '4');

  const MeetingRoomRepeatEnum({required this.status, required this.value});

  final String status;
  final String value;
}
