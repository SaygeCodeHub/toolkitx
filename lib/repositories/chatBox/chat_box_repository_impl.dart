import 'package:toolkit/data/models/chatBox/add_chat_member_model.dart';
import 'package:toolkit/data/models/chatBox/create_chat_group_model.dart';
import 'package:toolkit/data/models/chatBox/dismiss_chat_member_as_admin_model.dart';
import 'package:toolkit/data/models/chatBox/fetch_all_groups_chat_model.dart';
import 'package:toolkit/data/models/chatBox/fetch_group_info_model.dart';
import 'package:toolkit/data/models/chatBox/remove_chat_member_model.dart';
import 'package:toolkit/data/models/chatBox/send_message_model.dart';
import 'package:toolkit/data/models/chatBox/set_chat_member_as_admin_model.dart';
import 'package:toolkit/repositories/chatBox/chat_box_repository.dart';
import 'package:toolkit/utils/constants/api_constants.dart';
import 'package:toolkit/utils/dio_client.dart';

import '../../data/models/chatBox/fetch_employees_model.dart';

class CheckBoxRepositoryImpl extends ChatBoxRepository {
  @override
  Future<FetchEmployeesModel> fetchEmployees(
      int pageNo, String hashCode, String searchName) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}chat/GetAllUsers?pageno=$pageNo&hashcode=$hashCode&search=$searchName");
    return FetchEmployeesModel.fromJson(response);
  }

  @override
  Future<SendMessageModel> sendMessage(Map sendMessageMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}chat/sendmessagenew", sendMessageMap);
    return SendMessageModel.fromJson(response);
  }

  @override
  Future<CreateChatGroupModel> createChatGroup(Map createChatGroupMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}chat/creategroup", createChatGroupMap);
    return CreateChatGroupModel.fromJson(response);
  }

  @override
  Future<FetchGroupInfoModel> fetchGroupInfo(Map groupInfoMap) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}chat/GetGroupInfo?hashcode=${groupInfoMap['hashcode']}&groupid=${groupInfoMap['group_id']}");
    return FetchGroupInfoModel.fromJson(response);
  }

  @override
  Future<AllGroupChatListModel> fetchAllGroupChatList(
      String hashCode, String userId, String userType) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}chat/GetAllMyGroups?hashcode=$hashCode&userid=$userId&usertype=$userType");
    return AllGroupChatListModel.fromJson(response);
  }

  @override
  Future<AllGroupChatListModel> fetchAllGroup(
      String hashCode, String userId, String userType) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}chat/GetAllMyGroups?hashcode=$hashCode&userid=$userId&usertype=$userType");
    return AllGroupChatListModel.fromJson(response);
  }

  @override
  Future<FetchGroupInfoModel> fetchGroupDetails(
      String hashCode, String groupId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}chat/GetGroupInfo?hashcode=$hashCode&groupid=$groupId");
    return FetchGroupInfoModel.fromJson(response);
  }

  @override
  Future<DismissChatMemberAsAdminModel> dismissChatMemberAsAdmin(
      Map dismissChatMemberAsAdminMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}chat/DismissChatMemberAsAdmin",
        dismissChatMemberAsAdminMap);
    print('dismissResponse==============>$response');
    return DismissChatMemberAsAdminModel.fromJson(response);
  }

  @override
  Future<RemoveChatMemberModel> removeChatMember(
      Map removeChatMemberMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}chat/SetChatMemberAsAdmin",
        removeChatMemberMap);
    print('RemoveResponse==============>$response');
    return RemoveChatMemberModel.fromJson(response);
  }

  @override
  Future<SetChatMemberAsAdminModel> setChatMemberAsAdmin(
      Map setChatMemberAsAdminMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}chat/RemoveChatMember",
        setChatMemberAsAdminMap);
    print('SetResponse==============>$response');
    return SetChatMemberAsAdminModel.fromJson(response);
  }

  @override
  Future<AddChatMemberModel> addChatMember(Map addChatMemberMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}chat/AddChatMember", addChatMemberMap);
    return AddChatMemberModel.fromJson(response);
  }
}
