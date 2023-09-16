import '../../../data/models/workorder/fetch_workorder_details_model.dart';

abstract class WorkOrderTabDetailsStates {}

class WorkOrderTabDetailsInitial extends WorkOrderTabDetailsStates {}

class FetchingWorkOrderTabDetails extends WorkOrderTabDetailsStates {}

class WorkOrderTabDetailsFetched extends WorkOrderTabDetailsStates {
  final FetchWorkOrderTabDetailsModel fetchWorkOrderDetailsModel;
  final int tabInitialIndex;
  final String? clientId;
  final List popUpMenuList;
  final Map workOrderDetailsMap;

  WorkOrderTabDetailsFetched(
      {required this.workOrderDetailsMap,
      required this.popUpMenuList,
      this.clientId = '',
      required this.tabInitialIndex,
      required this.fetchWorkOrderDetailsModel});
}

class WorkOrderTabDetailsNotFetched extends WorkOrderTabDetailsStates {
  final String tabDetailsNotFetched;

  WorkOrderTabDetailsNotFetched({required this.tabDetailsNotFetched});
}

class WorkOrderCompanyOptionSelected extends WorkOrderTabDetailsStates {
  final String companyId;
  final String companyName;

  WorkOrderCompanyOptionSelected(
      {required this.companyId, required this.companyName});
}

class WorkOrderLocationOptionSelected extends WorkOrderTabDetailsStates {
  final String locationId;
  final String locationName;

  WorkOrderLocationOptionSelected(
      {required this.locationId, required this.locationName});
}
