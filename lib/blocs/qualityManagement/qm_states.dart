import '../../data/models/incident/save_incident_comments_files_model.dart';
import '../../data/models/incident/save_incident_comments_model.dart';
import '../../data/models/pdf_generation_model.dart';
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
  final List qmPopUpMenu;
  final bool showPopUpMenu;

  QualityManagementDetailsFetched(
      {required this.qmPopUpMenu,
      required this.showPopUpMenu,
      required this.clientId,
      required this.fetchQualityManagementDetailsModel});
}

class QualityManagementDetailsNotFetched extends QualityManagementStates {
  final String detailsNotFetched;

  QualityManagementDetailsNotFetched({required this.detailsNotFetched});
}

class QualityManagementClassificationSelected extends QualityManagementStates {
  final String classificationId;

  QualityManagementClassificationSelected({required this.classificationId});
}

class QualityManagementSavingComments extends QualityManagementStates {}

class QualityManagementCommentsSaved extends QualityManagementStates {
  final SaveIncidentAndQMCommentsModel saveIncidentAndQMCommentsModel;
  final SaveIncidentAndQMCommentsFilesModel saveIncidentAndQMCommentsFilesModel;
  final String qmId;

  QualityManagementCommentsSaved(
      {required this.qmId,
      required this.saveIncidentAndQMCommentsModel,
      required this.saveIncidentAndQMCommentsFilesModel});
}

class QualityManagementCommentsNotSaved extends QualityManagementStates {
  final String commentsNotSaved;

  QualityManagementCommentsNotSaved({required this.commentsNotSaved});
}

class GeneratingQualityManagementPDF extends QualityManagementStates {
  GeneratingQualityManagementPDF();
}

class QualityManagementPDFGenerated extends QualityManagementStates {
  final PdfGenerationModel? pdfGenerationModel;
  final String pdfLink;

  QualityManagementPDFGenerated(
      {this.pdfGenerationModel, required this.pdfLink});
}

class QualityManagementPDFGenerationFailed extends QualityManagementStates {
  final String pdfNoteGenerated;

  QualityManagementPDFGenerationFailed({required this.pdfNoteGenerated});
}
