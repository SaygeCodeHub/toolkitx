import '../../../data/models/workorder/delete_document_model.dart';
import '../../../data/models/workorder/delete_item_tab_item_model.dart';
import '../../../data/models/workorder/fetch_workorder_details_model.dart';

abstract class WorkOrderTabDetailsStates {}

class WorkOrderTabDetailsInitial extends WorkOrderTabDetailsStates {}

class FetchingWorkOrderTabDetails extends WorkOrderTabDetailsStates {}

class WorkOrderTabDetailsFetched extends WorkOrderTabDetailsStates {
  final FetchWorkOrderTabDetailsModel fetchWorkOrderDetailsModel;
  final int tabInitialIndex;
  final String? clientId;

  WorkOrderTabDetailsFetched({this.clientId = '',
      required this.tabInitialIndex,
      required this.fetchWorkOrderDetailsModel});
}

class WorkOrderTabDetailsNotFetched extends WorkOrderTabDetailsStates {
  final String tabDetailsNotFetched;

  WorkOrderTabDetailsNotFetched({required this.tabDetailsNotFetched});
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
