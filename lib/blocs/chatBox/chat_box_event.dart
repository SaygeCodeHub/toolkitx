abstract class ChatBoxEvent {}

class FetchEmployees extends ChatBoxEvent {}

class SendMessage extends ChatBoxEvent {
  final Map<String, dynamic> sendMessageMap;

  SendMessage({required this.sendMessageMap});
}

class RebuildChat extends ChatBoxEvent {
  final Map employeeDetailsMap;

  RebuildChat({required this.employeeDetailsMap});
}

class FetchChatsList extends ChatBoxEvent {}
