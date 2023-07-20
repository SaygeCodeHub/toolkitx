import 'package:equatable/equatable.dart';

import '../../../data/models/incident/fetch_permit_to_link_model.dart';
import '../../../data/models/incident/incident_details_model.dart';
import '../../../data/models/incident/save_incident_comments_files_model.dart';
import '../../../data/models/incident/save_incident_comments_model.dart';
import '../../../data/models/pdf_generation_model.dart';
import '../../../data/models/incident/saved_linked_permit_model.dart';

abstract class IncidentDetailsStates extends Equatable {
  const IncidentDetailsStates();

  @override
  List<Object?> get props => [];
}

class IncidentDetailsInitial extends IncidentDetailsStates {
  const IncidentDetailsInitial();

  @override
  List<Object?> get props => [];
}

class FetchingIncidentDetails extends IncidentDetailsStates {
  const FetchingIncidentDetails();

  @override
  List<Object?> get props => [];
}

class IncidentDetailsFetched extends IncidentDetailsStates {
  final IncidentDetailsModel incidentDetailsModel;
  final String clientId;
  final List incidentPopUpMenu;
  final bool showPopUpMenu;

  const IncidentDetailsFetched(
      {required this.clientId,
      required this.incidentDetailsModel,
      required this.incidentPopUpMenu,
      required this.showPopUpMenu});

  @override
  List<Object?> get props => [];
}

class IncidentDetailsNotFetched extends IncidentDetailsStates {
  const IncidentDetailsNotFetched();

  @override
  List<Object?> get props => [];
}

class GeneratingIncidentPDF extends IncidentDetailsStates {
  const GeneratingIncidentPDF();
}

class IncidentPDFGenerated extends IncidentDetailsStates {
  final PdfGenerationModel? pdfGenerationModel;
  final String pdfLink;

  const IncidentPDFGenerated({this.pdfGenerationModel, required this.pdfLink});
}

class IncidentPDFGenerationFailed extends IncidentDetailsStates {
  const IncidentPDFGenerationFailed();
}

class FetchingPermitToLink extends IncidentDetailsStates {}

class FetchedPermitToLink extends IncidentDetailsStates {
  final FetchPermitToLinkModel fetchPermitToLinkModel;

  const FetchedPermitToLink({required this.fetchPermitToLinkModel});
}

class FetchPermitToLinkError extends IncidentDetailsStates {}

class SavingLinkedPermits extends IncidentDetailsStates {}

class SavedLinkedPermits extends IncidentDetailsStates {
  final SaveLinkedPermitModel saveLinkedPermitModel;

  const SavedLinkedPermits({required this.saveLinkedPermitModel});
}

class LinkedPermitsNotSaved extends IncidentDetailsStates {
  final String permitNotSavedMessage;

  const LinkedPermitsNotSaved({required this.permitNotSavedMessage});
}

class SavingIncidentComments extends IncidentDetailsStates {}

class IncidentCommentsSaved extends IncidentDetailsStates {
  final SaveIncidentCommentsModel saveIncidentCommentsModel;

  const IncidentCommentsSaved({required this.saveIncidentCommentsModel});
}

class IncidentCommentsNotSaved extends IncidentDetailsStates {
  final String commentsNotSaved;

  const IncidentCommentsNotSaved({required this.commentsNotSaved});
}

class SavingIncidentCommentsFiles extends IncidentDetailsStates {}

class IncidentCommentsFilesSaved extends IncidentDetailsStates {
  final SaveIncidentCommentsFilesModel saveIncidentCommentsModel;

  const IncidentCommentsFilesSaved({required this.saveIncidentCommentsModel});
}

class IncidentCommentsFilesNotSaved extends IncidentDetailsStates {
  final String commentsFilesNotSaved;

  const IncidentCommentsFilesNotSaved({required this.commentsFilesNotSaved});
}
