import '../../../data/models/workorder/delete_document_model.dart';
import '../../../data/models/workorder/delete_item_tab_item_model.dart';
import '../../../data/models/workorder/fetch_workorder_details_model.dart';
import '../../../data/models/workorder/save_new_and_similar_workorder_model.dart';

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
