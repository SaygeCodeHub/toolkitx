import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/cache/cache_keys.dart';
import '../../../data/cache/customer_cache.dart';
import '../../../data/models/incident/incident_injury_master.dart';
import '../../../data/models/incident/save_injured_person_model.dart';
import '../../../di/app_module.dart';
import '../../../repositories/incident/incident_repository.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import 'incident_injury_details_event.dart';
import 'incident_injury_details_states.dart';

class InjuryDetailsBloc extends Bloc<InjuryDetailsEvent, InjuryDetailsStates> {
  final IncidentRepository _incidentRepository = getIt<IncidentRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  InjuryDetailsStates get initialState => const InjuryDetailsInitial();

  InjuryDetailsBloc() : super(const InjuryDetailsInitial()) {
    on<InjuryMaster>(_getInjuryMaster);
    on<SelectInjuryNature>(_selectInjuryNature);
    on<SaveInjuredPerson>(_saveInjuredPerson);
    on<CancelAddInjuredPerson>(_cancelAddInjuredPerson);
  }

  _cancelAddInjuredPerson(
      CancelAddInjuredPerson event, Emitter<InjuryDetailsStates> emit) {
    emit(const InjuryDetailsInitial());
  }

  FutureOr _getInjuryMaster(
      InjuryMaster event, Emitter<InjuryDetailsStates> emit) async {
    try {
      emit(const FetchingInjuryMaster());
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      IncidentInjuryMasterModel incidentInjuryMasterModel =
          await _incidentRepository.fetchInjuryMaster(hashCode.toString());
      if (incidentInjuryMasterModel.status == 200) {
        emit(InjuryMasterFetched(incidentInjuryMasterModel));
        add(const SelectInjuryNature([], [], null, [], ''));
      } else {
        emit(const FetchInjuryMasterError());
      }
    } catch (e) {
      emit(const FetchInjuryMasterError());
    }
  }

  FutureOr _saveInjuredPerson(
      SaveInjuredPerson event, Emitter<InjuryDetailsStates> emit) async {
    try {
      emit(const SavingInjuryPerson());
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map injuredPersonMap = {
        "userid": userId,
        "incidentid": event.injuryDetailsMap['incidentId'],
        "name": event.injuryDetailsMap['name'],
        "company": (event.injuryDetailsMap['company'] == null)
            ? ''
            : event.injuryDetailsMap['company'],
        "hashcode": hashCode,
        "injury": event.injuryDetailsMap['injury'],
        "bodypart": event.injuryDetailsMap['bodypart']
      };
      if (event.injuryDetailsMap['name'] == '' ||
          event.injuryDetailsMap['name'] == null) {
        emit(const ErrorSavingInjuredPerson(StringConstants.kNameValidation));
      } else {
        SaveInjuredPersonModel saveInjuredPersonModel =
            await _incidentRepository.saveInjuredPerson(injuredPersonMap);
        if (saveInjuredPersonModel.message == '1') {
          emit(SavedInjuredPerson(saveInjuredPersonModel));
        } else {
          emit(ErrorSavingInjuredPerson(
              DatabaseUtil.getText('UnknownErrorMessage')));
        }
      }
    } catch (e) {
      emit(ErrorSavingInjuredPerson(e.toString()));
    }
  }

  _selectInjuryNature(
      SelectInjuryNature event, Emitter<InjuryDetailsStates> emit) {
    List changedInjuryId = List.from(event.selectedInjuryId);
    List changedInjuryNature = List.from(event.selectedInjuryNature);
    List changedArea = List.from(event.selectedAreaList);
    if (event.selectedArea != '') {
      if (event.selectedAreaList.contains(event.selectedArea) != true) {
        changedArea.add(event.selectedArea);
      } else {
        changedArea.remove(event.selectedArea);
      }
    }
    if (event.selectDatum != null) {
      if (event.selectedInjuryId.contains(event.selectDatum!.id) != true) {
        changedInjuryId.add(event.selectDatum!.id);
        changedInjuryNature.add(event.selectDatum!.name);
      } else {
        changedInjuryId.remove(event.selectDatum!.id);
        changedInjuryNature.remove(event.selectDatum!.name);
      }
    }
    emit(InjuryNatureSelected(
        changedInjuryId, changedInjuryNature, changedArea));
  }
}
