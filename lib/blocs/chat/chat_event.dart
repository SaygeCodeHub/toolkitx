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
  final String replyToMessage;

  RebuildChatMessagingScreen(
      {this.replyToMessage = '', required this.employeeDetailsMap});
}

class FetchChatsList extends ChatEvent {}

class FetchGroupsList extends ChatEvent {}

class FetchAllGroups extends ChatEvent {}

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

class FetchGroupDetails extends ChatEvent {
  final String groupId;

  FetchGroupDetails({required this.groupId});
}

class FetchChatMessage extends ChatEvent {}

class InitializeGroupChatMembers extends ChatEvent {}

class FetchAllGroupChats extends ChatEvent {}

class ReplyToMessage extends ChatEvent {
  String replyToMessage;
  String quoteMessageId;

  ReplyToMessage({this.replyToMessage = '', required this.quoteMessageId});
}

class RemoveChatMember extends ChatEvent {
  final String groupId;
  final String memberId;
  final String memberType;

  RemoveChatMember(
      {required this.groupId,
      required this.memberId,
      required this.memberType});
}

class SetChatMemberAsAdmin extends ChatEvent {
  final String groupId;
  final String memberId;
  final String memberType;

  SetChatMemberAsAdmin(
      {required this.groupId,
      required this.memberId,
      required this.memberType});
}

class DismissChatMemberAsAdmin extends ChatEvent {
  final String groupId;
  final String memberId;
  final String memberType;

  DismissChatMemberAsAdmin(
      {required this.groupId,
      required this.memberId,
      required this.memberType});
}

class AddChatMember extends ChatEvent {
  final String groupId;
  final List membersList;

  AddChatMember({required this.groupId, required this.membersList});
}
