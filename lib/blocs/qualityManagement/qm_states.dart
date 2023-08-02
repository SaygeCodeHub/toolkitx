import '../../data/models/qualityManagement/fetch_qm_details_model.dart';
import '../../data/models/qualityManagement/fetch_qm_list_model.dart';

abstract class QualityManagementStates {}

class QualityManagementInitial extends QualityManagementStates {}

class FetchingQualityManagementList extends QualityManagementStates {}

class QualityManagementListFetched extends QualityManagementStates {
  final FetchQualityManagementListModel fetchQualityManagementListModel;

  QualityManagementListFetched({required this.fetchQualityManagementListModel});
}

class FetchingQualityManagementDetails extends QualityManagementStates {}

class QualityManagementDetailsFetched extends QualityManagementStates {
  final FetchQualityManagementDetailsModel fetchQualityManagementDetailsModel;
  final String clientId;

  QualityManagementDetailsFetched(
      {required this.clientId,
      required this.fetchQualityManagementDetailsModel});
}

class QualityManagementDetailsNotFetched extends QualityManagementStates {
  final String detailsNotFetched;

  QualityManagementDetailsNotFetched({required this.detailsNotFetched});
}
