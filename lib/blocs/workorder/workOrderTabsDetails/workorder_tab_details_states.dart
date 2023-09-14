import '../../../data/models/workorder/fetch_workorder_details_model.dart';

abstract class WorkOrderTabDetailsStates {}

class WorkOrderTabDetailsInitial extends WorkOrderTabDetailsStates {}

class FetchingWorkOrderTabDetails extends WorkOrderTabDetailsStates {}

class WorkOrderTabDetailsFetched extends WorkOrderTabDetailsStates {
  final FetchWorkOrderTabDetailsModel fetchWorkOrderDetailsModel;
  final int tabInitialIndex;
  final String? clientId;
  final List popUpMenuList;

  WorkOrderTabDetailsFetched(
      {required this.popUpMenuList,
      this.clientId = '',
      required this.tabInitialIndex,
      required this.fetchWorkOrderDetailsModel});
}

class WorkOrderTabDetailsNotFetched extends WorkOrderTabDetailsStates {
  final String tabDetailsNotFetched;

  WorkOrderTabDetailsNotFetched({required this.tabDetailsNotFetched});
}
