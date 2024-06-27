import 'package:toolkit/data/models/chatBox/create_chat_group_model.dart';
import 'package:toolkit/data/models/chatBox/fetch_employees_model.dart';
import 'package:toolkit/data/models/chatBox/fetch_group_info_model.dart';
import 'package:toolkit/data/models/chatBox/send_message_model.dart';

import '../../data/models/chatBox/fetch_all_groups_chat_model.dart';

abstract class ChatBoxRepository {
  Future<FetchEmployeesModel> fetchEmployees(
      int pageNo, String hashCode, String searchName);

  Future<SendMessageModel> sendMessage(Map sendMessageMap);

  Future<CreateChatGroupModel> createChatGroup(Map createChatGroupMap);

  Future<FetchGroupInfoModel> fetchGroupInfo(Map groupInfoMap);
  Future<AllGroupChatList> fetchAllGroupChatList(
      String hashCode, String userId, String userType);
}
