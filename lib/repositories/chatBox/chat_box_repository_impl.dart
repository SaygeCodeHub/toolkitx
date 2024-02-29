import 'package:toolkit/data/models/chatBox/create_chat_group_model.dart';
import 'package:toolkit/data/models/chatBox/send_message_model.dart';
import 'package:toolkit/repositories/chatBox/chat_box_repository.dart';
import 'package:toolkit/utils/constants/api_constants.dart';
import 'package:toolkit/utils/dio_client.dart';

import '../../data/models/chatBox/fetch_employees_model.dart';

class CheckBoxRepositoryImpl extends ChatBoxRepository {
  @override
  Future<FetchEmployeesModel> fetchEmployees(String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}common/getallemployees?hashcode=$hashCode");
    return FetchEmployeesModel.fromJson(response);
  }

  @override
  Future<SendMessageModel> sendMessage(Map sendMessageMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}chat/sendmessage", sendMessageMap);
    return SendMessageModel.fromJson(response);
  }

  @override
  Future<CreateChatGroupModel> createChatGroup(Map createChatGroupMap) async {
    print('map------>$createChatGroupMap');
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}chat/creategroup", createChatGroupMap);
    return CreateChatGroupModel.fromJson(response);
  }
}
