import '../../../../data/models/checklist/systemUser/sys_user_schedule_by_dates_model.dart';
import '../../../../data/models/checklist/systemUser/sys_user_workforce_list_model.dart';

abstract class CheckListScheduleDatesResponseEvent {}

class CheckCheckListScheduleDatesResponse
    extends CheckListScheduleDatesResponseEvent {
  final GetChecklistDetailsData getChecklistDetailsData;
  final String scheduleId;
  final String role;

  CheckCheckListScheduleDatesResponse(
      {required this.role,
      required this.getChecklistDetailsData,
      required this.scheduleId});
}

class CheckListWorkForceListFetch extends CheckListScheduleDatesResponseEvent {
  final String scheduleId;
  final String role;
  final List responseIds;

  CheckListWorkForceListFetch(
      {required this.responseIds,
      required this.role,
      required this.scheduleId});
}

class CheckListCheckBoxCheck extends CheckListScheduleDatesResponseEvent {
  final String responseId;
  final CheckListWorkforceListModel checkListWorkforceListModel;
  final List responseIdList;
  bool popUpBuilder;

  CheckListCheckBoxCheck(
      {required this.responseId,
      required this.checkListWorkforceListModel,
      required this.responseIdList,
      this.popUpBuilder = false});
}

class FetchCheckListPopUpMenu extends CheckListScheduleDatesResponseEvent {
  final List popUpMenuItems;
  final bool popUpMenuBuilder;

  FetchCheckListPopUpMenu(
      {required this.popUpMenuBuilder, required this.popUpMenuItems});
}
