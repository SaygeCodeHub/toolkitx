import '../../data/models/incident/save_incident_comments_model.dart';
import '../../data/models/qualityManagement/fetch_qm_classification_model.dart';

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
  final FetchQualityManagementClassificationModel
      fetchQualityManagementClassificationModel;

  SelectQualityManagementClassification(
      {required this.fetchQualityManagementClassificationModel,
      required this.classificationId});
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

class GenerateQualityManagementPDF extends QualityManagementEvent {
  GenerateQualityManagementPDF();
}

class FetchQualityManagementClassificationValue
    extends QualityManagementEvent {}
