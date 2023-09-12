import '../../../data/models/workorder/fetch_workorder_details_model.dart';

abstract class WorkOrderTabDetailsStates {}

class WorkOrderTabDetailsInitial extends WorkOrderTabDetailsStates {}

class FetchingWorkOrderTabDetails extends WorkOrderTabDetailsStates {}

class WorkOrderTabDetailsFetched extends WorkOrderTabDetailsStates {
  final FetchWorkOrderTabDetailsModel fetchWorkOrderDetailsModel;
  final int tabInitialIndex;
  final String clientId;

  WorkOrderTabDetailsFetched(
      {required this.clientId,
      required this.tabInitialIndex,
      required this.fetchWorkOrderDetailsModel});
}

class WorkOrderTabDetailsNotFetched extends WorkOrderTabDetailsStates {
  final String tabDetailsNotFetched;

  WorkOrderTabDetailsNotFetched({required this.tabDetailsNotFetched});
}
