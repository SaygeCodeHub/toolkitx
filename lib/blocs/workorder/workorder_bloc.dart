import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workorder_events.dart';
import 'package:toolkit/blocs/workorder/workorder_states.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/repositories/workorder/workorder_reposiotry.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../di/app_module.dart';
import '../../data/models/workorder/fetch_workorders_model.dart';

class WorkOrderBloc extends Bloc<WorkOrderEvents, WorkOrderStates> {
  final WorkOrderRepository _workOrderRepository = getIt<WorkOrderRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  WorkOrderStates get initialState => WorkOrderInitial();
  final List<WorkOrderDatum> data = [];
  bool hasReachedMax = false;

  WorkOrderBloc() : super(WorkOrderInitial()) {
    on<FetchWorkOrders>(_fetchWorkOrders);
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
}
