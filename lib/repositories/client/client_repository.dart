import 'package:toolkit/data/models/chatBox/fetch_messages_model.dart';
import 'package:toolkit/data/models/client/client_list_model.dart';
import 'package:toolkit/data/models/client/home_screen_model.dart';

import '../../data/models/client/save_user_device_model.dart';

abstract class ClientRepository {
  Future<ClientListModel> fetchClientList(
      String clientDataKey, String userType);

  Future<HomeScreenModel> fetchHomeScreen(Map processClientMap);

  Future<SaveUserDeviceModel> saveUserDevice(Map saveUserDeviceMap);

  Future<FetchChatMessagesModel> fetchChatMessages(Map chatMessagesMap);
}
