import 'package:hive_flutter/adapters.dart';

abstract class DatabaseUtil {
  static late final Box box;

  static String getText(String textValue) {
    if (box.get(textValue) != null) {
      String text = box.get(textValue);
      return text;
    }
    return '';
  }
}
