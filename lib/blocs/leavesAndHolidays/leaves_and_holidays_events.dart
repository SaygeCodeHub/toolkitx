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
