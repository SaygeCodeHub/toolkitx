import 'package:toolkit/data/models/chatBox/create_chat_group_model.dart';
import 'package:toolkit/data/models/chatBox/send_message_model.dart';
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
}
