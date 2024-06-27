import 'package:toolkit/data/models/chatBox/fetch_all_groups_chat_model.dart';
import 'package:toolkit/data/models/chatBox/fetch_employees_model.dart';
import 'package:toolkit/data/models/chatBox/fetch_group_info_model.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class FetchingEmployees extends ChatState {}

class EmployeesFetched extends ChatState {
  final List<EmployeesDatum> employeeList;

  EmployeesFetched({required this.employeeList});
}

class EmployeesNotFetched extends ChatState {
  final String errorMessage;

  EmployeesNotFetched({required this.errorMessage});
}

class CouldNotSendMessage extends ChatState {
  final String errorMessage;

  CouldNotSendMessage({required this.errorMessage});
}

class ChatMessagingScreenHasBeenRebuild extends ChatState {
  final List<Map<String, dynamic>> messages;

  ChatMessagingScreenHasBeenRebuild({required this.messages});
}

class CreatingChatGroup extends ChatState {}

class ChatGroupCreated extends ChatState {}

class ChatGroupCannotCreate extends ChatState {
  final String errorMessage;

  ChatGroupCannotCreate({required this.errorMessage});
}

class EmployeesListSearched extends ChatState {
  final bool isSearchedEnabled;

  EmployeesListSearched({required this.isSearchedEnabled});
}

class ChatMessagingTextFieldHidden extends ChatState {}

class ShowChatMessagingTextField extends ChatState {
  String replyToMessage;

  ShowChatMessagingTextField({this.replyToMessage = ''});
}

class AllGroupsFetching extends ChatState {}

class AllGroupsFetched extends ChatState {
  final AllGroupChatListModel allGroupChatListModel;

  AllGroupsFetched({required this.allGroupChatListModel});
}

class AllGroupsNotFetched extends ChatState {
  final String errorMessage;

  AllGroupsNotFetched({required this.errorMessage});
}

class GroupDetailsFetching extends ChatState {}

class GroupDetailsFetched extends ChatState {
  final FetchGroupInfoModel fetchGroupInfoModel;

  GroupDetailsFetched({required this.fetchGroupInfoModel});
}

class GroupDetailsNotFetched extends ChatState {
  final String errorMessage;

  GroupDetailsNotFetched({required this.errorMessage});
}
