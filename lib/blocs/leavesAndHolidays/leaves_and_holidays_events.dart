abstract class LeavesAndHolidaysEvent {}

class FetchLeavesSummary extends LeavesAndHolidaysEvent {}

class FetchLeavesDetails extends LeavesAndHolidaysEvent {
  final int page;

  FetchLeavesDetails({required this.page});
}

class FetchLeavesAndHolidaysMaster extends LeavesAndHolidaysEvent {}

class SelectLeaveType extends LeavesAndHolidaysEvent {
  final String leaveTypeId;

  SelectLeaveType({required this.leaveTypeId});
}

class ApplyForLeave extends LeavesAndHolidaysEvent {
  final Map applyForLeaveMap;

  ApplyForLeave({required this.applyForLeaveMap});
}

class GetTimeSheet extends LeavesAndHolidaysEvent {
  final String year;
  final String month;

  GetTimeSheet({required this.year, required this.month});
}

class FetchCheckInTimeSheet extends LeavesAndHolidaysEvent {
  final String date;

  FetchCheckInTimeSheet({required this.date});
}

class DeleteTimeSheet extends LeavesAndHolidaysEvent {
  final String timeId;

  DeleteTimeSheet({required this.timeId});
}

class SelectTimeSheetWorkingAtOption extends LeavesAndHolidaysEvent {
  final String workingAt;
  final String workingAtValue;

  SelectTimeSheetWorkingAtOption(
      {required this.workingAtValue, required this.workingAt});
}

class SelectTimeSheetWorkingAtNumber extends LeavesAndHolidaysEvent {
  final Map timeSheetWorkingAtNumberMap;

  SelectTimeSheetWorkingAtNumber({required this.timeSheetWorkingAtNumberMap});
}

class FetchTimeSheetWorkingAtNumberData extends LeavesAndHolidaysEvent {
  final String groupBy;

  FetchTimeSheetWorkingAtNumberData({required this.groupBy});
}

class SaveTimeSheet extends LeavesAndHolidaysEvent {
  final Map saveTimeSheetMap;

  SaveTimeSheet({required this.saveTimeSheetMap});
}

class SubmitTimeSheet extends LeavesAndHolidaysEvent {
  final Map submitTimeSheetMap;

  SubmitTimeSheet({required this.submitTimeSheetMap});
}

class FetchTimeSheetDetails extends LeavesAndHolidaysEvent {
  final String timeSheetDetailsId;

  FetchTimeSheetDetails({required this.timeSheetDetailsId});
}
