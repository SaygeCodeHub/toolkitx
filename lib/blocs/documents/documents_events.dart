class DocumentsEvents {
  DocumentsEvents();
}

class GetDocumentsList extends DocumentsEvents {
  final int page;
  final bool isFromHome;

  GetDocumentsList({required this.page, this.isFromHome = false});
}
