import '../../../../data/models/checklist/workforce/workforce_list_model.dart';

abstract class WorkForceListStates {}

class FetchListInitial extends WorkForceListStates {}

class FetchingList extends WorkForceListStates {}

class ListFetched extends WorkForceListStates {
  final WorkforceGetCheckListModel workforceGetCheckListModel;

  ListFetched({required this.workforceGetCheckListModel});
}

class ListNotFetched extends WorkForceListStates {}
