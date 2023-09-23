class DocumentsEvents {
  DocumentsEvents();
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
