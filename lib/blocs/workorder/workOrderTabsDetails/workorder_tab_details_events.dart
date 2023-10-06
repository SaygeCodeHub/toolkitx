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
  final String specialWorkId;
  final String specialWorkName;
  final List specialWorkIdList;
  final List specialWorkNameList;

  SelectSpecialWorkOptions(
      {required this.specialWorkId,
      required this.specialWorkName,
      required this.specialWorkIdList,
      required this.specialWorkNameList});
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

  FetchAssignWorkForceList({required this.pageNo});
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

class SearchParts extends WorkOrderTabsDetailsEvent {
  final bool isSearched;

  SearchParts({required this.isSearched});
}

class FetchWorkOrderDocuments extends WorkOrderTabsDetailsEvent {
  FetchWorkOrderDocuments();
}

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

class ApplyWorkOrderDocumentFilter extends WorkOrderTabsDetailsEvent {
  ApplyWorkOrderDocumentFilter();
}

class ClearWorkOrderDocumentFilter extends WorkOrderTabsDetailsEvent {
  ClearWorkOrderDocumentFilter();
}
