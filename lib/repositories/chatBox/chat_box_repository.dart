import 'package:toolkit/data/models/chatBox/add_chat_member_model.dart';
import 'package:toolkit/data/models/chatBox/create_chat_group_model.dart';
import 'package:toolkit/data/models/chatBox/dismiss_chat_member_as_admin_model.dart';
import 'package:toolkit/data/models/chatBox/fetch_employees_model.dart';
import 'package:toolkit/data/models/chatBox/fetch_group_info_model.dart';
import 'package:toolkit/data/models/chatBox/remove_chat_member_model.dart';
import 'package:toolkit/data/models/chatBox/send_message_model.dart';
import 'package:toolkit/data/models/chatBox/set_chat_member_as_admin_model.dart';

import '../../data/models/chatBox/fetch_all_groups_chat_model.dart';

abstract class ChatBoxRepository {
  Future<FetchEmployeesModel> fetchEmployees(
      int pageNo, String hashCode, String searchName);

  Future<SendMessageModel> sendMessage(Map sendMessageMap);

  Future<CreateChatGroupModel> createChatGroup(Map createChatGroupMap);

  Future<FetchGroupInfoModel> fetchGroupInfo(Map groupInfoMap);

  Future<FetchGroupInfoModel> fetchGroupDetails(
      String hashCode, String groupId);

  Future<AllGroupChatListModel> fetchAllGroupChatList(
      String hashCode, String userId, String userType);

  Future<AllGroupChatListModel> fetchAllGroup(
      String hashCode, String userId, String userType);

  Future<RemoveChatMemberModel> removeChatMember(Map removeChatMemberMap);

  Future<SetChatMemberAsAdminModel> setChatMemberAsAdmin(
      Map setChatMemberAsAdminMap);

  Future<DismissChatMemberAsAdminModel> dismissChatMemberAsAdmin(
      Map dismissChatMemberAsAdminMap);

  Future<AddChatMemberModel> addChatMember(Map addChatMemberMap);
}
