import 'package:equatable/equatable.dart';
import 'package:toolkit/data/models/documents/document_master_model.dart';
import 'package:toolkit/data/models/documents/document_roles_model.dart';
import 'package:toolkit/data/models/documents/document_upload_file_version_model.dart';

import '../../data/models/documents/documents_details_models.dart';
import '../../data/models/documents/documents_list_model.dart';
import '../../data/models/documents/documents_to_link_model.dart';
import '../../data/models/documents/post_document_model.dart';

class DocumentsStates extends Equatable {
  const DocumentsStates();

  @override
  List<Object?> get props => [];
}

class DocumentsInitial extends DocumentsStates {
  const DocumentsInitial();
}

class FetchingDocumentsList extends DocumentsStates {
  const FetchingDocumentsList();
}

class DocumentsListFetched extends DocumentsStates {
  final DocumentsListModel documentsListModel;

  const DocumentsListFetched({required this.documentsListModel});

  @override
  List<Object?> get props => [documentsListModel];
}

class DocumentsListError extends DocumentsStates {
  final String message;

  const DocumentsListError({required this.message});
}

class FetchingDocumentRoles extends DocumentsStates {
  const FetchingDocumentRoles();
}

class DocumentRolesFetched extends DocumentsStates {
  final DocumentRolesModel documentRolesModel;
  final String? roleId;

  const DocumentRolesFetched(
      {required this.roleId, required this.documentRolesModel});
}

class CouldNotFetchDocumentRoles extends DocumentsStates {
  const CouldNotFetchDocumentRoles();
}

class DocumentRoleSelected extends DocumentsStates {
  const DocumentRoleSelected();
}

class FetchingDocumentMaster extends DocumentsStates {}

class DocumentMasterFetched extends DocumentsStates {
  final FetchDocumentMasterModel fetchDocumentMasterModel;

  const DocumentMasterFetched({required this.fetchDocumentMasterModel});
}

class DocumentMasterError extends DocumentsStates {
  final String fetchError;

  const DocumentMasterError({required this.fetchError});
}

class DocumentStatusFilterSelected extends DocumentsStates {
  final String selectedIndex;

  const DocumentStatusFilterSelected({required this.selectedIndex});

  @override
  List<Object?> get props => [selectedIndex];
}

class DocumentTypeFilterSelected extends DocumentsStates {
  final String selectedType;

  const DocumentTypeFilterSelected({required this.selectedType});

  @override
  List<Object?> get props => [selectedType];
}

class FetchingDocumentsDetails extends DocumentsStates {
  const FetchingDocumentsDetails();
}

class DocumentsDetailsFetched extends DocumentsStates {
  final DocumentDetailsModel documentDetailsModel;
  final List documentsPopUpMenu;
  final String clientId;

  const DocumentsDetailsFetched(
      {required this.documentDetailsModel,
      required this.documentsPopUpMenu,
      required this.clientId});
}

class DocumentsDetailsError extends DocumentsStates {
  final String message;

  const DocumentsDetailsError({required this.message});
}

class FetchingDocumentsToLink extends DocumentsStates {
  const FetchingDocumentsToLink();
}

class DocumentsToLinkFetched extends DocumentsStates {
  final DocumentsToLinkModel documentsToLinkModel;
  final List<DocumentsToLinkData> documentsToLinkList;

  const DocumentsToLinkFetched(
      {required this.documentsToLinkModel, required this.documentsToLinkList});

  @override
  List<Object?> get props => [documentsToLinkList];
}

class DocumentsToLinkError extends DocumentsStates {
  final String message;

  const DocumentsToLinkError({required this.message});
}

class SavingLikedDocuments extends DocumentsStates {
  const SavingLikedDocuments();
}

class LikedDocumentsSaved extends DocumentsStates {
  final PostDocumentsModel saveLinkedDocumentsModel;

  const LikedDocumentsSaved({required this.saveLinkedDocumentsModel});
}

class SaveLikedDocumentsError extends DocumentsStates {
  final String message;

