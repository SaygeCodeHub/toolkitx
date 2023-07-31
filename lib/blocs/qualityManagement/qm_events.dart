import '../../data/models/incident/save_incident_comments_model.dart';

abstract class QualityManagementEvent {}

class FetchQualityManagementList extends QualityManagementEvent {
  final int pageNo;

  FetchQualityManagementList({required this.pageNo});
}

class FetchQualityManagementDetails extends QualityManagementEvent {
  final String qmId;
  final int initialIndex;

  FetchQualityManagementDetails(
      {required this.initialIndex, required this.qmId});
}

class SelectQualityManagementClassification extends QualityManagementEvent {
  final String classificationId;

  SelectQualityManagementClassification({required this.classificationId});
}

class SaveQualityManagementComments extends QualityManagementEvent {
  final Map saveCommentsMap;

  SaveQualityManagementComments({required this.saveCommentsMap});
}

class SaveQualityManagementCommentsFiles extends QualityManagementEvent {
  final Map saveCommentsMap;
  final SaveIncidentAndQMCommentsModel saveIncidentAndQMCommentsModel;

  SaveQualityManagementCommentsFiles(
      {required this.saveIncidentAndQMCommentsModel,
      required this.saveCommentsMap});
}
