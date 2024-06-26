import '../../../data/models/workorder/fetch_workorder_details_model.dart';
import '../../../data/models/workorder/fetch_workorder_documents_model.dart';

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

class SelectWorkOrderCompanyOptions extends WorkOrderTabsDetailsEvent {
  final String companyId;
  final String companyName;

  SelectWorkOrderCompanyOptions(
      {required this.companyId, required this.companyName});
}

class SelectWorkOrderLocationOptions extends WorkOrderTabsDetailsEvent {
  final String locationId;
  final String locationName;

  SelectWorkOrderLocationOptions(
      {required this.locationId, required this.locationName});
}

class SelectWorkOrderTypeOptions extends WorkOrderTabsDetailsEvent {
  final String typeId;
  final String typeName;

  SelectWorkOrderTypeOptions({required this.typeId, required this.typeName});
}

class WorkOrderItemTabDeleteItem extends WorkOrderTabsDetailsEvent {
  final String itemId;

  WorkOrderItemTabDeleteItem({required this.itemId});
}

class WorkOrderDeleteDocument extends WorkOrderTabsDetailsEvent {
  final String docId;

  WorkOrderDeleteDocument({required this.docId});
}

class SelectWorkOrderPriorityOptions extends WorkOrderTabsDetailsEvent {
  final String priorityId;
  final String priorityValue;

  SelectWorkOrderPriorityOptions(
      {required this.priorityId, required this.priorityValue});
}

class SelectWorkOrderCategoryOptions extends WorkOrderTabsDetailsEvent {
  final String categoryId;
  final String categoryName;

  SelectWorkOrderCategoryOptions(
      {required this.categoryId, required this.categoryName});
}

class SelectWorkOrderOriginationOptions extends WorkOrderTabsDetailsEvent {
  final String originationId;
  final String originationName;

  SelectWorkOrderOriginationOptions(
      {required this.originationId, required this.originationName});
}

class SelectWorkOrderCostCenterOptions extends WorkOrderTabsDetailsEvent {
  final String costCenterId;
  final String costCenterValue;

  SelectWorkOrderCostCenterOptions(
      {required this.costCenterId, required this.costCenterValue});
}

class SaveSimilarAndNewWorkOrder extends WorkOrderTabsDetailsEvent {
  final Map workOrderDetailsMap;

  SaveSimilarAndNewWorkOrder({required this.workOrderDetailsMap});
}

class UpdateWorkOrderDetails extends WorkOrderTabsDetailsEvent {
  final Map updateWorkOrderDetailsMap;

  UpdateWorkOrderDetails({required this.updateWorkOrderDetailsMap});
}

class SelectSafetyMeasureOptions extends WorkOrderTabsDetailsEvent {
  final String safetyMeasureId;
  final List safetyMeasureIdList;
  final List safetyMeasureNameList;
  final String safetyMeasureName;

  SelectSafetyMeasureOptions(
      {required this.safetyMeasureName,
      required this.safetyMeasureNameList,
      required this.safetyMeasureId,
      required this.safetyMeasureIdList});
}

class SelectSpecialWorkOptions extends WorkOrderTabsDetailsEvent {
  final bool isChecked;

  SelectSpecialWorkOptions({required this.isChecked});
}

class ManageWorkOrderDownTime extends WorkOrderTabsDetailsEvent {
  final Map manageDownTimeMap;

  ManageWorkOrderDownTime({required this.manageDownTimeMap});
}

class WorkOrderSelectVendorOption extends WorkOrderTabsDetailsEvent {
  final String vendorName;

  WorkOrderSelectVendorOption({required this.vendorName});
}

class WorkOrderSelectCurrencyOption extends WorkOrderTabsDetailsEvent {
  final String currencyName;

  WorkOrderSelectCurrencyOption({required this.currencyName});
}

class ManageWorkOrderMiscCost extends WorkOrderTabsDetailsEvent {
  final Map manageMisCostMap;

  ManageWorkOrderMiscCost({required this.manageMisCostMap});
}

class AcceptWorkOrder extends WorkOrderTabsDetailsEvent {
  final String workOrderId;

  AcceptWorkOrder({required this.workOrderId});
}

class HoldWorkOrder extends WorkOrderTabsDetailsEvent {
  final String workOrderId;

  HoldWorkOrder({required this.workOrderId});
}

