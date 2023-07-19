import 'dart:convert';

class ToDoViewDocumentUtil {
  static List viewImageList(String fileName) {
    List files = [];
    files = jsonDecode(jsonEncode(fileName.split(',')));
    return files;
  }
}
