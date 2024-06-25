class ApproveCheckListEvent {
  final Map approveMap;
  final List responseIdList;

  ApproveCheckListEvent(
      {required this.responseIdList, required this.approveMap});
}
