import '../data/models/documents/documents_details_models.dart';

class DocumentsFileMenuUtil {
  static List<String> fileMenuOptions(FileList fileListData) {
    List<String> fileMenuOptionsList = ['View'];
    if (fileListData.canuploadnewversion == '1') {
      fileMenuOptionsList.add('Upload New Version');
    }
    if (fileListData.candelete == '1') {
      fileMenuOptionsList.add('Delete');
    }
    if (fileListData.canaddcomments == '1') {
      fileMenuOptionsList.add('Add Comment');
    }
    return fileMenuOptionsList;
  }
}
