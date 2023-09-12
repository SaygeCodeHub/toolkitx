import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/repositories/workorder/workorder_reposiotry.dart';
import '../../../../../data/cache/customer_cache.dart';
import '../../../../di/app_module.dart';
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
}
