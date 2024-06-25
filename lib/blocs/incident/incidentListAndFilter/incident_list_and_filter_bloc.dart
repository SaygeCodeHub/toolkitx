import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../data/cache/customer_cache.dart';
import '../../../../di/app_module.dart';
import '../../../data/cache/cache_keys.dart';
import '../../../data/models/incident/fetch_incidents_list_model.dart';
import '../../../data/models/incident/incident_fetch_roles_model.dart';
import '../../../repositories/incident/incident_repository.dart';
import '../../../utils/database_utils.dart';
import 'incident_list_and_filter_event.dart';
import 'incident_list_and_filter_state.dart';

class IncidentLisAndFilterBloc
    extends Bloc<IncidentListAndFilterEvent, IncidentListAndFilterStates> {
  final IncidentRepository _incidentRepository = getIt<IncidentRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  Map filters = {};
  String roleId = '';

  IncidentListAndFilterStates get initialState => FetchIncidentsInitial();

  IncidentLisAndFilterBloc() : super(FetchIncidentsInitial()) {
    on<FetchIncidentListEvent>(_fetchIncidents);
    on<ApplyIncidentFilter>(_fetchFilterData);
    on<ClearIncidentFilters>(_clearFilters);
    on<IncidentFetchRoles>(_incidentFetchRoles);
    on<IncidentChangeRole>(_incidentChangeRole);
  }

  _fetchFilterData(
      ApplyIncidentFilter event, Emitter<IncidentListAndFilterStates> emit) {
    filters = event.incidentFilterMap;
  }

  FutureOr<void> _clearFilters(ClearIncidentFilters event,
      Emitter<IncidentListAndFilterStates> emit) async {
    filters = {};
  }

  FutureOr<void> _fetchIncidents(FetchIncidentListEvent event,
      Emitter<IncidentListAndFilterStates> emit) async {
    emit(FetchingIncidents());
    try {
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      if (event.isFromHome == true) {
        add(const ClearIncidentFilters());
        roleId = '';
        FetchIncidentsListModel fetchIncidentsListModel =
            await _incidentRepository.fetchIncidents(
                userId, hashCode, '', '', event.page);
        emit(IncidentsFetched(
            fetchIncidentsListModel: fetchIncidentsListModel,
            filterMap: const {}));
      } else {
        FetchIncidentsListModel fetchIncidentsListModel =
            await _incidentRepository.fetchIncidents(userId, hashCode,
                jsonEncode(filters), roleId, event.page); // add role id here.
        emit(IncidentsFetched(
            fetchIncidentsListModel: fetchIncidentsListModel,
            filterMap: filters));
      }
    } catch (e) {
      emit(IncidentsNotFetched(
          noIncidentsMessage: DatabaseUtil.getText('something_went_wrong')));
    }
  }

  FutureOr<void> _incidentFetchRoles(IncidentFetchRoles event,
      Emitter<IncidentListAndFilterStates> emit) async {
    emit(FetchingIncidentRoles());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      IncidentFetchRolesModel incidentFetchRolesModel =
          await _incidentRepository.fetchIncidentRole(hashCode, userId);
      if (roleId == '') {
        roleId = incidentFetchRolesModel.data![0].groupId;
      }
      emit(IncidentRolesFetched(
          roleId: roleId, incidentFetchRolesModel: incidentFetchRolesModel));
    } catch (e) {
      emit(IncidentRolesNotFetched());
    }
  }

  _incidentChangeRole(
      IncidentChangeRole event, Emitter<IncidentListAndFilterStates> emit) {
    roleId = event.roleId;
    emit(IncidentRoleChanged(roleId: roleId));
  }
}
