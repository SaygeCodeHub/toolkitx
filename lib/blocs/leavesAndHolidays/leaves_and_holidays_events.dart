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

class SelectTimeSheetWorkingAt extends LeavesAndHolidaysEvent {
  final String value;
  final String status;

  SelectTimeSheetWorkingAt({required this.value, required this.status});
}

class FetchTimeSheetWorkingAtNumberData extends LeavesAndHolidaysEvent {
  final String workingAt;
  final String workingAtValue;

  FetchTimeSheetWorkingAtNumberData({
    required this.workingAt,
    required this.workingAtValue,
  });
}

class SaveTimeSheet extends LeavesAndHolidaysEvent {
  final Map saveTimeSheetMap;

  SaveTimeSheet({required this.saveTimeSheetMap});
}

class SelectCheckBox extends LeavesAndHolidaysEvent {
  final bool isChecked;

  SelectCheckBox({required this.isChecked});
}
