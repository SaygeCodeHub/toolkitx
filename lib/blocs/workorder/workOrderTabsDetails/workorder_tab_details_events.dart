import '../../../data/models/workorder/fetch_workorder_details_model.dart';

abstract class WorkOrderTabsDetailsEvent {}

class WorkOrderDetails extends WorkOrderTabsDetailsEvent {
  final String workOrderId;
  final int initialTabIndex;

  WorkOrderDetails({required this.initialTabIndex, required this.workOrderId});
}

class WorkOrderToggleSwitchIndex extends WorkOrderTabsDetailsEvent {
  final int toggleIndex;
  final FetchWorkOrderTabDetailsModel fetchWorkOrderDetailsModel;
  final int tabInitialIndex;

  WorkOrderToggleSwitchIndex(
      {required this.fetchWorkOrderDetailsModel,
      required this.tabInitialIndex,
      required this.toggleIndex});
}
