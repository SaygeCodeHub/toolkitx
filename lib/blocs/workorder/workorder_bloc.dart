import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workorder_events.dart';
import 'package:toolkit/blocs/workorder/workorder_states.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/repositories/workorder/workorder_reposiotry.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../di/app_module.dart';
import '../../data/models/workorder/fetch_workorder_master_model.dart';
import '../../data/models/workorder/fetch_workorders_model.dart';

class WorkOrderBloc extends Bloc<WorkOrderEvents, WorkOrderStates> {
  final WorkOrderRepository _workOrderRepository = getIt<WorkOrderRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  WorkOrderStates get initialState => WorkOrderInitial();
  final List<WorkOrderDatum> data = [];
  bool hasReachedMax = false;
  String workOrderId = '';
  Map filtersMap = {};
  List<List<WorkOrderMasterDatum>> workOrderMasterDatum = [];

  WorkOrderBloc() : super(WorkOrderInitial()) {
    on<FetchWorkOrders>(_fetchWorkOrders);
    on<FetchWorkOrderMaster>(_fetchMaster);
    on<SelectWorkOrderTypeFilter>(_selectFilterType);
    on<SelectWorkOrderStatusFilter>(_selectFilterStatus);
    on<WorkOrderApplyFilter>(_applyFilter);
    on<WorkOrderClearFilter>(_clearFilter);
  }

  _applyFilter(WorkOrderApplyFilter event, Emitter<WorkOrderStates> emit) {
    filtersMap = {
      "status": event.workOrderFilterMap['status'] ?? '',
      "type": event.workOrderFilterMap['type'] ?? '',
      "st": event.workOrderFilterMap['st'] ?? '',
      "et": event.workOrderFilterMap['et'] ?? '',
      "kword": event.workOrderFilterMap['kword'] ?? ''
    };
  }

  _clearFilter(WorkOrderClearFilter event, Emitter<WorkOrderStates> emit) {
    filtersMap = {};
  }

  FutureOr _fetchWorkOrders(
      FetchWorkOrders event, Emitter<WorkOrderStates> emit) async {
    emit(FetchingWorkOrders());
    // try {
    String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);

    if (event.isFromHome == true) {
      add(WorkOrderClearFilter());
      FetchWorkOrdersModel fetchWorkOrdersModel = await _workOrderRepository
          .fetchWorkOrders(event.pageNo, hashCode!, '{}');
      for (int i = 0; i < fetchWorkOrdersModel.data.length; i++) {
        workOrderId = fetchWorkOrdersModel.data[i].id;
      }
      data.addAll(fetchWorkOrdersModel.data);
      hasReachedMax = fetchWorkOrdersModel.data.isEmpty;
      emit(WorkOrdersFetched(
          fetchWorkOrdersModel: fetchWorkOrdersModel, filterMap: {}));
    } else {
      FetchWorkOrdersModel fetchWorkOrdersModel = await _workOrderRepository
          .fetchWorkOrders(event.pageNo, hashCode!, jsonEncode(filtersMap));
      data.addAll(fetchWorkOrdersModel.data);
      hasReachedMax = fetchWorkOrdersModel.data.isEmpty;
      emit(WorkOrdersFetched(
          fetchWorkOrdersModel: fetchWorkOrdersModel, filterMap: filtersMap));
    }

    // } catch (e) {
    //   emit(WorkOrdersNotFetched(listNotFetched: e.toString()));
    // }
  }

  FutureOr _fetchMaster(
      FetchWorkOrderMaster event, Emitter<WorkOrderStates> emit) async {
    emit(FetchingWorkOrderMaster());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      FetchWorkOrdersMasterModel fetchWorkOrdersMasterModel =
          await _workOrderRepository.fetchWorkOrderMaster(hashCode!, userId!);
      workOrderMasterDatum = fetchWorkOrdersMasterModel.data;
      emit(WorkOrderMasterFetched(
          fetchWorkOrdersMasterModel: fetchWorkOrdersMasterModel,
          filtersMap: filtersMap));
    } catch (e) {
      emit(WorkOrderMasterNotFetched(masterNotFetched: e.toString()));
    }
  }

  _selectFilterType(
      SelectWorkOrderTypeFilter event, Emitter<WorkOrderStates> emit) {
    emit(WorkOrderTypeSelected(id: event.value));
  }

  _selectFilterStatus(
      SelectWorkOrderStatusFilter event, Emitter<WorkOrderStates> emit) {
    emit(WorkOrderStatusSelected(value: event.id));
  }
}
