abstract class ChatEvent {}

class FetchEmployees extends ChatEvent {
  final int pageNo;
  final String searchedName;

  FetchEmployees({required this.pageNo, required this.searchedName});
}

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

class SearchEmployeeList extends ChatEvent {
  final bool isSearchEnabled;

  SearchEmployeeList({required this.isSearchEnabled});
}

class UploadChatImage extends ChatEvent {
  final String pickedImage;
  final Map chatDataMap;

  UploadChatImage({required this.pickedImage, required this.chatDataMap});
}

class FetchGroupInfo extends ChatEvent {
  final String groupId;

  FetchGroupInfo({required this.groupId});
}

class FetchChatMessage extends ChatEvent {}
