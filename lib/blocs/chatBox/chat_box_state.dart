import 'package:toolkit/data/models/chatBox/fetch_employees_model.dart';

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

class CreatingChatGroup extends ChatBoxState {}

class ChatGroupCreated extends ChatBoxState {}

class ChatGroupCannotCreate extends ChatBoxState {
  final String errorMessage;

  ChatGroupCannotCreate({required this.errorMessage});
}
