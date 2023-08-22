import 'dart:async';

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

  WorkOrderBloc() : super(WorkOrderInitial()) {
    on<FetchWorkOrders>(_fetchWorkOrders);
    on<FetchWorkOrderMaster>(_fetchMaster);
  }

  FutureOr _fetchWorkOrders(
      FetchWorkOrders event, Emitter<WorkOrderStates> emit) async {
    emit(FetchingWorkOrders());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchWorkOrdersModel fetchWorkOrdersModel = await _workOrderRepository
          .fetchWorkOrders(event.pageNo, hashCode!, '{}');
      data.addAll(fetchWorkOrdersModel.data);
      emit(WorkOrdersFetched(
          fetchWorkOrdersModel: fetchWorkOrdersModel,
          data: data,
          hasReachedMax: hasReachedMax));
    } catch (e) {
      emit(WorkOrdersNotFetched(listNotFetched: e.toString()));
    }
  }

  FutureOr _fetchMaster(
      FetchWorkOrderMaster event, Emitter<WorkOrderStates> emit) async {
    emit(FetchingWorkOrderMaster());
    // try {
    String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
    String? userId = await _customerCache.getUserId(CacheKeys.userId);
    FetchWorkOrdersMasterModel fetchWorkOrdersMasterModel =
        await _workOrderRepository.fetchWorkOrderMaster(hashCode!, userId!);
    emit(WorkOrderMasterFetched(
        fetchWorkOrdersMasterModel: fetchWorkOrdersMasterModel));
    // } catch (e) {
    //   emit(WorkOrderMasterNotFetched(masterNotFetched: e.toString()));
    // }
  }
}
