import 'package:toolkit/data/models/chatBox/fetch_employees_model.dart';
import 'package:toolkit/screens/chatBox/widgets/chat_details_model_class.dart';

abstract class ChatBoxState {}

class ChatBoxInitial extends ChatBoxState {}

class FetchingEmployees extends ChatBoxState {}

class EmployeesFetched extends ChatBoxState {
  final FetchEmployeesModel fetchEmployeesModel;

  EmployeesFetched({required this.fetchEmployeesModel});
}

class EmployeesNotFetched extends ChatBoxState {
  final String errorMessage;

  EmployeesNotFetched({required this.errorMessage});
}

class CouldNotSendMessage extends ChatBoxState {
  final String errorMessage;

  CouldNotSendMessage({required this.errorMessage});
}

class ChatHasBeenRebuild extends ChatBoxState {
  final List<Map<String, dynamic>> messages;

  ChatHasBeenRebuild({required this.messages});
}

class ChatListFetched extends ChatBoxState {
  final List<Chat> chatsList;

  ChatListFetched({required this.chatsList});
}