  const SaveLikedDocumentsError({required this.message});
}

class AttachingDocuments extends DocumentsStates {
  const AttachingDocuments();
}

class DocumentsAttached extends DocumentsStates {
  final PostDocumentsModel postDocumentsModel;

  const DocumentsAttached({required this.postDocumentsModel});
}

class AttachDocumentsError extends DocumentsStates {
  final String message;

  const AttachDocumentsError({required this.message});
}

class DocumentFileVersionUploading extends DocumentsStates {}

class DocumentFileVersionUploaded extends DocumentsStates {
  final DocumentUploadFileVersionModel documentUploadFileVersionModel;

  const DocumentFileVersionUploaded(
      {required this.documentUploadFileVersionModel});
}

class DocumentFileVersionNotUploaded extends DocumentsStates {
  final String errorMessage;

  const DocumentFileVersionNotUploaded({required this.errorMessage});
}

class DeletingDocuments extends DocumentsStates {
  const DeletingDocuments();
}

class DocumentsDeleted extends DocumentsStates {
  final PostDocumentsModel postDocumentsModel;

  const DocumentsDeleted({required this.postDocumentsModel});
}

class DeleteDocumentsError extends DocumentsStates {
  final String message;

  const DeleteDocumentsError({required this.message});
}

class OpeningDocumentsForInformation extends DocumentsStates {
  const OpeningDocumentsForInformation();
}

class DocumentOpenedForInformation extends DocumentsStates {
  final PostDocumentsModel postDocumentsModel;

  const DocumentOpenedForInformation({required this.postDocumentsModel});
}

class OpenDocumentsForInformationError extends DocumentsStates {
  final String message;

  const OpenDocumentsForInformationError({required this.message});
}

class OpeningDocumentsForReview extends DocumentsStates {
  const OpeningDocumentsForReview();
}

class DocumentOpenedForReview extends DocumentsStates {
  final PostDocumentsModel postDocumentsModel;

  const DocumentOpenedForReview({required this.postDocumentsModel});
}

class OpenDocumentsForReviewError extends DocumentsStates {
  final String message;

  const OpenDocumentsForReviewError({required this.message});
}

class ApprovingDocuments extends DocumentsStates {
  const ApprovingDocuments();
}

class DocumentsApproved extends DocumentsStates {
  final PostDocumentsModel postDocumentsModel;

  const DocumentsApproved({required this.postDocumentsModel});
}

class ApproveDocumentsError extends DocumentsStates {
  final String message;

  const ApproveDocumentsError({required this.message});
}

class RejectingDocuments extends DocumentsStates {
  const RejectingDocuments();
}

class DocumentsRejected extends DocumentsStates {
  final PostDocumentsModel postDocumentsModel;

  const DocumentsRejected({required this.postDocumentsModel});
}

class RejectDocumentsError extends DocumentsStates {
  final String message;

  const RejectDocumentsError({required this.message});
}

class WithdrawingDocuments extends DocumentsStates {
  const WithdrawingDocuments();
}

class DocumentsWithdrawn extends DocumentsStates {
  final PostDocumentsModel postDocumentsModel;

  const DocumentsWithdrawn({required this.postDocumentsModel});
}

class WithdrawDocumentsError extends DocumentsStates {
  final String message;

  const WithdrawDocumentsError({required this.message});
}

class ClosingDocuments extends DocumentsStates {
  const ClosingDocuments();
}

class DocumentsClosed extends DocumentsStates {
  final PostDocumentsModel postDocumentsModel;

  const DocumentsClosed({required this.postDocumentsModel});
}

class CloseDocumentsError extends DocumentsStates {
  final String message;

  const CloseDocumentsError({required this.message});
}

class SavingDocumentComments extends DocumentsStates {
  const SavingDocumentComments();
}

class DocumentCommentsSaved extends DocumentsStates {}

class SaveDocumentCommentsError extends DocumentsStates {
  final String errorMessage;

  const SaveDocumentCommentsError({required this.errorMessage});
}
