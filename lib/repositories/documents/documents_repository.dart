import 'package:toolkit/data/models/documents/documents_list_model.dart';

abstract class DocumentsRepository {
  Future<DocumentsListModel> getDocumentsList(
      String userId, String hashCode, Map filter, String role, int page);
}
