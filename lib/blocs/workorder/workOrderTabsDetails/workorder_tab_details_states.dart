import 'package:toolkit/data/models/workorder/fetch_assign_parts_model.dart';

import '../../../data/models/workorder/accpeet_workorder_model.dart';
import '../../../data/models/workorder/delete_document_model.dart';
import '../../../data/models/workorder/delete_item_tab_item_model.dart';
import '../../../data/models/workorder/fetch_assign_workforce_model.dart';
import '../../../data/models/workorder/fetch_workorder_details_model.dart';
import '../../../data/models/workorder/fetch_workorder_documents_model.dart';
import '../../../data/models/workorder/fetch_workorder_misc_cost_model.dart';
import '../../../data/models/workorder/hold_workorder_model.dart';
import '../../../data/models/workorder/manage_misc_cost_model.dart';
import '../../../data/models/workorder/manage_downtime_model.dart';
import '../../../data/models/workorder/reject_workorder_model.dart';
import '../../../data/models/workorder/save_new_and_similar_workorder_model.dart';
import '../../../data/models/workorder/start_workorder_model.dart';
import '../../../data/models/workorder/update_workorder_details_model.dart';

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

class WorkOrderTypeOptionSelected extends WorkOrderTabDetailsStates {
  final String typeId;
  final String typeName;

  WorkOrderTypeOptionSelected({required this.typeId, required this.typeName});
}

class DeletingItemTabItem extends WorkOrderTabDetailsStates {}

class ItemTabItemDeleted extends WorkOrderTabDetailsStates {
  final DeleteItemTabItemModel deleteItemTabItemModel;

  ItemTabItemDeleted({required this.deleteItemTabItemModel});
}

class ItemTabItemNotDeleted extends WorkOrderTabDetailsStates {
  final String cannotDeleteItem;

  ItemTabItemNotDeleted({required this.cannotDeleteItem});
}

class DeletingDocument extends WorkOrderTabDetailsStates {}

class DocumentDeleted extends WorkOrderTabDetailsStates {
  final DeleteDocumentModel deleteDocumentModel;

  DocumentDeleted({required this.deleteDocumentModel});
}

class DocumentNotDeleted extends WorkOrderTabDetailsStates {
  final String documentNotDeleted;

  DocumentNotDeleted({required this.documentNotDeleted});
}

class WorkOrderPriorityOptionSelected extends WorkOrderTabDetailsStates {
  final String priorityId;
  final String priorityValue;

  WorkOrderPriorityOptionSelected(
      {required this.priorityValue, required this.priorityId});
}

class WorkOrderCategoryOptionSelected extends WorkOrderTabDetailsStates {
  final String categoryId;
  final String categoryName;

  WorkOrderCategoryOptionSelected(
      {required this.categoryId, required this.categoryName});
}

class WorkOrderCategoryOriginationSelected extends WorkOrderTabDetailsStates {
  final String originationId;
  final String originationName;

  WorkOrderCategoryOriginationSelected(
      {required this.originationId, required this.originationName});
}

class WorkOrderCategoryCostCenterSelected extends WorkOrderTabDetailsStates {
  final String costCenterId;
  final String costCenterValue;

  WorkOrderCategoryCostCenterSelected(
      {required this.costCenterId, required this.costCenterValue});
}

class SavingNewAndSimilarWorkOrder extends WorkOrderTabDetailsStates {}

class NewAndSimilarWorkOrderSaved extends WorkOrderTabDetailsStates {
  final SaveNewAndSimilarWorkOrderModel saveNewAndSimilarWorkOrderModel;

  NewAndSimilarWorkOrderSaved({required this.saveNewAndSimilarWorkOrderModel});
}

class NewAndSimilarWorkOrderNotSaved extends WorkOrderTabDetailsStates {
  final String workOrderNotSaved;

  NewAndSimilarWorkOrderNotSaved({required this.workOrderNotSaved});
}

class UpdatingWorkOrderDetails extends WorkOrderTabDetailsStates {}

