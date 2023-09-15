import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/repositories/workorder/workorder_reposiotry.dart';
import 'package:toolkit/utils/database_utils.dart';
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
    on<SelectWorkOrderCompanyOptions>(_selectCompanyOptions);
    on<SelectWorkOrderLocationOptions>(_selectLocationOptions);
    on<SelectWorkOrderTypeOptions>(_selectTypeOptions);
  }

  int tabIndex = 0;
  int toggleSwitchIndex = 0;
  String clientId = '';
  static List popUpMenuItemsList = [];
  Map workOrderDetailsMap = {};

  FutureOr _fetchWorkOrderDetails(
      WorkOrderDetails event, Emitter<WorkOrderTabDetailsStates> emit) async {
    emit(FetchingWorkOrderTabDetails());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? getClientId =
          await _customerCache.getClientId(CacheKeys.clientId);
      clientId = getClientId!;
      popUpMenuItemsList = [
        DatabaseUtil.getText('Edit'),
        DatabaseUtil.getText('CreateSimillar'),
        DatabaseUtil.getText('AddParts'),
        DatabaseUtil.getText('AddDocuments'),
        DatabaseUtil.getText('AddMiscCost'),
        DatabaseUtil.getText('AddMiscCost'),
        DatabaseUtil.getText('AddDowntime'),
        DatabaseUtil.getText('AddComment'),
        DatabaseUtil.getText('ShowRouts')
      ];
      FetchWorkOrderTabDetailsModel fetchWorkOrderDetailsModel =
          await _workOrderRepository.fetchWorkOrderDetails(
              hashCode!, event.workOrderId);
      tabIndex = event.initialTabIndex;
      if (fetchWorkOrderDetailsModel.data.isassignedwf == '1') {
        popUpMenuItemsList.insert(2, DatabaseUtil.getText('assign_workforce'));
      }
      if (fetchWorkOrderDetailsModel.data.isstarttender == '1') {
        popUpMenuItemsList.insert(7, DatabaseUtil.getText('StartTender'));
      }
      workOrderDetailsMap = {
        'companyid': fetchWorkOrderDetailsModel.data.contractorname,
        'locationid': fetchWorkOrderDetailsModel.data.locationid,
        'locationnames': fetchWorkOrderDetailsModel.data.locationnames,
        'contractorname': fetchWorkOrderDetailsModel.data.contractorname,
        'type': fetchWorkOrderDetailsModel.data.type,
        'workordertype': fetchWorkOrderDetailsModel.data.workordertype,
      };
      emit(WorkOrderTabDetailsFetched(
          fetchWorkOrderDetailsModel: fetchWorkOrderDetailsModel,
          tabInitialIndex: tabIndex,
          clientId: clientId,
          popUpMenuList: popUpMenuItemsList,
          workOrderDetailsMap: workOrderDetailsMap));
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
        clientId: clientId,
        popUpMenuList: popUpMenuItemsList,
        workOrderDetailsMap: workOrderDetailsMap));
  }

  _selectCompanyOptions(SelectWorkOrderCompanyOptions event,
      Emitter<WorkOrderTabDetailsStates> emit) {
    emit(WorkOrderCompanyOptionSelected(
        companyId: event.companyId, companyName: event.companyName));
  }

  _selectLocationOptions(SelectWorkOrderLocationOptions event,
      Emitter<WorkOrderTabDetailsStates> emit) {
    emit(WorkOrderLocationOptionSelected(
        locationId: event.locationId, locationName: event.locationName));
  }

  _selectTypeOptions(SelectWorkOrderTypeOptions event,
      Emitter<WorkOrderTabDetailsStates> emit) {
    emit(WorkOrderTypeOptionSelected(
        typeId: event.typeId, typeName: event.typeName));
  }
}
