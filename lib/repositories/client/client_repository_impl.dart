import 'package:toolkit/data/models/chatBox/fetch_messages_model.dart';
import 'package:toolkit/data/models/client/save_user_device_model.dart';
import 'package:toolkit/repositories/client/client_repository.dart';

import '../../data/models/client/client_list_model.dart';
import '../../data/models/client/home_screen_model.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';

class ClientRepositoryImpl extends ClientRepository {
  @override
  Future<ClientListModel> fetchClientList(
      String clientDataKey, String userType) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}common/gethashkeys?data=$clientDataKey&type=$userType");
    return ClientListModel.fromJson(response);
  }

  @override
  Future<HomeScreenModel> fetchHomeScreen(Map processClientMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}common/processclient", processClientMap);
    return HomeScreenModel.fromJson(response);
  }

  @override
  Future<SaveUserDeviceModel> saveUserDevice(Map saveUserDeviceMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}common/saveuserdevice", saveUserDeviceMap);
    return SaveUserDeviceModel.fromJson(response);
  }

  @override
  Future<FetchChatMessagesModel> fetchChatMessages(Map chatMessagesMap) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}chat/getchatmessages?pageno=${chatMessagesMap['page_no']}&hashcode=${chatMessagesMap['hashcode']}&token=${chatMessagesMap['token']}");
    return FetchChatMessagesModel.fromJson(response);
  }
}