class WorkOrderDetailsUpdated extends WorkOrderTabDetailsStates {
  final UpdateWorkOrderDetailsModel updateWorkOrderDetailsModel;

  WorkOrderDetailsUpdated({required this.updateWorkOrderDetailsModel});
}

class WorkOrderDetailsCouldNotUpdate extends WorkOrderTabDetailsStates {
  final String detailsNotFetched;

  WorkOrderDetailsCouldNotUpdate({required this.detailsNotFetched});
}

class SafetyMeasuresOptionsSelected extends WorkOrderTabDetailsStates {
  final List safetyMeasureIdList;
  final List safetyMeasureNameList;

  SafetyMeasuresOptionsSelected(
      {required this.safetyMeasureIdList, required this.safetyMeasureNameList});
}

class SpecialWorkOptionsSelected extends WorkOrderTabDetailsStates {
  final List specialWorkIdList;
  final List specialWorkNameList;

  SpecialWorkOptionsSelected(
      {required this.specialWorkIdList, required this.specialWorkNameList});
}

class AcceptingWorkOrder extends WorkOrderTabDetailsStates {}

class WorkOrderAccepted extends WorkOrderTabDetailsStates {
  final AcceptWorkOrderModel acceptWorkOrderModel;

  WorkOrderAccepted({required this.acceptWorkOrderModel});
}

class WorkOrderNotAccepted extends WorkOrderTabDetailsStates {
  final String workOrderNotAccepted;

  WorkOrderNotAccepted({required this.workOrderNotAccepted});
}

class WorkOrderVendorOptionSelected extends WorkOrderTabDetailsStates {
  final String vendorName;

  WorkOrderVendorOptionSelected({required this.vendorName});
}

class WorkOrderCurrencyOptionSelected extends WorkOrderTabDetailsStates {
  final String currencyName;

  WorkOrderCurrencyOptionSelected({required this.currencyName});
}

class ManagingWorkOrderMisCost extends WorkOrderTabDetailsStates {}

class WorkOrderMisCostManaged extends WorkOrderTabDetailsStates {
  final ManageWorkOrderMiscCostModel manageWorkOrderMiscCostModel;

  WorkOrderMisCostManaged({required this.manageWorkOrderMiscCostModel});
}

class WorkOrderMisCostCannotManage extends WorkOrderTabDetailsStates {
  final String cannotManageMiscCost;

  WorkOrderMisCostCannotManage({required this.cannotManageMiscCost});
}

class ManagingWorkOrderDownTime extends WorkOrderTabDetailsStates {}

class WorkOrderDownTimeManaged extends WorkOrderTabDetailsStates {
  final ManageWorkOrderDownTimeModel manageWorkOrderDownTimeModel;

  WorkOrderDownTimeManaged({required this.manageWorkOrderDownTimeModel});
}

class WorkOrderDownTimeCannotManage extends WorkOrderTabDetailsStates {
  final String downTimeCannotManage;

  WorkOrderDownTimeCannotManage({required this.downTimeCannotManage});
}

class FetchingWorkOrderSingleDownTime extends WorkOrderTabDetailsStates {}

class WorkOrderSingleDownTimeFetched extends WorkOrderTabDetailsStates {
  WorkOrderSingleDownTimeFetched();
}

class WorkOrderSingleDownTimeNotFetched extends WorkOrderTabDetailsStates {
  final String downTimeNotFetched;

  WorkOrderSingleDownTimeNotFetched({required this.downTimeNotFetched});
}

class WorkOrderGettingOnHold extends WorkOrderTabDetailsStates {}

class WorkOrderGotOnHold extends WorkOrderTabDetailsStates {
  final HoldWorkOrderModel holdWorkOrderModel;

  WorkOrderGotOnHold({required this.holdWorkOrderModel});
}

class WorkOrderCannotHold extends WorkOrderTabDetailsStates {
  final String workOrderCannotHold;

  WorkOrderCannotHold({required this.workOrderCannotHold});
}

