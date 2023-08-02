import 'dart:convert';

class ViewImageUtil {
  static List viewImageList(String fileName) {
    List files = [];
    files = jsonDecode(jsonEncode(fileName.split(',')));
    return files;
  }
}
