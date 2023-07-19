import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../di/app_module.dart';
import '../../../data/cache/cache_keys.dart';
import '../../../data/models/incident/edit_incident_details_model.dart';
import '../../../data/models/incident/save_report_new_incident_photos_model.dart';
import '../../../repositories/incident/incident_repository.dart';
import '../../../utils/database_utils.dart';
import 'edit_incident_details_events.dart';
import 'edit_incident_details_states.dart';

class EditIncidentDetailsBloc
    extends Bloc<EditIncidentDetailsEvent, EditIncidentDetailsStates> {
  final IncidentRepository _incidentRepository = getIt<IncidentRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  Map editIncidentDetailsMap = {};

  EditIncidentDetailsStates get initialState => EditIncidentDetailsInitial();

  EditIncidentDetailsBloc() : super(EditIncidentDetailsInitial()) {
    on<EditIncidentDetails>(_editIncidentDetails);
    on<SaveEditIncidentDetailsPhotos>(_saveIncidentPhotos);
  }

  FutureOr<void> _editIncidentDetails(EditIncidentDetails event,
      Emitter<EditIncidentDetailsStates> emit) async {
    emit(EditingIncidentDetails());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      editIncidentDetailsMap = event.editIncidentMap;
      Map editIncidentDetails = {
        "description": editIncidentDetailsMap['description'],
        "responsible_person": editIncidentDetailsMap['responsible_person'],
        "site_name": editIncidentDetailsMap['site_name'],
        "location_name": editIncidentDetailsMap['location_name'],
        "category": editIncidentDetailsMap['category'],
        "reporteddatetime": editIncidentDetailsMap['reporteddatetime'],
        "customfields": editIncidentDetailsMap['customfields'],
        "userid": userId,
        "incidentid": editIncidentDetailsMap['incidentid'],
        "hashcode": hashCode
      };
      EditIncidentDetailsModel editIncidentDetailsModel =
          await _incidentRepository.editIncidentDetails(editIncidentDetails);
      (editIncidentDetailsMap['filenames'] != null)
          ? add(SaveEditIncidentDetailsPhotos(
              editIncidentDetailsMap: editIncidentDetailsMap))
          : null;
      emit(IncidentDetailsEdited(
          editIncidentDetailsModel: editIncidentDetailsModel));
    } catch (e) {
      emit(IncidentDetailsNotEdited(
          incidentNotEdited:
              DatabaseUtil.getText('some_unknown_error_please_try_again')));
    }
  }

  FutureOr<void> _saveIncidentPhotos(SaveEditIncidentDetailsPhotos event,
      Emitter<EditIncidentDetailsStates> emit) async {
    try {
      editIncidentDetailsMap = event.editIncidentDetailsMap;
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map saveIncidentPhotosMap = {
        "userid": userId,
        "incidentid": editIncidentDetailsMap['incidentid'],
        "commentid": "",
        "filenames": editIncidentDetailsMap['filenames'],
        "hashcode": hashCode
      };
      SaveReportNewIncidentPhotosModel saveReportNewIncidentPhotosModel =
          await _incidentRepository.saveIncidentPhotos(saveIncidentPhotosMap);
      emit(EditIncidentDetailsPhotoSaved(
          saveReportNewIncidentPhotosModel: saveReportNewIncidentPhotosModel));
    } catch (e) {
      emit(IncidentDetailsNotEdited(incidentNotEdited: e.toString()));
    }
  }
}
