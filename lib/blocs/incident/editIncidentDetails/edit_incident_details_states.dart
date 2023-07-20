import '../../../data/models/incident/edit_incident_details_model.dart';
import '../../../data/models/incident/save_report_new_incident_photos_model.dart';

abstract class EditIncidentDetailsStates {}

class EditIncidentDetailsInitial extends EditIncidentDetailsStates {}

class EditingIncidentDetails extends EditIncidentDetailsStates {}

class IncidentDetailsEdited extends EditIncidentDetailsStates {
  final EditIncidentDetailsModel editIncidentDetailsModel;

  IncidentDetailsEdited({required this.editIncidentDetailsModel});
}

class IncidentDetailsNotEdited extends EditIncidentDetailsStates {
  final String incidentNotEdited;

  IncidentDetailsNotEdited({required this.incidentNotEdited});
}

class EditIncidentDetailsPhotoSaved extends EditIncidentDetailsStates {
  final SaveReportNewIncidentPhotosModel saveReportNewIncidentPhotosModel;

  EditIncidentDetailsPhotoSaved(
      {required this.saveReportNewIncidentPhotosModel});
}
