import 'package:equatable/equatable.dart';

import '../../../../data/models/checklist/systemUser/sys_user_workforce_list_model.dart';

abstract class CheckListScheduleDatesResponseStates extends Equatable {}

class CheckListScheduleDatesResponseInitial
    extends CheckListScheduleDatesResponseStates {
  @override
  List<Object?> get props => [];
}

class CheckListNoResponseFound extends CheckListScheduleDatesResponseStates {
  final String noResponseMessage;
  final String scheduleId;

  CheckListNoResponseFound(
      {required this.scheduleId, required this.noResponseMessage});

  @override
  List<Object?> get props => [noResponseMessage, scheduleId];
}

class FetchingCheckListWorkforceList
    extends CheckListScheduleDatesResponseStates {
  @override
  List<Object?> get props => [];
}

class CheckListWorkforceListFetched
    extends CheckListScheduleDatesResponseStates {
  final CheckListWorkforceListModel checkListWorkforceListModel;
  final List selectedIResponseIdList;
  final bool popUpMenuBuilder;

  CheckListWorkforceListFetched(
      {this.popUpMenuBuilder = false,
      required this.checkListWorkforceListModel,
      required this.selectedIResponseIdList});

  @override
  List<Object?> get props =>
      [checkListWorkforceListModel, selectedIResponseIdList, popUpMenuBuilder];
}

class CheckListWorkforceListError extends CheckListScheduleDatesResponseStates {
  @override
  List<Object?> get props => [];
}

class CheckListPopUpMenuItemsFetched
    extends CheckListScheduleDatesResponseStates {
  final List popUpMenuItems;

  CheckListPopUpMenuItemsFetched({required this.popUpMenuItems});

  @override
  List<Object?> get props => [popUpMenuItems];
}
