class DocumentsEvents {
  const DocumentsEvents();
}

class GetDocumentsList extends DocumentsEvents {
  final int page;
  final bool isFromHome;

  GetDocumentsList({required this.page, this.isFromHome = false});
}

class GetDocumentRoles extends DocumentsEvents {
  GetDocumentRoles();
}

class SelectDocumentRoleEvent extends DocumentsEvents {
  final String roleId;

  SelectDocumentRoleEvent(this.roleId);
}

class FetchDocumentMaster extends DocumentsEvents {}

class SelectDocumentStatusFilter extends DocumentsEvents {
  final String selectedIndex;

  SelectDocumentStatusFilter({required this.selectedIndex});
}

class SelectDocumentLocationFilter extends DocumentsEvents {
  final String selectedType;

  SelectDocumentLocationFilter({required this.selectedType});
}

class ApplyDocumentFilter extends DocumentsEvents {
  final Map filterMap;

  ApplyDocumentFilter({required this.filterMap});
}

class ClearDocumentFilter extends DocumentsEvents {}

class GetDocumentsDetails extends DocumentsEvents {
  const GetDocumentsDetails();
}

class GetDocumentsToLink extends DocumentsEvents {
  final int page;

  const GetDocumentsToLink({required this.page});
}

class SaveLinkedDocuments extends DocumentsEvents {
  final String linkedDocuments;

  SaveLinkedDocuments({required this.linkedDocuments});
}

class AttachDocuments extends DocumentsEvents {
  final Map attachDocumentsMap;

  AttachDocuments({required this.attachDocumentsMap});
}

class UploadDocumentFileVersion extends DocumentsEvents {
  final Map uploadFileVersionMap;

  UploadDocumentFileVersion({required this.uploadFileVersionMap});
}

class DeleteDocuments extends DocumentsEvents {
  final String fileId;

  DeleteDocuments({required this.fileId});
}

class OpenDocumentsForInformation extends DocumentsEvents {}

class OpenDocumentsForReview extends DocumentsEvents {
  final String dueDate;

  OpenDocumentsForReview({required this.dueDate});
}

class ApproveDocument extends DocumentsEvents {
  final String comment;

  ApproveDocument({required this.comment});
}

class RejectDocument extends DocumentsEvents {
  final String documentId;
  final String comment;

  RejectDocument({required this.documentId, required this.comment});
}

class WithdrawDocument extends DocumentsEvents {}

class CloseDocument extends DocumentsEvents {
  final String documentId;

  CloseDocument({required this.documentId});
}

class SaveDocumentComments extends DocumentsEvents {
  final Map saveDocumentsCommentsMap;

  SaveDocumentComments({required this.saveDocumentsCommentsMap});
}
