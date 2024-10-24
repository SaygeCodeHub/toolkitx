import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workorder_events.dart';
import 'package:toolkit/blocs/workorder/workorder_states.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/data/models/workorder/offline/fetch_offline_workorder_data_model.dart';
import 'package:toolkit/repositories/workorder/workorder_reposiotry.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/global.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../di/app_module.dart';
import '../../data/models/workorder/fetch_workorder_master_model.dart';
import '../../data/models/workorder/fetch_workorders_model.dart';
import '../../utils/database/database_util.dart';

class WorkOrderBloc extends Bloc<WorkOrderEvents, WorkOrderStates> {
  final WorkOrderRepository _workOrderRepository = getIt<WorkOrderRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  final DatabaseHelper _databaseHelper = getIt<DatabaseHelper>();

  WorkOrderStates get initialState => WorkOrderInitial();
  final List<WorkOrderDatum> data = [];
  bool hasReachedMax = false;
  String workOrderId = '';
  Map filtersMap = {};
  List<List<WorkOrderMasterDatum>> workOrderMasterDatum = [];
  String roleId = '';

  WorkOrderBloc() : super(WorkOrderInitial()) {
    on<FetchWorkOrders>(_fetchWorkOrders);
    on<FetchWorkOrderMaster>(_fetchMaster);
    on<SelectWorkOrderTypeFilter>(_selectFilterType);
    on<SelectWorkOrderStatusFilter>(_selectFilterStatus);
    on<WorkOrderApplyFilter>(_applyFilter);
    on<WorkOrderClearFilter>(_clearFilter);
    on<FetchWorkOrderOfflineData>(_fetchWorkOrderOfflineData);
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
    if (isNetworkEstablished) {
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
    } else {
      data.clear();
      final List fetchAllWorkOrders = [];
      final fetchAllWorkOrdersFromDb =
          await _databaseHelper.fetchAllWorkOrders();
      for (var list in fetchAllWorkOrdersFromDb) {
        var listPageJson = jsonDecode(list['listPage']);
        listPageJson['actionCount'] = list['actionCount'];
        fetchAllWorkOrders.add(listPageJson);
      }
      if (fetchAllWorkOrders.isNotEmpty) {
        FetchWorkOrdersModel fetchWorkOrdersModel =
            FetchWorkOrdersModel.fromJson(
                {'Status': 200, 'Message': '', 'Data': fetchAllWorkOrders});
        data.addAll(fetchWorkOrdersModel.data);
        hasReachedMax = true;
        emit(WorkOrdersFetched(
            fetchWorkOrdersModel: fetchWorkOrdersModel, filterMap: {}));
      } else {
        emit(WorkOrdersNotFetched(
            listNotFetched: StringConstants.kSomethingWentWrong));
      }
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

  FutureOr<void> _fetchWorkOrderOfflineData(
      FetchWorkOrderOfflineData event, Emitter<WorkOrderStates> emit) async {
    emit(FetchingWorkOrderOfflineData());
    try {
      await _databaseHelper.truncateOfflineWorkOrderTables();
      FetchOfflineWorkOrderDataModel fetchOfflineWorkOrderDataModel =
          await _workOrderRepository.fetchWorkOrderOfflineData(
              await _customerCache.getHashCode(CacheKeys.hashcode) ?? '',
              roleId);
      if (fetchOfflineWorkOrderDataModel.status == 200) {
        if (fetchOfflineWorkOrderDataModel.data.isNotEmpty) {
          for (var item in fetchOfflineWorkOrderDataModel.data) {
            await _databaseHelper.insertOfflineWorkOrders(
                item, item.listpage.statusid);
          }
          emit(WorkOrderOfflineDataFetched());
        } else {
          emit(WorkOrderOfflineDataNotFetched(
              errorMessage: StringConstants.kNoDataFound));
        }
      } else {
        emit(WorkOrderOfflineDataNotFetched(
            errorMessage: StringConstants.kSomethingWentWrong));
      }
    } catch (e) {
      rethrow;
    }
  }
}
