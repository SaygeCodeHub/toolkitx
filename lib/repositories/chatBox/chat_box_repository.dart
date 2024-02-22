import 'package:toolkit/data/models/chatBox/fetch_employees_model.dart';
import 'package:toolkit/data/models/chatBox/send_message_model.dart';

abstract class ChatBoxRepository {
  Future<FetchEmployeesModel> fetchEmployees(String hashCode);

  Future<SendMessageModel> sendMessage(Map sendMessageMap);
}