class FetchWorkOrderSingleDownTime extends WorkOrderTabsDetailsEvent {
  final String downTimeId;

  FetchWorkOrderSingleDownTime({required this.downTimeId});
}

class FetchAssignWorkForceList extends WorkOrderTabsDetailsEvent {
  final int pageNo;
  final String workOrderWorkforceName;
  final String workOrderId;

  FetchAssignWorkForceList(
      {required this.pageNo,
      required this.workOrderWorkforceName,
      required this.workOrderId});
}

class FetchAssignPartsList extends WorkOrderTabsDetailsEvent {
  final int pageNo;
  final String workOrderId;
  final String partName;

  FetchAssignPartsList(
      {required this.pageNo,
      required this.partName,
      required this.workOrderId});
}

class RejectWorkOrder extends WorkOrderTabsDetailsEvent {
  final String workOrderId;

  RejectWorkOrder({required this.workOrderId});
}

class StartWorkOrder extends WorkOrderTabsDetailsEvent {
  final Map startWorkOrderMap;

  StartWorkOrder({required this.startWorkOrderMap});
}

class SearchWorkOrderParts extends WorkOrderTabsDetailsEvent {
  final bool isSearched;

  SearchWorkOrderParts({required this.isSearched});
}

class SearchWorkOrderWorkforce extends WorkOrderTabsDetailsEvent {
  final bool isWorkforceSearched;

  SearchWorkOrderWorkforce({required this.isWorkforceSearched});
}

class FetchWorkOrderDocuments extends WorkOrderTabsDetailsEvent {}

class SelectWorkOrderDocument extends WorkOrderTabsDetailsEvent {
  final FetchWorkOrderDocumentsModel fetchWorkOrderDocumentsModel;
  final List documentList;
  final String docId;

  SelectWorkOrderDocument(
      {required this.fetchWorkOrderDocumentsModel,
      required this.docId,
      required this.documentList});
}

class SelectWorkOrderDocumentType extends WorkOrderTabsDetailsEvent {
  final String docTypeId;
  final String docTypeName;

  SelectWorkOrderDocumentType(
      {required this.docTypeId, required this.docTypeName});
}

class SelectWorkOrderDocumentStatusOption extends WorkOrderTabsDetailsEvent {
  final String statusId;
  final String statusOption;

  SelectWorkOrderDocumentStatusOption(
      {required this.statusId, required this.statusOption});
}

class ApplyWorkOrderDocumentFilter extends WorkOrderTabsDetailsEvent {}

class ClearWorkOrderDocumentFilter extends WorkOrderTabsDetailsEvent {
  ClearWorkOrderDocumentFilter();
}

class FetchWorkOrderSingleMiscCost extends WorkOrderTabsDetailsEvent {}

class AssignWorkForce extends WorkOrderTabsDetailsEvent {
  final Map assignWorkOrderMap;
  final String showWarningCount;

  AssignWorkForce(
      {required this.showWarningCount, required this.assignWorkOrderMap});
}

class DeleteWorkOrderSingleMiscCost extends WorkOrderTabsDetailsEvent {}

class SaveWorkOrderComments extends WorkOrderTabsDetailsEvent {
  final Map addCommentsMap;

  SaveWorkOrderComments({required this.addCommentsMap});
}

class EditWorkOrderWorkForce extends WorkOrderTabsDetailsEvent {
  final Map editWorkOrderWorkForceMap;

  EditWorkOrderWorkForce({required this.editWorkOrderWorkForceMap});
}

class SaveWorkOrderDocuments extends WorkOrderTabsDetailsEvent {}

class DeleteWorkOrderWorkForce extends WorkOrderTabsDetailsEvent {
  final String workForceId;

  DeleteWorkOrderWorkForce({required this.workForceId});
}

class AssignWorkOrderParts extends WorkOrderTabsDetailsEvent {
  final Map assignPartMap;

  AssignWorkOrderParts({required this.assignPartMap});
}

class CompleteWorkOrder extends WorkOrderTabsDetailsEvent {
  final Map completeWorkOrderMap;

  CompleteWorkOrder({required this.completeWorkOrderMap});
}

class UpdateWorkOrderItem extends WorkOrderTabsDetailsEvent {
  final Map workOrderItemMap;

  UpdateWorkOrderItem({required this.workOrderItemMap});
}
