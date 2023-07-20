abstract class EditIncidentDetailsEvent {}

class EditIncidentDetails extends EditIncidentDetailsEvent {
  final Map editIncidentMap;

  EditIncidentDetails({required this.editIncidentMap});
}

class SaveEditIncidentDetailsPhotos extends EditIncidentDetailsEvent {
  final Map editIncidentDetailsMap;

  SaveEditIncidentDetailsPhotos({required this.editIncidentDetailsMap});
}
