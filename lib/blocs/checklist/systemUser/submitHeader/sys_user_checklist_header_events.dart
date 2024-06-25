abstract class CheckListHeaderEvent {}

class FetchCheckListEditHeader extends CheckListHeaderEvent {
  final String scheduleId;

  FetchCheckListEditHeader({required this.scheduleId});
}

class CheckListSubmitHeader extends CheckListHeaderEvent {
  final String scheduleId;
  final List submitHeaderList;

  CheckListSubmitHeader(
      {required this.scheduleId, required this.submitHeaderList});
}
