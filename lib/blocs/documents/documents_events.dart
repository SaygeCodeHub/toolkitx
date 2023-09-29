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
