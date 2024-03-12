abstract class ChatEvent {}

class FetchEmployees extends ChatEvent {}

class SendChatMessage extends ChatEvent {
  final Map<String, dynamic> sendMessageMap;

  SendChatMessage({required this.sendMessageMap});
}

class RebuildChatMessagingScreen extends ChatEvent {
  final Map employeeDetailsMap;

  RebuildChatMessagingScreen({required this.employeeDetailsMap});
}

class FetchChatsList extends ChatEvent {}

class CreateChatGroup extends ChatEvent {}

class PickMedia extends ChatEvent {
  final Map mediaDetailsMap;

  PickMedia({required this.mediaDetailsMap});
}
