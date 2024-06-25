import 'package:equatable/equatable.dart';

import '../../../../data/models/checklist/systemUser/sys_user_schedule_by_dates_model.dart';

abstract class CheckListScheduleDatesStates extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CheckListScheduleDatesInitial extends CheckListScheduleDatesStates {}

class FetchingCheckListScheduleDates extends CheckListScheduleDatesStates {}

class CheckListDatesScheduled extends CheckListScheduleDatesStates {
  final ChecklistScheduledByDatesModel checklistScheduledByDatesModel;
  final Map allChecklistDataMap;

  CheckListDatesScheduled(
      {required this.allChecklistDataMap,
      required this.checklistScheduledByDatesModel});

  @override
  List<Object?> get props =>
      [allChecklistDataMap, checklistScheduledByDatesModel];
}

class CheckListDatesNotScheduled extends CheckListScheduleDatesStates {
  final String noDatesScheduled;

  CheckListDatesNotScheduled({required this.noDatesScheduled});
}
