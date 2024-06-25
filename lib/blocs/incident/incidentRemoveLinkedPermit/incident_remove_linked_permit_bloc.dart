import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/repositories/incident/incident_repository.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../di/app_module.dart';
import '../../../data/cache/cache_keys.dart';
import '../../../data/models/incident/incident_unlink_permit_model.dart';
import 'incident_remove_linked_permit_event.dart';
import 'incident_remove_linked_permit_states.dart';

class IncidentRemoveLinkedPermitBloc extends Bloc<
    IncidentRemoveLinkedPermitEvent, IncidentRemoveLinkedPermitStates> {
  final IncidentRepository _incidentRepository = getIt<IncidentRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  IncidentRemoveLinkedPermitStates get initialState =>
      IncidentRemoveLinkedPermitInitial();

  IncidentRemoveLinkedPermitBloc()
      : super(IncidentRemoveLinkedPermitInitial()) {
    on<IncidentRemoveLinkedPermitEvent>(_removeLinkedPermit);
  }

  FutureOr<void> _removeLinkedPermit(IncidentRemoveLinkedPermitEvent event,
      Emitter<IncidentRemoveLinkedPermitStates> emit) async {
    emit(IncidentRemoveLinkedPermitLoading());
    try {
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      final Map removeLinkedPermitMap = {
        "userid": userId,
        "id": event.permitId,
        "hashcode": hashCode
      };
      IncidentUnlinkPermitModel incidentUnlinkPermitModel =
          await _incidentRepository.removeLinkedPermit(removeLinkedPermitMap);
      emit(IncidentLinkedPermitRemoved(
          incidentUnlinkPermitModel: incidentUnlinkPermitModel));
    } catch (e) {
      emit(IncidentLinkedPermitNotRemoved(unableToUnlinkPermit: e.toString()));
    }
  }
}
