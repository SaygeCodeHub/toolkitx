abstract class LeavesAndHolidaysEvent {}

class FetchLeavesSummary extends LeavesAndHolidaysEvent {}

class FetchLeavesDetails extends LeavesAndHolidaysEvent {
  final int page;

  FetchLeavesDetails({required this.page});
}