class FetchingAssignWorkOrder extends WorkOrderTabDetailsStates {}

class AssignWorkOrderFetched extends WorkOrderTabDetailsStates {
  final FetchAssignWorkForceModel fetchAssignWorkForceModel;

  AssignWorkOrderFetched({required this.fetchAssignWorkForceModel});
}

class AssignWorkOrderNotFetched extends WorkOrderTabDetailsStates {
  final String workOrderNotAssigned;

  AssignWorkOrderNotFetched({required this.workOrderNotAssigned});
}

class FetchingAssignParts extends WorkOrderTabDetailsStates {}

class AssignPartsFetched extends WorkOrderTabDetailsStates {
  final FetchAssignPartsModel fetchAssignPartsModel;

  AssignPartsFetched({required this.fetchAssignPartsModel});
}

class AssignPartsNotFetched extends WorkOrderTabDetailsStates {
  final String partsNotAssigned;

  AssignPartsNotFetched({required this.partsNotAssigned});
}

class RejectingWorkOrder extends WorkOrderTabDetailsStates {}

class WorkOrderRejected extends WorkOrderTabDetailsStates {
  final RejectWorkOrderModel rejectWorkOrderModel;

  WorkOrderRejected({required this.rejectWorkOrderModel});
}

class WorkOrderNotRejected extends WorkOrderTabDetailsStates {
  final String workOrderNotRejected;

  WorkOrderNotRejected({required this.workOrderNotRejected});
}

class StartingWorkOder extends WorkOrderTabDetailsStates {}

class WorkOderStarted extends WorkOrderTabDetailsStates {
  final StartWorkOrderModel startWorkOrderModel;

  WorkOderStarted({required this.startWorkOrderModel});
}

class WorkOderNotStarted extends WorkOrderTabDetailsStates {
  final String workOrderNotStarted;

  WorkOderNotStarted({required this.workOrderNotStarted});
}

class FetchingWorkOrderDocuments extends WorkOrderTabDetailsStates {}

class WorkOrderDocumentsFetched extends WorkOrderTabDetailsStates {
  final FetchWorkOrderDocumentsModel fetchWorkOrderDocumentsModel;
  final List documentList;
  final Map filterMap;

  WorkOrderDocumentsFetched(
      {required this.filterMap,
      required this.documentList,
      required this.fetchWorkOrderDocumentsModel});
}

class WorkOrderDocumentsNotFetched extends WorkOrderTabDetailsStates {
  final String documentsNotFetched;

  WorkOrderDocumentsNotFetched({required this.documentsNotFetched});
}

class WorkOrderDocumentTypeSelected extends WorkOrderTabDetailsStates {
  final String docTypeId;
  final String docTypeName;

  WorkOrderDocumentTypeSelected(
      {required this.docTypeId, required this.docTypeName});
}

class WorkOrderDocumentStatusSelected extends WorkOrderTabDetailsStates {
  final String statusId;
  final String statusOption;

  WorkOrderDocumentStatusSelected(
      {required this.statusId, required this.statusOption});
}

class WorkOrderDocumentApplyingFilter extends WorkOrderTabDetailsStates {}

class WorkOrderDocumentFilterApplied extends WorkOrderTabDetailsStates {}

class WorkOrderDocumentDidNotFilter extends WorkOrderTabDetailsStates {}

class FetchingWorkOrderSingleMiscCost extends WorkOrderTabDetailsStates {}

class SingleWorkOrderMiscCostFetched extends WorkOrderTabDetailsStates {
  final FetchWorkOrderSingleMiscCostModel fetchWorkOrderSingleMiscCostModel;

  SingleWorkOrderMiscCostFetched(
      {required this.fetchWorkOrderSingleMiscCostModel});
}

class SingleWorkOrderMiscCostNotFetched extends WorkOrderTabDetailsStates {
  final String miscCostNotFetched;

  SingleWorkOrderMiscCostNotFetched({required this.miscCostNotFetched});
}
