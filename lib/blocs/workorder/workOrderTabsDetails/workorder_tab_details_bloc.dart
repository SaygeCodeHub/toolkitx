import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/repositories/workorder/workorder_reposiotry.dart';
import '../../../../../data/cache/customer_cache.dart';
import '../../../../di/app_module.dart';
import '../../../data/models/workorder/delete_document_model.dart';
import '../../../data/models/workorder/delete_item_tab_item_model.dart';
import '../../../data/models/workorder/fetch_workorder_details_model.dart';
import 'workorder_tab_details_events.dart';
import 'workorder_tab_details_states.dart';

class WorkOrderTabDetailsBloc
    extends Bloc<WorkOrderTabsDetailsEvent, WorkOrderTabDetailsStates> {
  final WorkOrderRepository _workOrderRepository = getIt<WorkOrderRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  WorkOrderTabDetailsStates get initialState => WorkOrderTabDetailsInitial();

  WorkOrderTabDetailsBloc() : super(WorkOrderTabDetailsInitial()) {
    on<WorkOrderDetails>(_fetchWorkOrderDetails);
    on<WorkOrderToggleSwitchIndex>(_toggleSwitchIndexChanged);
    on<WorkOrderItemTabDeleteItem>(_deleteItemTabItem);
    on<WorkOrderDeleteDocument>(_deleteDocument);
  }

  int tabIndex = 0;
  int toggleSwitchIndex = 0;
  String clientId = '';

  FutureOr _fetchWorkOrderDetails(
      WorkOrderDetails event, Emitter<WorkOrderTabDetailsStates> emit) async {
    emit(FetchingWorkOrderTabDetails());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? getClientId =
          await _customerCache.getClientId(CacheKeys.clientId);
      clientId = getClientId!;
      FetchWorkOrderTabDetailsModel fetchWorkOrderDetailsModel =
          await _workOrderRepository.fetchWorkOrderDetails(
              hashCode!, event.workOrderId);
      tabIndex = event.initialTabIndex;
      emit(WorkOrderTabDetailsFetched(
          fetchWorkOrderDetailsModel: fetchWorkOrderDetailsModel,
          tabInitialIndex: tabIndex,
          clientId: clientId));
      add(WorkOrderToggleSwitchIndex(
          fetchWorkOrderDetailsModel: fetchWorkOrderDetailsModel,
          tabInitialIndex: tabIndex,
          toggleIndex: 0));
    } catch (e) {
      emit(WorkOrderTabDetailsNotFetched(tabDetailsNotFetched: e.toString()));
    }
  }

  _toggleSwitchIndexChanged(WorkOrderToggleSwitchIndex event,
      Emitter<WorkOrderTabDetailsStates> emit) {
    toggleSwitchIndex = event.toggleIndex;
    emit(WorkOrderTabDetailsFetched(
        tabInitialIndex: event.tabInitialIndex,
        fetchWorkOrderDetailsModel: event.fetchWorkOrderDetailsModel,
        clientId: clientId));
  }

  FutureOr _deleteItemTabItem(WorkOrderItemTabDeleteItem event,
      Emitter<WorkOrderTabDetailsStates> emit) async {
    emit(DeletingItemTabItem());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map deleteItemTabItemMap = {
        'woitemid': event.itemId,
        'userid': userId,
        'hashcode': hashCode
      };
      DeleteItemTabItemModel deleteItemTabItemModel =
          await _workOrderRepository.deleteItemTabItem(deleteItemTabItemMap);
      if (deleteItemTabItemModel.status == 200) {
        emit(
            ItemTabItemDeleted(deleteItemTabItemModel: deleteItemTabItemModel));
      } else {
        emit(ItemTabItemNotDeleted(
            cannotDeleteItem: deleteItemTabItemModel.message));
      }
    } catch (e) {
      emit(ItemTabItemNotDeleted(cannotDeleteItem: e.toString()));
    }
  }

  FutureOr _deleteDocument(WorkOrderDeleteDocument event,
      Emitter<WorkOrderTabDetailsStates> emit) async {
    emit(DeletingDocument());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map deleteDocumentMap = {
        'wodocid': event.docId,
        'userid': userId,
        'hashcode': hashCode
      };
      DeleteDocumentModel deleteDocumentModel =
          await _workOrderRepository.deleteDocument(deleteDocumentMap);
      if (deleteDocumentModel.status == 200) {
        emit(DocumentDeleted(deleteDocumentModel: deleteDocumentModel));
      } else {
        emit(DocumentNotDeleted(
            documentNotDeleted: deleteDocumentModel.message));
      }
    } catch (e) {
      emit(DocumentNotDeleted(documentNotDeleted: e.toString()));
    }
  }
}
