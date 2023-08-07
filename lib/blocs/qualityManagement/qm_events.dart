import '../../data/models/incident/save_incident_comments_model.dart';
import '../../data/models/qualityManagement/fetch_qm_classification_model.dart';

abstract class QualityManagementEvent {}

class FetchQualityManagementList extends QualityManagementEvent {
  final int pageNo;

  final bool isFromHome;

  FetchQualityManagementList({required this.isFromHome, required this.pageNo});
}

class FetchQualityManagementDetails extends QualityManagementEvent {
  final String qmId;
  final int initialIndex;

  FetchQualityManagementDetails(
      {required this.initialIndex, required this.qmId});
}

class FetchQualityManagementRoles extends QualityManagementEvent {}

class SelectQualityManagementRole extends QualityManagementEvent {
  final String roleId;

  SelectQualityManagementRole({required this.roleId});
}

class QualityManagementApplyFilter extends QualityManagementEvent {
  final Map filtersMap;

  QualityManagementApplyFilter({required this.filtersMap});
}

class QualityManagementClearFilter extends QualityManagementEvent {}

class SelectQualityManagementStatusFilter extends QualityManagementEvent {
  final List statusList;
  final String statusId;

  SelectQualityManagementStatusFilter(
      {required this.statusList, required this.statusId});
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
